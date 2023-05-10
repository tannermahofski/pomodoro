import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pomodoro_timer/auth/bloc/auth_bloc.dart';
import 'package:pomodoro_timer/planner/bloc/planner_bloc.dart';
import 'package:pomodoro_timer/repositories/abstract_database_repository.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class PlannerPage extends StatelessWidget {
  const PlannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return BlocProvider<PlannerBloc>(
          create: (context) => PlannerBloc(
            databaseRepository: context.read<AbstractDatabaseRepository>(),
            userId: state.user.id,
          ),
          child: const PlannerListener(),
        );
      },
    );
  }
}

class PlannerListener extends StatelessWidget {
  const PlannerListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PlannerBloc, PlannerState>(
      listener: (context, state) {},
      child: const PlannerBuilder(),
    );
  }
}

class PlannerBuilder extends StatelessWidget {
  const PlannerBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlannerBloc, PlannerState>(
      builder: (context, state) {
        if (state is PlannerLoadDataSuccess) {
          return SfCalendar(
            view: CalendarView.week,
            dataSource: state.taskDataSource,
            monthViewSettings: const MonthViewSettings(
              appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

// class PlannerPage2 extends StatelessWidget {
//   const PlannerPage2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SfCalendar(
//       view: CalendarView.month,
//       dataSource: TaskDataSource(_getDataSource()),
//       monthViewSettings: const MonthViewSettings(
//         appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
//       ),
//     );
//   }

//   List<Task> _getDataSource() {
//     final List<Task> tasks = [];

//     Task task = Task(
//       name: 'CalendarTask',
//       numberOfWorkingSessions: 3,
//       workingDuration: 20,
//       shortBreakDuration: 5,
//       longBreakDuration: 10,
//       moreInfo: 'More info',
//       startDate: DateTime(2023, 4, 29),
//       startTime: TimeOfDay.now(),
//     );

//     tasks.add(task);

//     return tasks;
//   }
// }
