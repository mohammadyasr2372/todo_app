import 'package:floor/floor.dart';

import '../../../models/task_model.dart';

@dao
abstract class TaskDao {
  @Insert()
  Future<void> insertTask(TaskModel newTaskMode);

  @delete
  Future<void> deletTask(TaskModel newTaskMode);

  @Query('SELECT * FROM Task')
  Future<List<TaskModel>> getTasks();
}
