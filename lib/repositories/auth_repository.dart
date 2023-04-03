import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:pomodoro_timer/repositories/database_repository.dart';
import 'package:pomodoro_timer/shared_models/user.dart';

class AuthRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final DatabaseRepository _databaseRepository;

  AuthRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    required DatabaseRepository databaseRepository,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _databaseRepository = databaseRepository;

  var currentUser = User.empty;

  Stream<User> get user {
    return _firebaseAuth.userChanges().map((firebaseUser) {
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
      await _firebaseAuth.currentUser?.reload();
      await _databaseRepository.addUserData(currentUser);
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception catch (_) {
      rethrow;
    }
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
