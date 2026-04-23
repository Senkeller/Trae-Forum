import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 设备信息数据类
class DeviceInfo {
  /// 设备 ID
  final String deviceId;

  /// 设备品牌
  final String brand;

  /// 设备型号
  final String model;

  /// 系统版本
  final String systemVersion;

  /// 应用版本
  final String appVersion;

  /// 应用版本号
  final String buildNumber;

  /// 包名
  final String packageName;

  /// 平台（Android/iOS）
  final String platform;

  /// 是否物理设备
  final bool isPhysicalDevice;

  const DeviceInfo({
    required this.deviceId,
    required this.brand,
    required this.model,
    required this.systemVersion,
    required this.appVersion,
    required this.buildNumber,
    required this.packageName,
    required this.platform,
    required this.isPhysicalDevice,
  });

  @override
  String toString() {
    return 'DeviceInfo(deviceId: $deviceId, brand: $brand, model: $model, '
        'systemVersion: $systemVersion, appVersion: $appVersion, '
        'buildNumber: $buildNumber, packageName: $packageName, '
        'platform: $platform, isPhysicalDevice: $isPhysicalDevice)';
  }
}

/// 网络状态枚举
enum NetworkStatus {
  /// 已连接（WiFi）
  wifi,

  /// 已连接（移动数据）
  mobile,

  /// 已连接（以太网）
  ethernet,

  /// 已连接（蓝牙）
  bluetooth,

  /// 已连接（VPN）
  vpn,

  /// 未连接
  none,

  /// 未知状态
  unknown,
}

/// 设备工具类
/// 提供设备信息获取、网络状态检查等功能
class DeviceUtil {
  DeviceUtil._();

  static DeviceInfo? _deviceInfo;
  static final _connectivity = Connectivity();

  // ==================== 设备信息 ====================

  /// 初始化设备信息
  /// 返回设备信息对象
  static Future<DeviceInfo> initDeviceInfo() async {
    if (_deviceInfo != null) return _deviceInfo!;

    final deviceInfo = DeviceInfoPlugin();
    final packageInfo = await PackageInfo.fromPlatform();

    String deviceId = '';
    String brand = '';
    String model = '';
    String systemVersion = '';
    bool isPhysicalDevice = true;

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
      brand = androidInfo.brand;
      model = androidInfo.model;
      systemVersion = 'Android ${androidInfo.version.release}';
      isPhysicalDevice = androidInfo.isPhysicalDevice;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor ?? '';
      brand = 'Apple';
      model = iosInfo.utsname.machine;
      systemVersion = 'iOS ${iosInfo.systemVersion}';
      isPhysicalDevice = iosInfo.isPhysicalDevice;
    }

    _deviceInfo = DeviceInfo(
      deviceId: deviceId,
      brand: brand,
      model: model,
      systemVersion: systemVersion,
      appVersion: packageInfo.version,
      buildNumber: packageInfo.buildNumber,
      packageName: packageInfo.packageName,
      platform: Platform.operatingSystem,
      isPhysicalDevice: isPhysicalDevice,
    );

    // 保存设备 ID
    await _saveDeviceId(deviceId);

