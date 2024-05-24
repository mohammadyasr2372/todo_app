// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:todo_app/core/resources/data_state.dart';
import 'package:dio/dio.dart';

import '../../domin/entity/user_entity.dart';
import '../../domin/repository/user_repository.dart';
import '../data_sources/remote/user_api_service.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserApiService _userApiService;
  UserRepositoryImpl(
    this._userApiService,
  );

  @override
  Future<DataState<UserModel>> login(
      {required UserEntity newUserEntity}) async {
    try {
      final httpResponse =
          await _userApiService.login(newUserEntity: newUserEntity);

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
  Future<DataState<UserEntity>> getUser() async {
    try {
      final httpResponse = await _userApiService.getUser();

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
  Future<DataState<UserEntity>> refreshSession() async {
    try {
      final httpResponse = await _userApiService.getUser();

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
}
