part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LogoutRequested extends AuthEvent {}

class UserChanged extends AuthEvent {
  const UserChanged({required this.user});

  final User user;

  @override
  List<Object> get props => [user];
}

class TestUserVerified extends AuthEvent {}
