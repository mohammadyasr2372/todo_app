// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:todo_app/core/resources/data_state.dart';
import 'package:dio/dio.dart';
import '../../domin/entity/task_entity.dart';
import '../../domin/repository/task_repository.dart';
import '../data_sources/local/app_database.dart';
import '../data_sources/remote/task_api_service.dart';
import '../models/task_model.dart';

class TaskRepositoryImpl implements TaskRepository {
  final TaskApiService _taskApiService;
  final AppDatabase _appDatabase;
  TaskRepositoryImpl(
    this._taskApiService,
    this._appDatabase,
  );

  @override
  Future<DataState<List<TaskModel>>> getAllTodosByUserId(
      {required int userId}) async {
    try {
      final httpResponse =
          await _taskApiService.getAllTodosByUserId(userId: userId);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<List<TaskModel>>> limitAndSkipTodos(
      {required int limit, required int skip}) async {
    try {
      final httpResponse =
          await _taskApiService.limitAndSkipTodos(limit: limit, skip: skip);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<TaskModel>> getTaskInfo({required int idTask}) async {
    try {
      final httpResponse = await _taskApiService.getTaskInfo(idTask: idTask);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<TaskModel>> postTask(
      {required TaskEntity newTaskEntity}) async {
    try {
      final httpResponse =
          await _taskApiService.postTask(newTaskModel: newTaskEntity);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<TaskModel>> putTask(
      {required int id, required TaskEntity newTaskEntity}) async {
    try {
      final httpResponse =
          await _taskApiService.putTask(newTaskModel: newTaskEntity, id: id);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<DataState<String>> deletTask({required int id}) async {
    try {
      final httpResponse = await _taskApiService.deletTask(id: id);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  @override
  Future<List<TaskModel>> getSavedTasks() async {
    return _appDatabase.taskDao.getTasks();
  }

  @override
  Future<void> removeTask(TaskEntity task) {
    return _appDatabase.taskDao.deletTask(TaskModel.fromEntity(task));
  }

  @override
  Future<void> saveTask(TaskEntity task) {
    return _appDatabase.taskDao.insertTask(TaskModel.fromEntity(task));
  }
}
