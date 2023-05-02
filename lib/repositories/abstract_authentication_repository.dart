import 'package:pomodoro_timer/shared_models/user.dart';

abstract class AbstractAuthenticationRepository {
  User currentUser = User.empty;

  Stream<User> get user;

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  });

  Future<bool> getIsUserVerified();

  Future<void> login({
    required String email,
    required String password,
  });

  Future<void> logout();
}
