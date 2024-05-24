import 'package:todo_app/core/resources/data_state.dart';
import 'package:todo_app/core/usecases/usecase.dart';

import '../entity/task_entity.dart';
import '../repository/task_repository.dart';

class GetAllTodosByUserIdUseCase implements UseCase<DataState<List<TaskEntity>>, int> {
  final TaskRepository _taskRepository;

  GetAllTodosByUserIdUseCase(this._taskRepository);

  @override
  Future<DataState<List<TaskEntity>>> call({int? params}) {
    return _taskRepository.getAllTodosByUserId(userId: params!);
  }
}

class LimitAndSkipTodosUseCase implements UseCase<DataState<List<TaskEntity>>, int> {
  final TaskRepository _taskRepository;

  LimitAndSkipTodosUseCase(this._taskRepository);

  @override
  Future<DataState<List<TaskEntity>>> call({int? params, int? skip }) {
    return _taskRepository.limitAndSkipTodos(limit: params!,skip:skip! );
  }
}


class GetTaskInfoUseCase implements UseCase<DataState<TaskEntity>, int> {
  final TaskRepository _taskRepository;

  GetTaskInfoUseCase(this._taskRepository);

  @override
  Future<DataState<TaskEntity>> call({int? params}) {
    return _taskRepository.getTaskInfo(idTask: params!);
  }
}
class PostTaskUseCase implements UseCase<DataState<TaskEntity>, TaskEntity> {
  final TaskRepository _taskRepository;

  PostTaskUseCase(this._taskRepository);

  @override
  Future<DataState<TaskEntity>> call({TaskEntity? params}) {
    return _taskRepository.postTask(newTaskEntity: params!);
  }
}

class PutTaskUseCase implements UseCase<DataState<TaskEntity>, TaskEntity> {
  final TaskRepository _taskRepository;

  PutTaskUseCase(this._taskRepository);

  @override
  Future<DataState<TaskEntity>> call({TaskEntity? params, int? id}) {
    return _taskRepository.putTask(newTaskEntity: params!, id: id!);
  }
}

class DeletTaskUseCase implements UseCase<DataState<String>, int> {
  final TaskRepository _taskRepository;

  DeletTaskUseCase(this._taskRepository);

  @override
  Future<DataState<String>> call({int? params}) {
    return _taskRepository.deletTask(id: params!);
  }
}

class GetSavedTaskUseCase implements UseCase<List<TaskEntity>, void> {
  final TaskRepository _taskRepository;

  GetSavedTaskUseCase(this._taskRepository);

  @override
  Future<List<TaskEntity>> call({void params}) {
    return _taskRepository.getSavedTasks();
  }
}

class SaveTaskUseCase implements UseCase<void, TaskEntity> {
  final TaskRepository _taskRepository;

  SaveTaskUseCase(this._taskRepository);

  @override
  Future<void> call({TaskEntity? params}) {
    return _taskRepository.saveTask(params!);
  }
}

class RemoveTaskUseCase implements UseCase<void, TaskEntity> {
  final TaskRepository _taskRepository;

  RemoveTaskUseCase(this._taskRepository);

  @override
  Future<void> call({TaskEntity? params}) {
    return _taskRepository.removeTask(params!);
  }
}
