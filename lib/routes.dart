import 'package:flutter/material.dart';
import 'package:pomodoro_timer/auth/bloc/auth_bloc.dart';
import 'package:pomodoro_timer/home/view/home_page.dart';
import 'package:pomodoro_timer/login/view/login_page.dart';
// import 'package:pomodoro_timer/sign_up/view/sign_up_page.dart';

List<Page> onGenerateAppViewPages(AppStatus status, List<Page<dynamic>> pages) {
  switch (status) {
    case AppStatus.authenticated:
      return [HomePage.page()];
    case AppStatus.unauthenticated:
      return [LoginPage.page()];
  }
}
