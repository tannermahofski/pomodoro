import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import 'package:pomodoro_timer/repositories/abstract_authentication_repository.dart';
import 'package:pomodoro_timer/repositories/abstract_database_repository.dart';
import 'package:pomodoro_timer/shared_models/user.dart';

class AuthenticationRepository implements AbstractAuthenticationRepository {
  AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    required AbstractDatabaseRepository databaseRepository,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _databaseRepository = databaseRepository;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final AbstractDatabaseRepository _databaseRepository;

  @override
  User currentUser = User.empty;

  @override
  Stream<User> get user {
    return _firebaseAuth.userChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      currentUser = user;
      return user;
    });
  }

  @override
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
      await _firebaseAuth.currentUser?.reload();
      await _databaseRepository.addUserToDatabase(user: currentUser);
      await _firebaseAuth.currentUser?.sendEmailVerification();
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> getIsUserVerified() async {
    await _firebaseAuth.currentUser?.reload();
    if (_firebaseAuth.currentUser != null) {
      currentUser = _firebaseAuth.currentUser?.toUser ?? currentUser;
    }
    return _firebaseAuth.currentUser?.emailVerified ?? false;
  }

  @override
  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } on Exception catch (_) {
      rethrow;
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(
      id: uid,
      email: email,
      username: displayName,
      isVerified: emailVerified,
    );
  }
}
