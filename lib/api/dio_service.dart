import 'package:api_practice/api/dio_interceptor.dart';
import 'package:api_practice/constants/api_constant.dart';
import 'package:api_practice/model/post_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioService {
  static DioService? _instance;
  factory DioService() => _instance ??= DioService._();
  DioService._();
  final Dio dio = Dio(BaseOptions(
    baseUrl: Api.BASE_URL,
    contentType: 'application/json',
  ))
    ..interceptors.add(DioInterceptor());

  Future<List<PostModel>> getPosts() async {
    const String path = '/posts';
    try {
      Response response = await dio.get(path);
      List<PostModel> posts = List<PostModel>.from(
        response.data.map((postJson) => PostModel.fromJson(postJson)),
      );
      return posts;
    } catch (error) {
      throw error;
    }
  }

  Future<PostModel> getPost(int id) async {
    try {
      final String path = '/posts/$id';
      Response response = await dio.get(path);
      PostModel postModel = PostModel.fromJson(response.data);
      return postModel;
    } catch (error) {
      throw error;
    }
  }

  Future<PostModel> createPost({
    required int userId,
    required String title,
    required String desc,
  }) async {
    try {
      const String path = '/posts';
      final Map<String, dynamic> data = {
        "title": title,
        "userId": userId,
        "body": desc,
      };
      Response response = await dio.post(path, data: data);
      return PostModel.fromJson(response.data);
    } catch (error) {
      throw error;
    }
  }
}
