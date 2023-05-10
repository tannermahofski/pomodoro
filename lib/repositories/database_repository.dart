import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomodoro_timer/repositories/abstract_database_repository.dart';
import 'package:pomodoro_timer/shared_models/task.dart';
import 'package:pomodoro_timer/shared_models/user.dart';

class DatabaseRepository implements AbstractDatabaseRepository {
  DatabaseRepository({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  final FirebaseFirestore _db;

  @override
  Future<List<User>> retrieveAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('users').get();

    return snapshot.docs.map((doc) => User.fromSnapshot(doc)).toList();
  }

  @override
  Future<List<Task>?> retrieveUserTasks({
    required String userId,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('users').doc(userId).get();

    if (snapshot.data() == null) return null;

    List<dynamic>? taskMap = snapshot.data()!['tasks'];

    List<Task>? tasks = taskMap?.map((task) => Task.fromMap(task)).toList();

    return tasks;
  }

  @override
  Future<void> addUserToDatabase({
    required User user,
  }) async {
    try {
      await _db.collection('users').doc(user.id).set(user.toMap());
    } on Exception catch (_) {
      rethrow;
    }
  }

  @override
  Future<void> addTaskToUser({
    required String userId,
    required Task task,
  }) async {
    List<Task>? tasks = await retrieveUserTasks(userId: userId);
    tasks ??= [];

    tasks.add(task);

    Map<String, dynamic> update = {
      'tasks': tasks.map((task) => task.toMap()).toList()
    };

    await _db.collection('users').doc(userId).update(update);
  }

  @override
  Stream<User> user({
    required String userId,
  }) {
    return _db
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((snapshot) => User.fromSnapshot(snapshot));
  }

  @override
  Future<void> removeTaskFromUser({
    required String userId,
    required Task taskToDelete,
  }) async {
    print('Removing task');
    List<Task>? tasks = await retrieveUserTasks(userId: userId);
    tasks ??= [];

    tasks.remove(taskToDelete);

    Map<String, dynamic> update = {
      'tasks': tasks.map((task) => task.toMap()).toList()
    };

    _db.collection('users').doc(userId).update(update);
  }

  @override
  Future<void> updateTask({
    required String userId,
    required Task updatedTask,
  }) async {
    List<Task>? tasks = await retrieveUserTasks(userId: userId);
    tasks ??= [];

    int indexOfTask = tasks.indexOf(updatedTask);
    tasks[indexOfTask] = updatedTask;

    Map<String, dynamic> update = {
      'tasks': tasks.map((task) => task.toMap()).toList()
    };

    _db.collection('users').doc(userId).update(update);
  }
}
