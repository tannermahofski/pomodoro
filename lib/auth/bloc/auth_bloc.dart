import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_timer/repositories/auth_repository.dart';
import 'package:pomodoro_timer/shared_models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<User> _userSubscription;

  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(authRepository.currentUser.isNotEmpty
            ? AuthState.authenticated(authRepository.currentUser)
            : const AuthState.unauthenticated()) {
    on<UserChanged>(_onUserChanged);
    on<LogoutRequested>(_onLogoutRequested);

    _userSubscription = _authRepository.user.listen(
      (user) => add(UserChanged(user: user)),
    );
  }

  void _onUserChanged(UserChanged event, Emitter<AuthState> emit) {
    _authRepository.currentUser.isNotEmpty
        ? emit(AuthState.authenticated(event.user))
        : emit(const AuthState.unauthenticated());
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    unawaited(_authRepository.logout());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
