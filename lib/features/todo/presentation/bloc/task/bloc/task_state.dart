// ignore_for_file: public_member_api_docs, sort_constructors_first, overridden_fields
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../../domin/entity/task_entity.dart';

abstract class TaskState extends Equatable {
  final List<TaskEntity>? tasks;
  final TaskEntity? task;
  final String? massege;

  final DioException? exception;
  const TaskState({
    this.tasks,
    this.task,
    this.massege,
    this.exception,
  });

  @override
  List<Object?> get props => [tasks, task, massege, exception];
}

class TasksLoadingState extends TaskState {
  const TasksLoadingState();
}

class GetAllTodosByUserIdDoneState extends TaskState {
  const GetAllTodosByUserIdDoneState(List<TaskEntity> tasks)
      : super(tasks: tasks);
}

class LimitAndSkipTodosDoneState extends TaskState {
  const LimitAndSkipTodosDoneState(List<TaskEntity> tasks)
      : super(tasks: tasks);
}

class TasksInfoDoneState extends TaskState {
  const TasksInfoDoneState(TaskEntity task) : super(task: task);
}

class TasksErrorState extends TaskState {
  const TasksErrorState(DioException exception) : super(exception: exception);
}

class PostTasksDoneState extends TaskState {
  const PostTasksDoneState(TaskEntity task) : super(task: task);
}

class PutTasksDoneState extends TaskState {
  const PutTasksDoneState(TaskEntity task) : super(task: task);
}

class DeletTasksDoneState extends TaskState {
  const DeletTasksDoneState(String massege) : super(massege: massege);
}

abstract class LocalTasksState extends TaskState {
  @override
  final List<TaskEntity>? tasks;

  const LocalTasksState({this.tasks});

  @override
  List<Object> get props => [tasks!];
}

class LocalTasksLoading extends LocalTasksState {
  const LocalTasksLoading();
}

class LocalTasksDone extends LocalTasksState {
  const LocalTasksDone(List<TaskEntity> tasks) : super(tasks: tasks);
}
