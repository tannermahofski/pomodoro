part of 'pomodoro_bloc.dart';

abstract class PomodoroEvent extends Equatable {
  const PomodoroEvent();

  @override
  List<Object> get props => [];
}

class PomodoroStarted extends PomodoroEvent {
  const PomodoroStarted({required this.duration});

  final int duration;
}

class PomodoroPaused extends PomodoroEvent {
  const PomodoroPaused();
}

class PomodoroResumed extends PomodoroEvent {
  const PomodoroResumed();
}

class PomodoroReset extends PomodoroEvent {
  const PomodoroReset();
}

class _PomodoroTicked extends PomodoroEvent {
  const _PomodoroTicked({required this.duration});

  final int duration;
}
