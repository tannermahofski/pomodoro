import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:pomodoro_timer/repositories/abstract_authentication_repository.dart';
import 'package:pomodoro_timer/shared_models/email.dart';
import 'package:pomodoro_timer/shared_models/password.dart';
import 'package:pomodoro_timer/shared_models/username.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required AbstractAuthenticationRepository authRepository})
      : _authRepository = authRepository,
        super(const SignUpInitial(
          username: Username(''),
          email: Email(''),
          password: Password(''),
        )) {
    on<UsernameChanged>(_usernameChanged);
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
    on<FormSubmitted>(_formSubmitted);
  }

  final AbstractAuthenticationRepository _authRepository;

  void _usernameChanged(UsernameChanged event, Emitter<SignUpState> emit) {
    emit(
      SignUpInProgress(
        username: Username(event.usernameString),
        email: state.email,
        password: state.password,
        usernameHasBeenChanged: true,
        emailHasBeenChanged: state.emailHasBeenChanged,
        passwordHasBeenChanged: state.passwordHasBeenChanged,
      ),
    );
  }

  void _emailChanged(EmailChanged event, Emitter<SignUpState> emit) {
    emit(
      SignUpInProgress(
        username: state.username,
        email: Email(event.emailString),
        password: state.password,
        usernameHasBeenChanged: state.usernameHasBeenChanged,
        emailHasBeenChanged: true,
        passwordHasBeenChanged: state.passwordHasBeenChanged,
      ),
    );
  }

  void _passwordChanged(PasswordChanged event, Emitter<SignUpState> emit) {
    emit(
      SignUpInProgress(
        username: state.username,
        email: state.email,
        password: Password(event.passwordString),
        usernameHasBeenChanged: state.usernameHasBeenChanged,
        emailHasBeenChanged: state.emailHasBeenChanged,
        passwordHasBeenChanged: true,
      ),
    );
  }

  Future<void> _formSubmitted(
      FormSubmitted event, Emitter<SignUpState> emit) async {
    emit(
      SignUpSubmitting(
        username: state.username,
        email: state.email,
        password: state.password,
        usernameHasBeenChanged: state.usernameHasBeenChanged,
        emailHasBeenChanged: state.emailHasBeenChanged,
        passwordHasBeenChanged: state.passwordHasBeenChanged,
      ),
    );

    if (!state.username.isValid() ||
        !state.password.isValid() ||
        !state.email.isValid()) {
      emit(
        SignUpFailure(
          username: state.username,
          email: state.email,
          password: state.password,
          usernameHasBeenChanged: state.usernameHasBeenChanged,
          emailHasBeenChanged: state.emailHasBeenChanged,
          passwordHasBeenChanged: state.passwordHasBeenChanged,
        ),
      );
    }

    try {
      await _authRepository.signUp(
        username: state.username.value,
        email: state.email.value,
        password: state.password.value,
      );
      emit(
        SignUpDone(
          username: state.username,
          email: state.email,
          password: state.password,
          usernameHasBeenChanged: state.usernameHasBeenChanged,
          emailHasBeenChanged: state.emailHasBeenChanged,
          passwordHasBeenChanged: state.passwordHasBeenChanged,
        ),
      );
    } catch (_) {
      emit(
        SignUpFailure(
          username: state.username,
          email: state.email,
          password: state.password,
          usernameHasBeenChanged: state.usernameHasBeenChanged,
          emailHasBeenChanged: state.emailHasBeenChanged,
          passwordHasBeenChanged: state.passwordHasBeenChanged,
        ),
      );
    }
  }
}
