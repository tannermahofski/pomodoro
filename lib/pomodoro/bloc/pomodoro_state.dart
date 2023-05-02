part of 'pomodoro_bloc.dart';

abstract class PomodoroState extends Equatable {
  const PomodoroState({
    required this.duration,
    required this.session,
    required this.maxDuration,
    required this.workingSessionCounter,
  });

  final int duration;
  final Session session;
  final int maxDuration;
  final int workingSessionCounter;

  @override
  List<Object> get props => [duration];
}

class PomodoroInitial extends PomodoroState {
  const PomodoroInitial({
    required super.duration,
    required super.session,
    required super.maxDuration,
    required super.workingSessionCounter,
  });
}

class PomodoroRunPause extends PomodoroState {
  const PomodoroRunPause({
    required super.duration,
    required super.session,
    required super.maxDuration,
    required super.workingSessionCounter,
  });
}

class PomodoroRunInProgress extends PomodoroState {
  const PomodoroRunInProgress({
    required super.duration,
    required super.session,
    required super.maxDuration,
    required super.workingSessionCounter,
  });
}

class PomodoroRunComplete extends PomodoroState {
  const PomodoroRunComplete({
    required super.session,
    required super.maxDuration,
    required super.workingSessionCounter,
  }) : super(duration: 0);
}
