part of 'sign_up_bloc.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class UsernameChanged extends SignUpEvent {
  final String usernameString;

  const UsernameChanged(this.usernameString);

  @override
  List<Object> get props => [usernameString];
}

class PasswordChanged extends SignUpEvent {
  final String passwordString;

  const PasswordChanged(this.passwordString);

  @override
  List<Object> get props => [passwordString];
}

class EmailChanged extends SignUpEvent {
  final String emailString;

  const EmailChanged(this.emailString);

  @override
  List<Object> get props => [emailString];
}

class FormSubmitted extends SignUpEvent {
  const FormSubmitted();

  @override
  List<Object> get props => [];
}
