part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends LoginEvent {
  const EmailChanged(this.emailString);

  final String emailString;

  @override
  List<Object> get props => [emailString];
}

class PasswordChanged extends LoginEvent {
  final String passwordString;

  const PasswordChanged(this.passwordString);

  @override
  List<Object> get props => [passwordString];
}

class FormSubmitted extends LoginEvent {
  const FormSubmitted();

  @override
  List<Object> get props => [];
}
