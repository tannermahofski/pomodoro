import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_timer/repositories/auth_repository.dart';
import 'package:pomodoro_timer/shared_models/email.dart';
import 'package:pomodoro_timer/shared_models/password.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;
  LoginBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(const LoginInitial(email: Email(''), password: Password(''))) {
    on<EmailChanged>(_usernameChanged);
    on<PasswordChanged>(_passwordChanged);
    on<FormSubmitted>(_formSubmitted);
  }

  void _usernameChanged(EmailChanged event, Emitter<LoginState> emit) {
    emit(
      LoginInProgress(
          email: Email(event.usernameString),
          password: state.password,
          emailHasBeenChanged: true,
          passwordHasBeenChanged: state.passwordHasBeenChanged),
    );
  }

  void _passwordChanged(PasswordChanged event, Emitter<LoginState> emit) {
    emit(
      LoginInProgress(
        email: state.email,
        password: Password(event.passwordString),
        emailHasBeenChanged: state.emailHasBeenChanged,
        passwordHasBeenChanged: true,
      ),
    );
  }

  Future<void> _formSubmitted(
      FormSubmitted event, Emitter<LoginState> emit) async {
    if (!state.email.isValid() || !state.password.isValid()) {
      emit(
        LoginFailure(
          email: state.email,
          password: state.password,
          emailHasBeenChanged: state.emailHasBeenChanged,
          passwordHasBeenChanged: state.passwordHasBeenChanged,
        ),
      );
      return;
    }

    try {
      emit(
        LoginSubmitting(
          email: state.email,
          password: state.password,
          emailHasBeenChanged: state.emailHasBeenChanged,
          passwordHasBeenChanged: state.passwordHasBeenChanged,
        ),
      );

      await Future.delayed(const Duration(seconds: 3));

      await _authRepository.login(
          email: state.email.value, password: state.password.value);

      emit(LoginDone(email: state.email, password: state.password));
    } on Exception catch (_) {
      emit(
        LoginFailure(
          email: state.email,
          password: state.password,
          emailHasBeenChanged: state.emailHasBeenChanged,
          passwordHasBeenChanged: state.passwordHasBeenChanged,
        ),
      );
    }
  }
}
