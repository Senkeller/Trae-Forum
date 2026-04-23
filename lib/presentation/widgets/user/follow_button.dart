import 'package:flutter/material.dart';

/// 关注按钮状态枚举
enum FollowStatus {
  /// 未关注
  notFollowing,
  /// 已关注
  following,
  /// 互相关注
  mutual,
  /// 关注请求中
  loading,
}

/// 关注按钮组件
///
/// 支持以下功能：
/// - 关注/已关注状态切换
/// - 互相关注状态显示
/// - 加载状态
/// - 多种尺寸和样式
/// - 自定义回调
class FollowButton extends StatelessWidget {
  /// 当前关注状态
  final FollowStatus status;

  /// 点击回调
  final VoidCallback? onPressed;

  /// 按钮尺寸
  final double? width;

  /// 按钮高度
  final double height;

  /// 是否为小尺寸按钮
  final bool isSmall;

  /// 是否显示图标
  final bool showIcon;

  /// 自定义未关注文字
  final String? followText;

  /// 自定义已关注文字
  final String? followingText;

  /// 自定义互相关注文字
  final String? mutualText;

  /// 构造函数
  ///
  /// [status] 当前关注状态，默认 notFollowing
  /// [onPressed] 点击回调
  /// [width] 按钮宽度，默认自适应
  /// [height] 按钮高度，默认 36
  /// [isSmall] 是否小尺寸，默认 false
  /// [showIcon] 是否显示图标，默认 true
  /// [followText] 未关注时文字，默认 "关注"
  /// [followingText] 已关注时文字，默认 "已关注"
  /// [mutualText] 互相关注时文字，默认 "互相关注"
  const FollowButton({
    super.key,
    this.status = FollowStatus.notFollowing,
    this.onPressed,
    this.width,
    this.height = 36,
    this.isSmall = false,
    this.showIcon = true,
    this.followText,
    this.followingText,
    this.mutualText,
  });

