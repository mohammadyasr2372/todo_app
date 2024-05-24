// ignore_for_file: non_constant_identifier_names, unused_element, depend_on_referenced_packages

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:todo_app/features/todo/data/models/task_model.dart';
import 'package:todo_app/features/todo/domin/entity/task_entity.dart';
import '../../../../../core/constants/constants.dart';

abstract class TaskApiService {
  factory TaskApiService(Dio dio) = _TaskApiService;

  Future<HttpResponse<List<TaskModel>>> getAllTodosByUserId(
      {required int userId});
  Future<HttpResponse<List<TaskModel>>> limitAndSkipTodos(
      {required int limit, required int skip});
  Future<HttpResponse<TaskModel>> getTaskInfo({required int idTask});

  Future<HttpResponse<TaskModel>> postTask({required TaskEntity newTaskModel});

  Future<HttpResponse<TaskModel>> putTask(
      {required int id, required TaskEntity newTaskModel});

  Future<HttpResponse<String>> deletTask({required int id});
}

class _TaskApiService implements TaskApiService {
  _TaskApiService(this.dio);
  final Dio dio;
  late Response response;

  @override
  Future<HttpResponse<String>> deletTask({required int id}) async {
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';

    response = await dio.delete<HttpResponse<String>>('$baseUrl/todos/$id');
    final value = response.data!.toString();
    final httpResponse = HttpResponse(value, response);
    return httpResponse;
  }

  @override
  Future<HttpResponse<List<TaskModel>>> getAllTodosByUserId(
      {required int userId}) async {
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';

    final response = await dio.get('$baseUrl/todos/user/$userId');
    var value = response.data['todos']!
        .map((dynamic i) => TaskModel.fromJson(i as Map<String, dynamic>))
        .toList();
    final httpResponse = HttpResponse(value, response);
    return httpResponse as Future<HttpResponse<List<TaskModel>>>;
  }

  @override
  Future<HttpResponse<TaskModel>> getTaskInfo({required int idTask}) async {
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';
    response = await dio.get<HttpResponse<TaskModel>>(
      '$baseUrl/todos/$idTask',
    );
    final value = TaskModel.fromJson(response.data!);
    final httpResponse = HttpResponse(value, response);
    return httpResponse;
  }

  @override
  Future<HttpResponse<List<TaskModel>>> limitAndSkipTodos(
      {required int limit, required int skip}) async {
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';

    final response = await dio.get('$baseUrl/todos?limit=$limit&skip=$skip');
    var value = response.data['todos']!
        .map((dynamic i) => TaskModel.fromJson(i as Map<String, dynamic>))
        .toList();
    final httpResponse = HttpResponse(value, response);
    return httpResponse as Future<HttpResponse<List<TaskModel>>>;
  }

  @override
  Future<HttpResponse<TaskModel>> postTask(
      {required TaskEntity newTaskModel}) async {
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';

    response = await dio.post<HttpResponse<TaskModel>>('$baseUrl/todos/add',
        data: newTaskModel.toJson());
    final value = TaskModel.fromJson(response.data!);
    final httpResponse = HttpResponse(value, response);
    return httpResponse;
  }

  @override
  Future<HttpResponse<TaskModel>> putTask(
      {required int id, required TaskEntity newTaskModel}) async {
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';

    response = await dio.put<HttpResponse<TaskModel>>('$baseUrl/todos/$id',
        data: newTaskModel.toJson());
    final value = TaskModel.fromJson(response.data!);
    final httpResponse = HttpResponse(value, response);
    return httpResponse;
  }
}
