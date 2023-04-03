import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:pomodoro_timer/shared_models/task.dart';

class User extends Equatable {
  const User({
    required this.id,
    this.username,
    this.email,
    this.password,
    this.tasks,
  });

  factory User.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    if (doc.data() == null) return User.empty;

    Map<String, dynamic> snapshot = doc.data()!;
    return User(
      id: doc.id,
      username: snapshot['username'],
      email: snapshot['email'],
      tasks: (snapshot['tasks'] as List?)
          ?.map((task) => Task.fromMap(task))
          .toList(),
    );
  }

  final String id;
  final String? username;
  final String? email;
  final String? password;
  final List<Task>? tasks;

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'tasks': tasks?.map((task) => task.toMap()).toList(),
    };
  }

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;
  bool get isNotEmpty => this != User.empty;

  @override
  List<Object?> get props => [id, username, email, password];
}
