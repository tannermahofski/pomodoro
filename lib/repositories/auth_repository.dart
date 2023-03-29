import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:pomodoro_timer/shared_models/user.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthRepository({firebase_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  var currentUser = User.empty;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  Future<void> signUp({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firebaseAuth.currentUser?.updateDisplayName(username);
    } on Exception catch (e) {
      print('Failed to signup');
      print(e);
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await Future.wait([_firebaseAuth.signOut()]);
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, username: displayName);
  }
}
