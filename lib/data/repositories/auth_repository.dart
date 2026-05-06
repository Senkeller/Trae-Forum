import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../core/network/api_service.dart' as api;

part 'auth_repository.g.dart';

/// 认证仓库
/// 负责处理用户登录、登出、Token 管理等认证相关操作
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  final apiService = ref.read(api.apiServiceProvider);
  return AuthRepository(apiService);
}

/// 认证仓库类
class AuthRepository {
  final api.ApiService _apiService;

  AuthRepository(this._apiService);

  /// 检查登录状态
  Future<api.CheckResponse> checkLoginStatus() async {
    return await _apiService.checkLoginInfo();
  }

  /// 预获取登录参数
  Future<Response> preGetLoginParam({
    String type = 'mobile',
  }) async {
    return await _apiService.preGetLoginParam(type: type);
  }

  /// 获取登录参数
  Future<Response> getLoginParam() async {
    return await _apiService.getLoginParam();
  }

  /// 尝试登录
  ///
  /// [data] 登录数据
  Future<Response> tryLogin({
    required Map<String, String?> data,
  }) async {
    return await _apiService.tryLogin(data: data);
  }

  /// 登出
  Future<void> logout() async {
  }
}
