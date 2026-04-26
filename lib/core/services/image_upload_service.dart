import 'dart:io';
import 'package:dio/dio.dart' as dio_lib;
import '../network/dio_client.dart';

/// 图片上传结果
///
/// 包含上传成功后的图片 URL 或错误信息
class ImageUploadResult {
  /// 是否上传成功
  final bool success;

  /// 上传成功后的图片 URL
  final String? imageUrl;

  /// 错误信息（如果上传失败）
  final String? errorMessage;

  /// 原始文件名
  final String? fileName;

  /// 构造函数
  const ImageUploadResult({
    required this.success,
    this.imageUrl,
    this.errorMessage,
    this.fileName,
  });

  /// 创建成功结果
  factory ImageUploadResult.success(String imageUrl, {String? fileName}) {
    return ImageUploadResult(
      success: true,
      imageUrl: imageUrl,
      fileName: fileName,
    );
  }

  /// 创建失败结果
  factory ImageUploadResult.failure(String errorMessage, {String? fileName}) {
    return ImageUploadResult(
      success: false,
      errorMessage: errorMessage,
      fileName: fileName,
    );
  }
}

/// 图片上传服务
///
/// 处理图片上传到服务器，支持：
/// - 单张图片上传
/// - 多张图片批量上传
/// - 上传进度回调
/// - 上传失败重试
class ImageUploadService {
  static final ImageUploadService _instance = ImageUploadService._internal();
  factory ImageUploadService() => _instance;
  ImageUploadService._internal();



  /// 默认上传接口地址
  static const String _defaultUploadUrl = '/upload/image';

  /// 单张图片上传
  ///
  /// [filePath] 本地图片文件路径
  /// [uploadUrl] 上传接口地址，默认使用 $_defaultUploadUrl
  /// [fieldName] 表单字段名，默认 'file'
  /// [additionalData] 额外的表单数据
  /// [onProgress] 上传进度回调 (0.0 - 1.0)
  ///
  /// 返回上传结果 [ImageUploadResult]
  Future<ImageUploadResult> uploadImage({
    required String filePath,
    String uploadUrl = _defaultUploadUrl,
    String fieldName = 'file',
    Map<String, dynamic>? additionalData,
    Function(double progress)? onProgress,
  }) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) {
        return ImageUploadResult.failure('文件不存在: $filePath', fileName: filePath);
      }

      final fileName = filePath.split('/').last;
      final formData = dio_lib.FormData.fromMap({
        fieldName: await dio_lib.MultipartFile.fromFile(filePath, filename: fileName),
        if (additionalData != null) ...additionalData,
      });

      final response = await DioClient.dio.post(
        uploadUrl,
        data: formData,
        onSendProgress: (sent, total) {
          if (total > 0) {
            onProgress?.call(sent / total);
          }
        },
      );

      if (response.statusCode == 200) {
        // 解析响应数据，提取图片 URL
        // 根据实际 API 响应结构调整
        final imageUrl = _extractImageUrl(response.data);
        if (imageUrl != null) {
          return ImageUploadResult.success(imageUrl, fileName: fileName);
        } else {
          return ImageUploadResult.failure('无法从响应中提取图片 URL', fileName: fileName);
        }
      } else {
        return ImageUploadResult.failure(
          '上传失败: HTTP ${response.statusCode}',
          fileName: fileName,
        );
      }
    } on dio_lib.DioException catch (e) {
      return ImageUploadResult.failure(
        '网络错误: ${e.message}',
        fileName: filePath.split('/').last,
      );
    } catch (e) {
      return ImageUploadResult.failure(
        '上传出错: $e',
        fileName: filePath.split('/').last,
      );
    }
  }

  /// 批量上传图片
  ///
  /// [filePaths] 本地图片文件路径列表
  /// [uploadUrl] 上传接口地址
  /// [fieldName] 表单字段名
  /// [additionalData] 额外的表单数据
  /// [onProgress] 单个文件上传进度回调 (index, progress)
  /// [onCompleted] 单个文件上传完成回调 (index, result)
  ///
  /// 返回所有上传结果列表
  Future<List<ImageUploadResult>> uploadMultipleImages({
    required List<String> filePaths,
    String uploadUrl = _defaultUploadUrl,
    String fieldName = 'file',
    Map<String, dynamic>? additionalData,
    Function(int index, double progress)? onProgress,
    Function(int index, ImageUploadResult result)? onCompleted,
  }) async {
    final results = <ImageUploadResult>[];

    for (int i = 0; i < filePaths.length; i++) {
      final result = await uploadImage(
        filePath: filePaths[i],
        uploadUrl: uploadUrl,
        fieldName: fieldName,
        additionalData: additionalData,
        onProgress: (progress) => onProgress?.call(i, progress),
      );
      results.add(result);
      onCompleted?.call(i, result);
    }

    return results;
  }

  /// 带重试机制的图片上传
  ///
  /// [filePath] 本地图片文件路径
  /// [maxRetries] 最大重试次数，默认 3
  /// [retryDelay] 重试延迟，默认 1 秒
  /// 其他参数同 [uploadImage]
  Future<ImageUploadResult> uploadImageWithRetry({
    required String filePath,
    String uploadUrl = _defaultUploadUrl,
    String fieldName = 'file',
    Map<String, dynamic>? additionalData,
    Function(double progress)? onProgress,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 1),
  }) async {
    int attempts = 0;
    ImageUploadResult? lastResult;

    while (attempts < maxRetries) {
      attempts++;
      final result = await uploadImage(
        filePath: filePath,
        uploadUrl: uploadUrl,
        fieldName: fieldName,
        additionalData: additionalData,
        onProgress: onProgress,
      );

      if (result.success) {
        return result;
      }

      lastResult = result;

      // 如果不是最后一次尝试，等待后重试
      if (attempts < maxRetries) {
        await Future.delayed(retryDelay);
      }
    }

    return lastResult ?? ImageUploadResult.failure('上传失败，已达到最大重试次数');
  }

  /// 从响应数据中提取图片 URL
  ///
  /// [data] API 响应数据
  /// 返回图片 URL 字符串，如果无法提取则返回 null
  String? _extractImageUrl(dynamic data) {
    if (data == null) return null;

    // 尝试常见的响应格式
    if (data is Map) {
      // 常见字段名
      final possibleKeys = [
        'url',
        'imageUrl',
        'image_url',
        'fileUrl',
        'file_url',
        'path',
        'link',
        'src',
      ];

      for (final key in possibleKeys) {
        if (data.containsKey(key)) {
          final value = data[key];
          if (value is String && value.isNotEmpty) {
            return value;
          }
        }
      }

      // 尝试嵌套在 data 字段中
      if (data.containsKey('data') && data['data'] is Map) {
        return _extractImageUrl(data['data']);
      }
    }

    return null;
  }
}
