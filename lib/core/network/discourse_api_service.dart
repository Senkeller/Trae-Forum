import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dio_client.dart';

part 'discourse_api_service.g.dart';

@riverpod
DiscourseApiService discourseApiService(DiscourseApiServiceRef ref) {
  return DiscourseApiService();
}

class DiscourseApiService {
  static const String _baseUrl = 'https://forum.trae.cn';
  final Dio _dio;

  DiscourseApiService() : _dio = DioClient.dio;

  Future<Response> getLatestTopics({int page = 0}) async {
    return _dio.get(
      '$_baseUrl/latest.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getTopicsByCategory(int categoryId, {int page = 0}) async {
    return _dio.get(
      '$_baseUrl/c/$categoryId.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getTopicDetail(int topicId) async {
    return _dio.get('$_baseUrl/t/$topicId.json');
  }

  Future<Response> getTopicPosts(int topicId, {int page = 0}) async {
    return _dio.get(
      '$_baseUrl/t/$topicId/posts.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getCategories() async {
    return _dio.get('$_baseUrl/categories.json');
  }

  Future<Response> searchTopics(String query) async {
    return _dio.get(
      '$_baseUrl/search.json',
      queryParameters: {'q': query},
    );
  }

  Future<Response> getUserInfo(String username) async {
    return _dio.get('$_baseUrl/u/$username.json');
  }

  Future<Response> getUserTopics(String username, {int page = 0}) async {
    return _dio.get(
      '$_baseUrl/u/$username/activity/topics.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getHotTopics({int page = 0}) async {
    return _dio.get(
      '$_baseUrl/hot.json',
      queryParameters: {'page': page},
    );
  }

  Future<Response> getTopTopics({int page = 0}) async {
    return _dio.get(
      '$_baseUrl/top.json',
      queryParameters: {'page': page},
    );
  }
}
