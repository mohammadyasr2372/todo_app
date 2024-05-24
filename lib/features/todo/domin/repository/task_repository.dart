import '../../../../core/resources/data_state.dart';
import '../entity/task_entity.dart';


abstract class TaskRepository {
  // API methods
  Future<DataState<List<TaskEntity>>> getAllTodosByUserId(
      {required int userId});
  Future<DataState<List<TaskEntity>>> limitAndSkipTodos(
      {required int limit, required int skip});
  Future<DataState<TaskEntity>> getTaskInfo({required int idTask});

  Future<DataState<TaskEntity>> postTask({required TaskEntity newTaskEntity});

  Future<DataState<TaskEntity>> putTask(
      {required int id, required TaskEntity newTaskEntity});

  Future<DataState<String>> deletTask({required int id});

  // Database methods
  Future<List<TaskEntity>> getSavedTasks();

  Future<void> saveTask(TaskEntity task);

  Future<void> removeTask(TaskEntity task);
}
