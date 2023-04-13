import 'package:flutter/material.dart';
import 'package:pomodoro_timer/auth/bloc/auth_bloc.dart';
import 'package:pomodoro_timer/login/view/login_page.dart';
import 'package:pomodoro_timer/main/view/main_page.dart';

List<Page> onGenerateAppViewPages(AppStatus status, List<Page<dynamic>> pages) {
  switch (status) {
    case AppStatus.authenticated:
      // return [HomePage.page()];
      return [MainPage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