    return _deviceInfo!;
  }

  /// 获取设备信息
  /// 返回设备信息对象，未初始化时返回 null
  static DeviceInfo? get deviceInfo => _deviceInfo;

  /// 获取设备 ID
  /// 返回设备 ID，未初始化时返回空字符串
  static String get deviceId => _deviceInfo?.deviceId ?? '';

  /// 获取设备品牌
  /// 返回设备品牌，未初始化时返回空字符串
  static String get brand => _deviceInfo?.brand ?? '';

  /// 获取设备型号
  /// 返回设备型号，未初始化时返回空字符串
  static String get model => _deviceInfo?.model ?? '';

  /// 获取系统版本
  /// 返回系统版本，未初始化时返回空字符串
  static String get systemVersion => _deviceInfo?.systemVersion ?? '';

  /// 获取应用版本
  /// 返回应用版本，未初始化时返回空字符串
  static String get appVersion => _deviceInfo?.appVersion ?? '';

  /// 获取应用版本号
  /// 返回应用版本号，未初始化时返回空字符串
  static String get buildNumber => _deviceInfo?.buildNumber ?? '';

  /// 获取包名
  /// 返回包名，未初始化时返回空字符串
  static String get packageName => _deviceInfo?.packageName ?? '';

  /// 获取平台
  /// 返回平台名称（android/ios）
  static String get platform => Platform.operatingSystem;

  /// 判断是否为 Android
  /// 返回是否为 Android 平台
  static bool get isAndroid => Platform.isAndroid;

  /// 判断是否为 iOS
  /// 返回是否为 iOS 平台
  static bool get isIOS => Platform.isIOS;

  /// 判断是否为物理设备
  /// 返回是否为物理设备
  static bool get isPhysicalDevice => _deviceInfo?.isPhysicalDevice ?? true;

  /// 判断是否为模拟器
  /// 返回是否为模拟器
  static bool get isEmulator => !isPhysicalDevice;

  /// 保存设备 ID
  /// [deviceId] 设备 ID
  static Future<void> _saveDeviceId(String deviceId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('device_id', deviceId);
  }

  /// 获取保存的设备 ID
  /// 返回保存的设备 ID
  static Future<String> getSavedDeviceId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('device_id') ?? '';
  }

  // ==================== 网络状态 ====================

  /// 检查网络连接状态
  /// 返回当前网络状态
  static Future<NetworkStatus> checkNetworkStatus() async {
    final result = await _connectivity.checkConnectivity();
    return _mapConnectivityResult(result.first);
  }

  /// 监听网络状态变化
  /// 返回网络状态流
  static Stream<NetworkStatus> get onNetworkChanged {
    return _connectivity.onConnectivityChanged.map(
      (results) => _mapConnectivityResult(results.first),
    );
  }

  /// 将 ConnectivityResult 映射为 NetworkStatus
  /// [result] ConnectivityResult
  /// 返回 NetworkStatus
  static NetworkStatus _mapConnectivityResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        return NetworkStatus.wifi;
      case ConnectivityResult.mobile:
        return NetworkStatus.mobile;
      case ConnectivityResult.ethernet:
        return NetworkStatus.ethernet;
      case ConnectivityResult.bluetooth:
        return NetworkStatus.bluetooth;
      case ConnectivityResult.vpn:
        return NetworkStatus.vpn;
      case ConnectivityResult.none:
        return NetworkStatus.none;
      default:
        return NetworkStatus.unknown;
    }
  }

  /// 检查是否有网络连接
  /// 返回是否有网络连接
  static Future<bool> get isConnected async {
    final status = await checkNetworkStatus();
    return status != NetworkStatus.none;
  }

  /// 检查是否为 WiFi 连接
  /// 返回是否为 WiFi 连接
  static Future<bool> get isWifi async {
    final status = await checkNetworkStatus();
    return status == NetworkStatus.wifi;
  }

  /// 检查是否为移动数据连接
  /// 返回是否为移动数据连接
  static Future<bool> get isMobile async {
    final status = await checkNetworkStatus();
    return status == NetworkStatus.mobile;
  }

  // ==================== 存储路径 ====================

  /// 获取应用文档目录
  /// 返回应用文档目录路径
  static Future<String> getDocumentPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  /// 获取临时目录
  /// 返回临时目录路径
  static Future<String> getTempPath() async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  /// 获取缓存目录
  /// 返回缓存目录路径
  static Future<String> getCachePath() async {
    final directory = await getApplicationCacheDirectory();
    return directory.path;
  }

  /// 获取外部存储目录（仅 Android）
  /// 返回外部存储目录路径，iOS 返回 null
  static Future<String?> getExternalStoragePath() async {
    if (!isAndroid) return null;
    final directory = await getExternalStorageDirectory();
    return directory?.path;
  }

  /// 获取下载目录
  /// 返回下载目录路径
  static Future<String?> getDownloadPath() async {
    if (isAndroid) {
      return getExternalStoragePath();
    }
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // ==================== 屏幕信息 ====================

  /// 获取屏幕尺寸
  /// [context] BuildContext
  /// 返回屏幕尺寸
  static Size getScreenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  /// 获取屏幕宽度
  /// [context] BuildContext
  /// 返回屏幕宽度
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  /// 获取屏幕高度
  /// [context] BuildContext
  /// 返回屏幕高度
  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  /// 获取屏幕短边
  /// [context] BuildContext
  /// 返回屏幕短边长度
  static double getScreenShortestSide(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide;
  }

  /// 获取屏幕像素密度
  /// [context] BuildContext
  /// 返回屏幕像素密度
  static double getDevicePixelRatio(BuildContext context) {
    return MediaQuery.of(context).devicePixelRatio;
  }

  /// 判断是否为平板设备
  /// [context] BuildContext
  /// 返回是否为平板设备
  static bool isTablet(BuildContext context) {
    final shortestSide = getScreenShortestSide(context);
    return shortestSide >= 600;
  }

  /// 判断是否为横屏
  /// [context] BuildContext
  /// 返回是否为横屏
  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  /// 判断是否为竖屏
  /// [context] BuildContext
  /// 返回是否为竖屏
  static bool isPortrait(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.portrait;
  }

  // ==================== 辅助方法 ====================

  /// 获取 User-Agent
  /// 返回 User-Agent 字符串
  static String get userAgent {
    if (_deviceInfo == null) {
      return 'TRAE-Forum-Flutter/1.0.0';
    }
    return 'TRAE-Forum-Flutter/${_deviceInfo!.appVersion} '
        '(${_deviceInfo!.platform}; ${_deviceInfo!.systemVersion}; ${_deviceInfo!.model})';
  }

  /// 获取应用信息字符串
  /// 返回应用信息字符串
  static String get appInfo {
    if (_deviceInfo == null) return '';
    return 'v${_deviceInfo!.appVersion} (${_deviceInfo!.buildNumber})';
  }

  /// 获取完整设备信息字符串
  /// 返回完整设备信息字符串
  static String get fullDeviceInfo {
    if (_deviceInfo == null) return '';
    return '${_deviceInfo!.brand} ${_deviceInfo!.model} / ${_deviceInfo!.systemVersion}';
  }
}

/// 网络状态扩展
extension NetworkStatusExtension on NetworkStatus {
  /// 获取网络状态描述
  /// 返回网络状态描述字符串
  String get label {
    switch (this) {
      case NetworkStatus.wifi:
        return 'WiFi';
      case NetworkStatus.mobile:
        return '移动数据';
      case NetworkStatus.ethernet:
        return '以太网';
      case NetworkStatus.bluetooth:
        return '蓝牙';
      case NetworkStatus.vpn:
        return 'VPN';
      case NetworkStatus.none:
        return '无网络';
      case NetworkStatus.unknown:
        return '未知';
    }
  }

  /// 判断是否已连接
  /// 返回是否已连接
  bool get isConnected => this != NetworkStatus.none;

  /// 判断是否为 WiFi
  /// 返回是否为 WiFi
  bool get isWifi => this == NetworkStatus.wifi;

  /// 判断是否为移动数据
  /// 返回是否为移动数据
  bool get isMobile => this == NetworkStatus.mobile;
}
