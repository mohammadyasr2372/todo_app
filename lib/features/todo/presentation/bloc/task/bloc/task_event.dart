// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../../domin/entity/task_entity.dart';

abstract class TaskEvent {
  const TaskEvent();
}

class GetAllTodosByUserId extends TaskEvent {
  int userId;

  GetAllTodosByUserId(
    this.userId,
  );
}

class LimitAndSkipTodos extends TaskEvent {
  int skip;
  int limit;

  LimitAndSkipTodos(
    this.skip,
    this.limit,
  );
}

class GetTaskInfo extends TaskEvent {
  int idTask;
  GetTaskInfo({required this.idTask});
}

class PostTask extends TaskEvent {
  TaskEntity taskEntity;
  PostTask({
    required this.taskEntity,
  });
}

class PutTask extends TaskEvent {
  TaskEntity taskEntity;
  int id;
  PutTask({required this.taskEntity, required this.id});
}

class DeletTask extends TaskEvent {
  int id;

  DeletTask({required this.id});
}

abstract class LocalTasksEvent extends TaskEvent {
  final TaskEntity? task;

  const LocalTasksEvent({this.task});

  List<Object> get props => [task!];
}

class GetSavedTasks extends LocalTasksEvent {
  const GetSavedTasks();
}

class RemoveTask extends LocalTasksEvent {
  const RemoveTask(TaskEntity task) : super(task: task);
}

class SaveTask extends LocalTasksEvent {
  const SaveTask(TaskEntity task) : super(task: task);
}
