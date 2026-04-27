import 'package:flutter/material.dart';

/// 滚动触底加载守卫
///
/// 用于管理列表滚动触底时的加载逻辑，防止重复触发、并发请求等问题。
/// 主要功能包括：
/// - 触底阈值检测：判断滚动位置是否接近底部
/// - 最小触发间隔：控制触发频率，避免过于频繁的加载请求
/// - 请求门闩：防止并发重复触发，确保同一时间只有一个加载请求在进行
///
/// 使用示例：
/// ```dart
/// final _loadGuard = ScrollLoadGuard();
///
/// void _onScroll() {
///   _loadGuard.tryTrigger(
///     scrollController: _scrollController,
///     onLoad: () async {
///       await loadMoreData();
///     },
///   );
/// }
/// ```
class ScrollLoadGuard {
  /// 触底阈值（像素）
  ///
  /// 当滚动位置距离底部小于此值时，视为接近底部，可触发加载。
  /// 默认值为 200 像素。
  final double threshold;

  /// 最小触发间隔（毫秒）
  ///
  /// 两次加载之间的最小时间间隔，用于控制加载频率。
  /// 默认值为 180 毫秒。
  final int minIntervalMs;

  /// 上次触发加载的时间戳
  DateTime? _lastTriggerTime;

  /// 请求门闩状态
  ///
  /// 当为 true 时表示有请求正在进行中，用于防止并发重复触发。
  bool _isLoading = false;

  /// 构造函数
  ///
  /// [threshold] 触底阈值，单位为像素，默认为 200
  /// [minIntervalMs] 最小触发间隔，单位为毫秒，默认为 180
  ScrollLoadGuard({
    this.threshold = 200,
    this.minIntervalMs = 180,
  });

  /// 检查当前是否有请求正在进行中
  ///
  /// 返回 true 表示有请求正在进行，false 表示没有
  bool get isLoading => _isLoading;

  /// 重置门闩状态
  ///
  /// 在某些特殊场景下（如错误恢复、手动刷新）可能需要手动重置加载状态。
  /// 正常情况下不需要调用此方法，门闩会在请求完成后自动释放。
  void reset() {
    _isLoading = false;
    _lastTriggerTime = null;
  }

  /// 检查滚动位置是否接近底部
  ///
  /// [controller] 滚动控制器
  ///
  /// 返回 true 表示滚动位置在阈值范围内（接近底部），false 表示不在
  bool _isNearBottom(ScrollController controller) {
    if (!controller.hasClients) return false;

    final position = controller.position;
    final maxScrollExtent = position.maxScrollExtent;
    final currentScroll = position.pixels;

    // 如果最大滚动范围为0或负数，说明内容不足，不需要加载更多
    if (maxScrollExtent <= 0) return false;

    // 检查是否接近底部
    return (maxScrollExtent - currentScroll) <= threshold;
  }

  /// 检查是否满足最小触发间隔
  ///
  /// 返回 true 表示距离上次触发已超过最小间隔，可以再次触发
  bool _isIntervalSatisfied() {
    if (_lastTriggerTime == null) return true;

    final elapsed = DateTime.now().difference(_lastTriggerTime!).inMilliseconds;
    return elapsed >= minIntervalMs;
  }

  /// 尝试触发加载
  ///
  /// 该方法会检查所有触发条件，只有全部满足时才会执行加载回调。
  ///
  /// 参数：
  /// - [scrollController] 滚动控制器，用于检测滚动位置
  /// - [onLoad] 加载回调函数，需要返回 [Future<void>]
  /// - [onError] 可选的错误处理回调，当加载过程中发生异常时调用
  ///
  /// 触发条件：
  /// 1. 滚动位置接近底部（在阈值范围内）
  /// 2. 距离上次触发已超过最小间隔
  /// 3. 当前没有正在进行的请求（门闩未锁定）
  ///
  /// 返回 [Future<void>]，表示触发操作的异步结果
  Future<void> tryTrigger({
    required ScrollController scrollController,
    required Future<void> Function() onLoad,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    // 检查滚动位置是否接近底部
    if (!_isNearBottom(scrollController)) return;

    // 检查是否满足最小触发间隔
    if (!_isIntervalSatisfied()) return;

    // 检查门闩状态，防止并发
    if (_isLoading) return;

    // 锁定门闩
    _isLoading = true;
    _lastTriggerTime = DateTime.now();

    try {
      // 执行加载回调
      await onLoad();
    } catch (error, stackTrace) {
      // 如果提供了错误处理回调，则调用它
      onError?.call(error, stackTrace);
      // 重新抛出异常，让调用方也能感知到错误
      rethrow;
    } finally {
      // 释放门闩
      _isLoading = false;
    }
  }

  /// 强制触发加载（忽略滚动位置检查）
  ///
  /// 此方法会跳过滚动位置检查，但仍会检查最小间隔和门闩状态。
  /// 适用于手动触发加载的场景（如点击"加载更多"按钮）。
  ///
  /// 参数：
  /// - [onLoad] 加载回调函数，需要返回 [Future<void>]
  /// - [onError] 可选的错误处理回调，当加载过程中发生异常时调用
  ///
  /// 返回 [Future<void>]，表示触发操作的异步结果
  Future<void> forceTrigger({
    required Future<void> Function() onLoad,
    void Function(Object error, StackTrace stackTrace)? onError,
  }) async {
    // 检查是否满足最小触发间隔
    if (!_isIntervalSatisfied()) return;

    // 检查门闩状态，防止并发
    if (_isLoading) return;

    // 锁定门闩
    _isLoading = true;
    _lastTriggerTime = DateTime.now();

    try {
      // 执行加载回调
      await onLoad();
    } catch (error, stackTrace) {
      // 如果提供了错误处理回调，则调用它
      onError?.call(error, stackTrace);
      // 重新抛出异常，让调用方也能感知到错误
      rethrow;
    } finally {
      // 释放门闩
      _isLoading = false;
    }
  }

  /// 检查是否可以触发加载
  ///
  /// 用于在 UI 层判断当前状态是否允许触发加载，可用于显示/隐藏加载指示器。
  ///
  /// 参数：
  /// - [scrollController] 滚动控制器，用于检测滚动位置
  ///
  /// 返回 true 表示所有条件都满足，可以触发加载
  bool canTrigger(ScrollController scrollController) {
    return _isNearBottom(scrollController) &&
        _isIntervalSatisfied() &&
        !_isLoading;
  }
}
