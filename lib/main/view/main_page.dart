import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:pomodoro_timer/auth/bloc/auth_bloc.dart';
import 'package:pomodoro_timer/create_task/view/create_task_page.dart';
import 'package:pomodoro_timer/helpers/constants/color_constants.dart';
import 'package:pomodoro_timer/home/view/home_page.dart';
import 'package:pomodoro_timer/main/bloc/main_bloc.dart';

class MainPage extends StatelessWidget {
  static Page<void> page() => const MaterialPage<void>(child: MainPage());
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return BlocProvider<MainBloc>(
          create: (context) => MainBloc(),
          child: const MainContainer(),
        );
      },
    );
  }
}

class MainContainer extends StatelessWidget {
  const MainContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(MdiIcons.clockOutline),
        title: const Text('Task Mastr'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
            icon: const Icon(
              Icons.logout_rounded,
            ),
          )
        ],
      ),
      body: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          if (state is MainStateHome) {
            return const HomePage();
          } else if (state is MainStatePlanner) {
            return const Center(
              child: Text('Planner'),
            );
          }
          return Container();
        },
      ),
      bottomNavigationBar: BlocBuilder<MainBloc, MainState>(
        builder: (context, state) {
          return BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: CircleAvatar(
                  backgroundColor: kVioletBlue,
                  child: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
                label: 'Create New Task',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Planner',
              ),
            ],
            onTap: (index) {
              if (index == 1) {
                Navigator.of(context).push<void>(CreateTaskPage.route());
              } else if (index == 0) {
                context.read<MainBloc>().add(const MainEventHomeTapped());
              } else if (index == 2) {
                context.read<MainBloc>().add(const MainEventPlannerTapped());
              }
            },
          );
        },
      ),
    );
  }
}
