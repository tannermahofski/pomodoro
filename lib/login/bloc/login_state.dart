part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  final Email email;
  final Password password;
  final bool emailHasBeenChanged;
  final bool passwordHasBeenChanged;
  const LoginState({
    required this.email,
    required this.password,
    required this.emailHasBeenChanged,
    required this.passwordHasBeenChanged,
  });

  @override
  List<Object> get props => [
        email,
        password,
        emailHasBeenChanged,
        passwordHasBeenChanged,
      ];
}

class LoginInitial extends LoginState {
  const LoginInitial({
    required super.email,
    required super.password,
    super.emailHasBeenChanged = false,
    super.passwordHasBeenChanged = false,
  });

  @override
  List<Object> get props => [
        email,
        password,
        emailHasBeenChanged,
        passwordHasBeenChanged,
      ];
}

class LoginInProgress extends LoginState {
  const LoginInProgress({
    required super.email,
    required super.password,
    required super.emailHasBeenChanged,
    required super.passwordHasBeenChanged,
  });

  @override
  List<Object> get props => [
        email,
        password,
        emailHasBeenChanged,
        passwordHasBeenChanged,
      ];
}

class LoginDone extends LoginState {
  const LoginDone({
    required super.email,
    required super.password,
    super.emailHasBeenChanged = true,
    super.passwordHasBeenChanged = true,
  });

  @override
  List<Object> get props => [
        email,
        password,
        emailHasBeenChanged,
        passwordHasBeenChanged,
      ];
}

class LoginFailure extends LoginState {
  const LoginFailure({
    required super.email,
    required super.password,
    required super.emailHasBeenChanged,
    required super.passwordHasBeenChanged,
  });

  @override
  List<Object> get props => [
        email,
        password,
        emailHasBeenChanged,
        passwordHasBeenChanged,
      ];
}
