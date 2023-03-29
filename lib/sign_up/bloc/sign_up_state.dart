part of 'sign_up_bloc.dart';

abstract class SignUpState extends Equatable {
  final Username username;
  final Email email;
  final Password password;

  final bool usernameHasBeenChanged;
  final bool emailHasBeenChanged;
  final bool passwordHasBeenChanged;

  const SignUpState({
    required this.username,
    required this.email,
    required this.password,
    required this.usernameHasBeenChanged,
    required this.emailHasBeenChanged,
    required this.passwordHasBeenChanged,
  });

  @override
  List<Object> get props => [
        username,
        email,
        password,
        usernameHasBeenChanged,
        emailHasBeenChanged,
        passwordHasBeenChanged,
      ];
}

class SignUpInitial extends SignUpState {
  const SignUpInitial({
    required super.username,
    required super.email,
    required super.password,
    super.usernameHasBeenChanged = false,
    super.emailHasBeenChanged = false,
    super.passwordHasBeenChanged = false,
  });

  @override
  List<Object> get props => [
        username,
        email,
        password,
        usernameHasBeenChanged,
        emailHasBeenChanged,
        passwordHasBeenChanged,
      ];
}

class SignUpInProgress extends SignUpState {
  const SignUpInProgress({
    required super.username,
    required super.email,
    required super.password,
    required super.usernameHasBeenChanged,
    required super.emailHasBeenChanged,
    required super.passwordHasBeenChanged,
  });

  @override
  List<Object> get props => [
        username,
        email,
        password,
        usernameHasBeenChanged,
        emailHasBeenChanged,
        passwordHasBeenChanged,
      ];
}

class SignUpDone extends SignUpState {
  const SignUpDone({
    required super.username,
    required super.email,
    required super.password,
    required super.usernameHasBeenChanged,
    required super.emailHasBeenChanged,
    required super.passwordHasBeenChanged,
  });

  @override
  List<Object> get props => [
        username,
        email,
        password,
        usernameHasBeenChanged,
        emailHasBeenChanged,
        passwordHasBeenChanged,
      ];
}

class SignUpFailure extends SignUpState {
  const SignUpFailure({
    required super.username,
    required super.email,
    required super.password,
    required super.usernameHasBeenChanged,
    required super.emailHasBeenChanged,
    required super.passwordHasBeenChanged,
  });

  @override
  List<Object> get props => [
        username,
        email,
        password,
        usernameHasBeenChanged,
        emailHasBeenChanged,
        passwordHasBeenChanged,
      ];
}

class SignUpSubmitting extends SignUpState {
  const SignUpSubmitting({
    required super.username,
    required super.email,
    required super.password,
    required super.usernameHasBeenChanged,
    required super.emailHasBeenChanged,
    required super.passwordHasBeenChanged,
  });

  @override
  List<Object> get props => [
        username,
        email,
        password,
        usernameHasBeenChanged,
        emailHasBeenChanged,
        passwordHasBeenChanged,
      ];
}
