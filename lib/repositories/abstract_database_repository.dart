import 'package:pomodoro_timer/shared_models/task.dart';
import 'package:pomodoro_timer/shared_models/user.dart';

abstract class AbstractDatabaseRepository {
  Future<List<User>> retrieveAllUsers();

  Future<List<Task>?> retrieveUserTasks({
    required String userId,
  });

  Future<void> addUserToDatabase({
    required User user,
  });

  Future<void> addTaskToUser({
    required String userId,
    required Task task,
  });

  Stream<User> user({
    required String userId,
  });

  Future<void> removeTaskFromUser({
    required String userId,
    required Task taskToDelete,
  });

  Future<void> updateTask({
    required String userId,
    required Task updatedTask,
  });
}
