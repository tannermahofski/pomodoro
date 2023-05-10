import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_timer/repositories/abstract_authentication_repository.dart';
import 'package:pomodoro_timer/shared_models/user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required AbstractAuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(authenticationRepository.currentUser.isNotEmpty
            ? AuthState.authenticated(
                authenticationRepository.currentUser,
              )
            : const AuthState.unauthenticated()) {
    on<UserChanged>(_onUserChanged);
    on<LogoutRequested>(_onLogoutRequested);
    on<TestUserVerified>(_onTestUserVerified);

    _userSubscription = _authenticationRepository.user.listen(
      (user) {
        add(UserChanged(user: user));
      },
    );
  }

  final AbstractAuthenticationRepository _authenticationRepository;
  late final StreamSubscription<User> _userSubscription;

  void _onUserChanged(UserChanged event, Emitter<AuthState> emit) {
    if (_authenticationRepository.currentUser.isNotEmpty) {
      if (_authenticationRepository.currentUser.isVerified == true) {
        emit(AuthState.authenticatedAndVerified(event.user));
      } else {
        emit(AuthState.authenticated(event.user));
      }
    } else {
      emit(const AuthState.unauthenticated());
    }
  }

  Future<void> _onLogoutRequested(
      LogoutRequested event, Emitter<AuthState> emit) async {
    await _authenticationRepository.logout();
  }

  Future<void> _onTestUserVerified(
      TestUserVerified event, Emitter<AuthState> emit) async {
    bool isVerified = await _authenticationRepository.getIsUserVerified();

    while (!isVerified) {
      Future.delayed(const Duration(seconds: 5));
      isVerified = await _authenticationRepository.getIsUserVerified();
    }

    emit(AuthState.authenticatedAndVerified(
        _authenticationRepository.currentUser));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
