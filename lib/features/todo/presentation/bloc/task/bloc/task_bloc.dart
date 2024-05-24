// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:todo_app/core/resources/data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domin/usecases/task.dart';
import 'task_event.dart';
import 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetAllTodosByUserIdUseCase _getAllTodosByUserIdUseCase;
  final LimitAndSkipTodosUseCase _limitAndSkipTodosUseCase;
  final GetTaskInfoUseCase _getTaskInfoUseCase;
  final PostTaskUseCase _postTaskUseCase;
  final PutTaskUseCase _putTaskUseCase;
  final DeletTaskUseCase _deletTaskUseCase;
  final GetSavedTaskUseCase _getSavedTaskUseCase;
  final SaveTaskUseCase _saveTaskUseCase;
  final RemoveTaskUseCase _removeTaskUseCase;

  TaskBloc(
      this._postTaskUseCase,
      this._putTaskUseCase,
      this._deletTaskUseCase,
      this._getTaskInfoUseCase,
      this._getSavedTaskUseCase,
      this._saveTaskUseCase,
      this._removeTaskUseCase,
      this._getAllTodosByUserIdUseCase,
      this._limitAndSkipTodosUseCase)
      : super(const TasksLoadingState()) {
    on<GetAllTodosByUserId>(onGetAllTodosByUserId);
    on<LimitAndSkipTodos>(onLimitAndSkipTodos);
    on<PostTask>(onPostTasks);

    on<PutTask>(onPutTasks);

    on<DeletTask>(onDeletTasks);
    on<GetTaskInfo>(onGetTaskInfo);

    on<GetSavedTasks>(onGetSavedTasks);

    on<RemoveTask>(onRemoveTask);
    on<SaveTask>(onSaveTask);
  }

  void onGetAllTodosByUserId(
      GetAllTodosByUserId event, Emitter<TaskState> emit) async {
    final dataState = await _getAllTodosByUserIdUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      dataState.data!.forEach((element) async {
        await _saveTaskUseCase(params: element);
      });

      emit(GetAllTodosByUserIdDoneState(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(TasksErrorState(dataState.exception!));

      final tasks = await _getSavedTaskUseCase();
      emit(LocalTasksDone(tasks));
    }
  }

  void onLimitAndSkipTodos(
      LimitAndSkipTodos event, Emitter<TaskState> emit) async {
    final dataState = await _limitAndSkipTodosUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      dataState.data!.forEach((element) async {
        await _saveTaskUseCase(params: element);
      });

      emit(LimitAndSkipTodosDoneState(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(TasksErrorState(dataState.exception!));

      final tasks = await _getSavedTaskUseCase();
      emit(LocalTasksDone(tasks));
    }
  }

  void onGetTaskInfo(GetTaskInfo event, Emitter<TaskState> emit) async {
    final dataState = await _getTaskInfoUseCase(params: event.idTask);

    if (dataState is DataSuccess) {
      emit(PostTasksDoneState(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(TasksErrorState(dataState.exception!));
    }
  }

  void onPostTasks(PostTask event, Emitter<TaskState> emit) async {
    final dataState = await _postTaskUseCase(params: event.taskEntity);

    if (dataState is DataSuccess) {
      emit(PostTasksDoneState(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(TasksErrorState(dataState.exception!));
    }
  }

  void onPutTasks(PutTask event, Emitter<TaskState> emit) async {
    final dataState = await _putTaskUseCase();

    if (dataState is DataSuccess) {
      emit(PutTasksDoneState(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(TasksErrorState(dataState.exception!));
    }
  }

  void onDeletTasks(DeletTask event, Emitter<TaskState> emit) async {
    final dataState = await _deletTaskUseCase();

    if (dataState is DataSuccess) {
      emit(DeletTasksDoneState(dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(TasksErrorState(dataState.exception!));
    }
  }

  void onGetSavedTasks(GetSavedTasks event, Emitter<TaskState> emit) async {
    final tasks = await _getSavedTaskUseCase();
    emit(LocalTasksDone(tasks));
  }

  void onRemoveTask(RemoveTask removeTask, Emitter<TaskState> emit) async {
    await _removeTaskUseCase(params: removeTask.task);
    final tasks = await _getSavedTaskUseCase();
    emit(LocalTasksDone(tasks));
  }

  void onSaveTask(SaveTask saveTask, Emitter<TaskState> emit) async {
    await _saveTaskUseCase(params: saveTask.task);
    final tasks = await _getSavedTaskUseCase();
    emit(LocalTasksDone(tasks));
  }
}
