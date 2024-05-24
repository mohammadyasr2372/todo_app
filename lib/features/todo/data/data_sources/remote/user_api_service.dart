// ignore_for_file: non_constant_identifier_names, unused_element

import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/features/todo/domin/entity/user_entity.dart';

import '../../../../../config/di.dart';
import '../../../../../core/constants/constants.dart';

import '../../models/user_model.dart';

abstract class UserApiService {
  factory UserApiService(Dio dio) = _UserApiService;

  Future<HttpResponse<UserModel>> login({required UserEntity newUserEntity});
  Future<HttpResponse<UserModel>> getUser();
  Future<HttpResponse<UserModel>> refreshSession();
}

class _UserApiService implements UserApiService {
  _UserApiService(this.dio);
  final Dio dio;
  late Response response;

  @override
  Future<HttpResponse<UserModel>> getUser() async {
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';
    response = await dio.get<HttpResponse<UserModel>>(
      '$baseUrl/auth/me',
    );
    config
        .get<SharedPreferences>()
        .setInt('userId', response.data['userId']);

    final value = UserModel.fromJson(response.data!);
    final httpResponse = HttpResponse(value, response);
    return httpResponse;
  }

  @override
  Future<HttpResponse<UserModel>> login(
      {required UserEntity newUserEntity}) async {
    dio.options.headers['Accept'] = 'application/json';

    response = await dio.post<HttpResponse<UserModel>>('$baseUrl/auth/login',
        data: newUserEntity.toJson());
    config
        .get<SharedPreferences>()
        .setString('token', response.data['token']);
    config
        .get<SharedPreferences>()
        .setInt('userId', response.data['userId']);
    final value = UserModel.fromJson(response.data!);
    final httpResponse = HttpResponse(value, response);
    return httpResponse;
  }

  @override
  Future<HttpResponse<UserModel>> refreshSession() async {
    dio.options.headers['Accept'] = 'application/json';
    dio.options.headers['Authorization'] = 'Bearer $token';
    response = await dio.get<HttpResponse<UserModel>>(
      '$baseUrl/auth/refresh',
    );
    config
        .get<SharedPreferences>()
        .setInt('userId', response.data['userId']);
    config
        .get<SharedPreferences>()
        .setString('token', response.data['token']);
    final value = UserModel.fromJson(response.data!);
    final httpResponse = HttpResponse(value, response);
    return httpResponse;
  }
}
