import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pomodoro_timer/shared_models/task.dart';
import 'package:pomodoro_timer/shared_models/user.dart';

class DatabaseRepository {
  final FirebaseFirestore _db;

  DatabaseRepository({FirebaseFirestore? db})
      : _db = db ?? FirebaseFirestore.instance;

  Future<List<User>> getAllUsers() async {
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('users').get();

    return snapshot.docs.map((doc) => User.fromSnapshot(doc)).toList();
  }

  Future<List<Task>?> retrieveUserTasks(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _db.collection('users').doc(userId).get();

    if (snapshot.data() == null) return null;

    List<dynamic>? taskMap = snapshot.data()!['tasks'];

    List<Task>? tasks = taskMap?.map((task) => Task.fromMap(task)).toList();

    return tasks;
  }

  Future<void> addUserData(User user) async {
    try {
      await _db.collection('users').doc(user.id).set(user.toMap());
    } on Exception catch (_) {
      rethrow;
    }
  }

  Future<void> addTaskToUser(String userId) async {
    List<Task>? tasks = await retrieveUserTasks(userId);
    tasks ??= [];

    Task tempTask = const Task(
        name: 'AddedFromFlutter',
        duration: 'custom duration',
        moreInfo: 'Extra Info');
    tasks.add(tempTask);

    Map<String, dynamic> update = {
      'tasks': tasks.map((task) => task.toMap()).toList()
    };

    await _db.collection('users').doc(userId).update(update);
  }

  Stream getTasks(String userId) async* {
    yield _db
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((taskDocument) => Task.fromSnapShot(taskDocument));
  }
}
