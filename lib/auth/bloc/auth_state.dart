part of 'auth_bloc.dart';

enum AppStatus { unauthenticated, authenticated, authenticatedAndVerified }

class AuthState extends Equatable {
  const AuthState._({
    required this.appStatus,
    this.user = User.empty,
  });

  final AppStatus appStatus;
  final User user;

  const AuthState.unauthenticated()
      : this._(appStatus: AppStatus.unauthenticated);

  const AuthState.authenticated(User user)
      : this._(
          appStatus: AppStatus.authenticated,
          user: user,
        );

  const AuthState.authenticatedAndVerified(User user)
      : this._(
          appStatus: AppStatus.authenticatedAndVerified,
          user: user,
        );

  @override
  List<Object> get props => [appStatus, user];
}