  /// 小尺寸关注按钮
  const FollowButton.small({
    super.key,
    this.status = FollowStatus.notFollowing,
    this.onPressed,
    this.width,
    this.showIcon = false,
    this.followText,
    this.followingText,
    this.mutualText,
  })  : height = 28,
        isSmall = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (status) {
      case FollowStatus.loading:
        return _buildLoadingButton(colorScheme);
      case FollowStatus.notFollowing:
        return _buildFollowButton(colorScheme);
      case FollowStatus.following:
        return _buildFollowingButton(colorScheme);
      case FollowStatus.mutual:
        return _buildMutualButton(colorScheme);
    }
  }

  /// 构建加载状态按钮
  Widget _buildLoadingButton(ColorScheme colorScheme) {
    return SizedBox(
      width: width ?? (isSmall ? 64 : 80),
      height: height,
      child: Center(
        child: SizedBox(
          width: isSmall ? 16 : 20,
          height: isSmall ? 16 : 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: colorScheme.primary,
          ),
        ),
      ),
    );
  }

  /// 构建未关注状态按钮
  Widget _buildFollowButton(ColorScheme colorScheme) {
    final text = followText ?? '关注';

    return SizedBox(
      width: width,
      height: height,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 12 : 16,
            vertical: 0,
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon) ...[
              Icon(
                Icons.add,
                size: isSmall ? 14 : 16,
              ),
              const SizedBox(width: 2),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: isSmall ? 12 : 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建已关注状态按钮
  Widget _buildFollowingButton(ColorScheme colorScheme) {
    final text = followingText ?? '已关注';

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 12 : 16,
            vertical: 0,
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: BorderSide(color: colorScheme.outline),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: isSmall ? 12 : 14,
            fontWeight: FontWeight.w500,
            color: colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  /// 构建互相关注状态按钮
  Widget _buildMutualButton(ColorScheme colorScheme) {
    final text = mutualText ?? '互相关注';

    return SizedBox(
      width: width,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: isSmall ? 12 : 16,
            vertical: 0,
          ),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          side: BorderSide(color: colorScheme.outline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showIcon) ...[
              Icon(
                Icons.swap_horiz,
                size: isSmall ? 14 : 16,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 2),
            ],
            Text(
              text,
              style: TextStyle(
                fontSize: isSmall ? 12 : 14,
                fontWeight: FontWeight.w500,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 关注按钮（带确认对话框版本）
///
/// 取消关注时会弹出确认对话框
class FollowButtonWithConfirm extends StatefulWidget {
  /// 当前关注状态
  final FollowStatus status;

  /// 点击回调
  final ValueChanged<FollowStatus>? onStatusChanged;

  /// 按钮尺寸
  final double? width;

  /// 按钮高度
  final double height;

  /// 是否为小尺寸按钮
  final bool isSmall;

  /// 确认对话框标题
  final String? confirmTitle;

  /// 确认对话框内容
  final String? confirmContent;

  /// 确认按钮文字
  final String? confirmButtonText;

  /// 取消按钮文字
  final String? cancelButtonText;

  /// 构造函数
  ///
  /// [status] 当前关注状态
  /// [onStatusChanged] 状态变更回调
  /// [width] 按钮宽度
  /// [height] 按钮高度
  /// [isSmall] 是否小尺寸
  /// [confirmTitle] 确认对话框标题
  /// [confirmContent] 确认对话框内容
  /// [confirmButtonText] 确认按钮文字
  /// [cancelButtonText] 取消按钮文字
  const FollowButtonWithConfirm({
    super.key,
    this.status = FollowStatus.notFollowing,
    this.onStatusChanged,
    this.width,
    this.height = 36,
    this.isSmall = false,
    this.confirmTitle,
    this.confirmContent,
    this.confirmButtonText,
    this.cancelButtonText,
  });

  @override
  State<FollowButtonWithConfirm> createState() =>
      _FollowButtonWithConfirmState();
}

class _FollowButtonWithConfirmState extends State<FollowButtonWithConfirm> {
  late FollowStatus _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.status;
  }

  @override
  void didUpdateWidget(FollowButtonWithConfirm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.status != oldWidget.status) {
      _currentStatus = widget.status;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FollowButton(
      status: _currentStatus,
      width: widget.width,
      height: widget.height,
      isSmall: widget.isSmall,
      onPressed: _handlePressed,
    );
  }

  /// 处理按钮点击
  void _handlePressed() async {
    if (_currentStatus == FollowStatus.notFollowing) {
      // 关注操作
      _updateStatus(FollowStatus.loading);

      // 模拟网络请求
      await Future.delayed(const Duration(milliseconds: 500));

      _updateStatus(FollowStatus.following);
    } else {
      // 取消关注，显示确认对话框
      final confirmed = await _showUnfollowConfirmDialog();
      if (confirmed == true) {
        _updateStatus(FollowStatus.loading);

        // 模拟网络请求
        await Future.delayed(const Duration(milliseconds: 500));

        _updateStatus(FollowStatus.notFollowing);
      }
    }
  }

  /// 显示取消关注确认对话框
  Future<bool?> _showUnfollowConfirmDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(widget.confirmTitle ?? '取消关注'),
        content: Text(widget.confirmContent ?? '确定要取消关注吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(widget.cancelButtonText ?? '取消'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(widget.confirmButtonText ?? '确定'),
          ),
        ],
      ),
    );
  }

  /// 更新状态
  void _updateStatus(FollowStatus newStatus) {
    setState(() {
      _currentStatus = newStatus;
    });
    widget.onStatusChanged?.call(newStatus);
  }
}

/// 关注数量显示组件
///
/// 用于展示关注数和粉丝数
class FollowCountWidget extends StatelessWidget {
  /// 关注数
  final int followingCount;

  /// 粉丝数
  final int followerCount;

  /// 点击关注回调
  final VoidCallback? onFollowingTap;

  /// 点击粉丝回调
  final VoidCallback? onFollowerTap;

  /// 文字样式
  final TextStyle? style;

  /// 数字样式
  final TextStyle? numberStyle;

  /// 构造函数
  ///
  /// [followingCount] 关注数（必填）
  /// [followerCount] 粉丝数（必填）
  /// [onFollowingTap] 点击关注回调
  /// [onFollowerTap] 点击粉丝回调
  /// [style] 文字样式
  /// [numberStyle] 数字样式
  const FollowCountWidget({
    super.key,
    required this.followingCount,
    required this.followerCount,
    this.onFollowingTap,
    this.onFollowerTap,
    this.style,
    this.numberStyle,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final defaultStyle = style ??
        textTheme.bodyMedium?.copyWith(
          color: colorScheme.onSurfaceVariant,
        );

    final defaultNumberStyle = numberStyle ??
        textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.w600,
          color: colorScheme.onBackground,
        );

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 关注数
        GestureDetector(
          onTap: onFollowingTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatCount(followingCount),
                style: defaultNumberStyle,
              ),
              const SizedBox(width: 4),
              Text(
                '关注',
                style: defaultStyle,
              ),
            ],
          ),
        ),
        // 分隔线
        Container(
          width: 1,
          height: 16,
          margin: const EdgeInsets.symmetric(horizontal: 16),
          color: colorScheme.outline,
        ),
        // 粉丝数
        GestureDetector(
          onTap: onFollowerTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                _formatCount(followerCount),
                style: defaultNumberStyle,
              ),
              const SizedBox(width: 4),
              Text(
                '粉丝',
                style: defaultStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// 格式化数字
  String _formatCount(int count) {
    if (count >= 10000) {
      return '${(count / 10000).toStringAsFixed(1)}w';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}k';
    }
    return count.toString();
  }
}
