part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class UsernameChanged extends LoginEvent {
  final String usernameString;

  const UsernameChanged(this.usernameString);

  @override
  List<Object> get props => [usernameString];
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
