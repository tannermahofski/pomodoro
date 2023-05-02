import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:pomodoro_timer/helpers/constants/color_constants.dart';
import 'package:pomodoro_timer/helpers/widgets/button/stretched_elevated_button.dart';
import 'package:pomodoro_timer/pomodoro/bloc/pomodoro_bloc.dart';
import 'package:pomodoro_timer/pomodoro/helper/session_helper.dart';
import 'package:pomodoro_timer/shared_models/task.dart';
import 'package:pomodoro_timer/ticker.dart';

class PomodoroPage extends StatelessWidget {
  static Route<void> route(Task task) => MaterialPageRoute(
        builder: (context) => PomodoroPage(
          task: task,
        ),
      );

  const PomodoroPage({super.key, required Task task}) : _task = task;

  final Task _task;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PomodoroBloc>(
      create: (context) => PomodoroBloc(
        ticker: const Ticker(),
        task: _task,
      ),
      child: PomodoroPageListener(
        task: _task,
      ),
    );
  }
}

class PomodoroPageListener extends StatelessWidget {
  const PomodoroPageListener({
    required Task task,
    super.key,
  }) : _task = task;

  final Task _task;

  @override
  Widget build(BuildContext context) {
    return BlocListener<PomodoroBloc, PomodoroState>(
      listener: (context, state) {
        if (state is PomodoroRunComplete) {
          showCompletionDialog(context);
        }
      },
      child: PomodoroPageContainer(
        task: _task,
      ),
    );
  }

  Future<void> showCompletionDialog(BuildContext context) async {
    AwesomeDialog(
      context: context,
      animType: AnimType.scale,
      customHeader: Transform.scale(
        scale: 2.5,
        child: const CircleAvatar(
          backgroundColor: kPear,
          child: Icon(
            Icons.check,
            color: Colors.white,
          ),
        ),
      ),
      headerAnimationLoop: false,
      body: const Center(
        child: Text('You have completed the task!'),
      ),
      btnOkText: 'Dismiss',
      btnOkColor: kPear,
      btnOkIcon: Icons.check,
      btnOkOnPress: () {},
    ).show();
  }
}

class PomodoroPageContainer extends StatelessWidget {
  const PomodoroPageContainer({super.key, required Task task}) : _task = task;

  final Task _task;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_task.name)),
      body: BlocBuilder<PomodoroBloc, PomodoroState>(
        builder: (context, state) {
          if (state is PomodoroRunComplete) {
            return const Center(
              child: Text('Finished'),
            );
          }
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              const Spacer(),
              CountdownProgressIndicator(task: _task),
              const Spacer(),
              OpacityIsStarted(
                shouldShowIfInitialState: true,
                child: StretchedElevatedButton(
                  onPressed: () {
                    context
                        .read<PomodoroBloc>()
                        .add(PomodoroStarted(duration: state.duration));
                  },
                  child: const Text('Start'),
                ),
              ),
              OpacityIsStarted(
                shouldShowIfInitialState: false,
                child: Text(sessionToSayingMap[state.session]!),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CountdownProgressIndicator extends StatelessWidget {
  const CountdownProgressIndicator({required Task task, super.key})
      : _task = task;

  final Task _task;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PomodoroBloc, PomodoroState>(
      builder: (context, state) {
        return Center(
          child: CircularPercentIndicator(
            radius: 130,
            lineWidth: 15.0,
            percent: getProgressValue(state),
            backgroundColor: kPear,
            progressColor: kVioletBlue,
            circularStrokeCap: CircularStrokeCap.round,
            center: Column(
              children: <Widget>[
                const Spacer(),
                Text(sessionToNameMap[state.session] ?? ''),
                const Spacer(),
                const PomodoroText(),
                const Spacer(),
                Text(
                    'Session ${state.workingSessionCounter} of ${_task.numberOfWorkingSessions}'),
                const Spacer()
              ],
            ),
          ),
        );
      },
    );
  }

  double getProgressValue(PomodoroState state) {
    int currentDuration = state.duration;
    int totalDuration = state.maxDuration;

    double progress = (totalDuration - currentDuration) / totalDuration;

    return progress;
  }
}

class OpacityIsStarted extends StatelessWidget {
  const OpacityIsStarted({
    required this.shouldShowIfInitialState,
    required this.child,
    super.key,
  });

  final bool shouldShowIfInitialState;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PomodoroBloc, PomodoroState>(builder: (context, state) {
      bool condition =
          (state is PomodoroInitial && state.workingSessionCounter == 0) ==
              shouldShowIfInitialState;
      return AnimatedOpacity(
        opacity: condition ? 1 : 0,
        duration: const Duration(milliseconds: 500),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: child,
        ),
      );
    });
  }
}

class PomodoroText extends StatelessWidget {
  const PomodoroText({super.key});

  @override
  Widget build(BuildContext context) {
    final duration = context.select((PomodoroBloc bloc) => bloc.state.duration);
    final minutesStr =
        ((duration / 60) % 60).floor().toString().padLeft(2, '0');
    final secondsStr = (duration % 60).toString().padLeft(2, '0');
    return Text(
      '$minutesStr:$secondsStr',
      style: Theme.of(context).textTheme.displayMedium,
    );
  }
}
