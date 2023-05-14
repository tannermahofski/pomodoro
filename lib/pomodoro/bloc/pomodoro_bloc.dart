import 'dart:async';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_timer/pomodoro/helper/session_helper.dart';
import 'package:pomodoro_timer/repositories/abstract_database_repository.dart';
import 'package:pomodoro_timer/shared_models/task.dart';
import 'package:pomodoro_timer/ticker.dart';

part 'pomodoro_event.dart';
part 'pomodoro_state.dart';

class PomodoroBloc extends Bloc<PomodoroEvent, PomodoroState> {
  PomodoroBloc({
    required Ticker ticker,
    required Task task,
    required AbstractDatabaseRepository databaseRepository,
    required String userId,
  })  : _ticker = ticker,
        _task = task,
        _databaseRepository = databaseRepository,
        _userId = userId,
        super(
          PomodoroInitial(
            duration: task.workingDuration * 60,
            session: Session.working,
            maxDuration: task.workingDuration * 60,
            workingSessionCounter: 0,
          ),
        ) {
    on<PomodoroStarted>(_onPomodoroStarted);
    on<PomodoroPaused>(_onPomodoroPaused);
    on<PomodoroResumed>(_onPomodoroResumed);
    on<PomodoroReset>(_onPomodoroReset);
    on<_PomodoroTicked>(_onPomodoroTicked);

    sessionTimingMap = {
      Session.working: task.workingDuration * 60,
      Session.shortBreak: task.shortBreakDuration * 60,
      Session.longBreak: task.longBreakDuration * 60,
    };

    _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
    _audio = Audio('assets/sounds/jungle.mp3');
    _assetsAudioPlayer.open(_audio,
        autoStart: false, loopMode: LoopMode.single);
  }

  final Ticker _ticker;
  final Task _task;
  late final Map<Session, int> sessionTimingMap;
  final AbstractDatabaseRepository _databaseRepository;
  final String _userId;
  late final AssetsAudioPlayer _assetsAudioPlayer;
  late final Audio _audio;

  StreamSubscription<int>? _tickerSubscription;

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  Future<void> _onPomodoroStarted(
    PomodoroStarted event,
    Emitter<PomodoroState> emit,
  ) async {
    if (_task.currentStatus.workingStatus != WorkingStatus.inProgress) {
      await _databaseRepository.updateTask(
        userId: _userId,
        updatedTask: _task.copyWith(
          currentStatus: CurrentStatus(
            workingStatus: WorkingStatus.inProgress,
            date: DateTime.now(),
          ),
        ),
      );
    }
    int currentWorkingSession = state.workingSessionCounter;
    if (state.session == Session.working) {
      currentWorkingSession = state.workingSessionCounter + 1;
      if (!_assetsAudioPlayer.isPlaying.value) {
        await _assetsAudioPlayer.play();
      }
    }
    emit(
      PomodoroRunInProgress(
        duration: event.duration,
        session: state.session,
        maxDuration: state.maxDuration,
        workingSessionCounter: currentWorkingSession,
      ),
    );

    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration.toInt())
        .listen((duration) => add(_PomodoroTicked(duration: duration)));
  }

  void _onPomodoroPaused(
    PomodoroPaused event,
    Emitter<PomodoroState> emit,
  ) {
    if (state is PomodoroRunInProgress) {
      _tickerSubscription?.pause();

      emit(
        PomodoroRunPause(
          duration: state.duration,
          session: state.session,
          maxDuration: state.maxDuration,
          workingSessionCounter: state.workingSessionCounter,
        ),
      );
    }
  }

  void _onPomodoroResumed(
    PomodoroResumed event,
    Emitter<PomodoroState> emit,
  ) {
    if (state is PomodoroRunPause) {
      _tickerSubscription?.resume();
      emit(
        PomodoroRunInProgress(
          duration: state.duration,
          session: state.session,
          maxDuration: state.maxDuration,
          workingSessionCounter: state.workingSessionCounter,
        ),
      );
    }
  }

  void _onPomodoroReset(
    PomodoroReset event,
    Emitter<PomodoroState> emit,
  ) {
    _tickerSubscription?.cancel();
    emit(
      PomodoroInitial(
        duration: _task.workingDuration * 60,
        session: state.session,
        maxDuration: state.maxDuration,
        workingSessionCounter: state.workingSessionCounter,
      ),
    );
  }

  Future<void> _onPomodoroTicked(
    _PomodoroTicked event,
    Emitter<PomodoroState> emit,
  ) async {
    if (event.duration > 0) {
      emit(
        PomodoroRunInProgress(
          duration: event.duration,
          session: state.session,
          maxDuration: state.maxDuration,
          workingSessionCounter: state.workingSessionCounter,
        ),
      );
    } else {
      if (_assetsAudioPlayer.isPlaying.value) {
        await _assetsAudioPlayer.pause();
      }

      Session nextSession;
      int workingSessionCounter = state.workingSessionCounter;

      if (workingSessionCounter >= _task.numberOfWorkingSessions) {
        emit(
          PomodoroRunComplete(
            session: Session.longBreak,
            maxDuration: 0,
            workingSessionCounter: workingSessionCounter,
          ),
        );

        CurrentStatus currentStatus = CurrentStatus(
          workingStatus: WorkingStatus.completed,
          date: DateTime.now(),
        );

        Task task = _task.copyWith(currentStatus: currentStatus);

        await _databaseRepository.updateTask(
          userId: _userId,
          updatedTask: task,
        );
        return;
      }

      if (state.session == Session.working) {
        nextSession = Session.shortBreak;
      } else {
        nextSession = Session.working;
      }

      int duration = sessionTimingMap[nextSession]!;
      emit(
        PomodoroInitial(
          duration: duration,
          session: nextSession,
          maxDuration: duration,
          workingSessionCounter: workingSessionCounter,
        ),
      );
      add(PomodoroStarted(duration: duration));
    }
  }
}
