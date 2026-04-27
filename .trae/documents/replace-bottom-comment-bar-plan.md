# 替换 _BottomCommentBar 为 CommentInputBar 实施计划

## 目标
将 feed_detail_page.dart 中的 `_BottomCommentBar` 替换为新的 `CommentInputBar` 组件，实现图一和图二的设计效果。

## 数据结构分析

### FeedContentData 可用字段
- `replyNum` - 回复数量（评论数）
- `action` (UserAction) - 用户行为状态
  - `isLike` - 是否已点赞
  - `isFavorite` - 是否已收藏
  - `likeNum` - 点赞数量
  - `favoriteNum` - 收藏数量

### 缺失字段
- `commentsCount` - 使用 `replyNum` 替代
- `likeCount` - 使用 `action.likeNum` 替代
- `favoriteCount` - 使用 `action.favoriteNum` 替代
- `shareCount` - 暂无，使用 0 作为默认值
- `isLiked` - 使用 `action.isLike` 替代
- `isFavorited` - 使用 `action.isFavorite` 替代

## 实施步骤

### 步骤 1: 导入新组件
**文件**: `lib/presentation/pages/feed/feed_detail_page.dart`

在文件顶部添加导入：
```dart
import '../../widgets/comment_input_bar.dart';
```

### 步骤 2: 添加回调方法
在 `_FeedDetailPageState` 类中添加以下回调方法：

```dart
/// 处理点赞
Future<void> _handleLike() async {
  HapticFeedbackUtil.trigger(ref, HapticScene.tap);

  final topicId = int.tryParse(widget.feedId);
  if (topicId == null || topicId <= 0) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('无效的话题ID')));
    return;
  }

  final hasSession = await ref.read(isAuthenticatedAsyncProvider.future);
  if (!hasSession) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('请先登录后再点赞'),
        action: SnackBarAction(
          label: '登录',
          onPressed: () => context.push(RoutePaths.login),
        ),
      ),
    );
    return;
  }

  // 乐观更新 UI
  final currentIsLiked = _topicDetail?.action.isLike ?? false;
  final currentLikeNum = _topicDetail?.action.likeNum ?? 0;

  setState(() {
    if (_topicDetail != null) {
      _topicDetail = _topicDetail!.copyWith(
        action: _topicDetail!.action.copyWith(
          isLike: !currentIsLiked,
          likeNum: currentIsLiked
              ? (currentLikeNum - 1).clamp(0, currentLikeNum)
              : currentLikeNum + 1,
        ),
      );
    }
  });

  // 调用点赞 API
  try {
    await ref.read(likeProvider.notifier).toggleLike(topicId);
  } catch (e) {
    // 失败时回滚
    if (mounted) {
      setState(() {
        if (_topicDetail != null) {
          _topicDetail = _topicDetail!.copyWith(
            action: _topicDetail!.action.copyWith(
              isLike: currentIsLiked,
              likeNum: currentLikeNum,
            ),
          );
        }
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('点赞失败: $e')));
    }
  }
}

/// 处理收藏
Future<void> _handleFavorite() async {
  HapticFeedbackUtil.trigger(ref, HapticScene.tap);
  await _toggleBookmark();
}

/// 处理分享
void _handleShare() {
  HapticFeedbackUtil.trigger(ref, HapticScene.tap);
  final topicUrl = 'https://forum.trae.cn/t/${widget.feedId}';
  Clipboard.setData(ClipboardData(text: topicUrl));
  HapticFeedbackUtil.trigger(ref, HapticScene.copySuccess);
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(const SnackBar(content: Text('链接已复制到剪贴板')));
}
```

### 步骤 3: 替换组件使用
找到 `_BottomCommentBar` 的使用位置（约第 730-744 行），替换为：

```dart
CommentInputBar(
  isLoggedIn: isLoggedIn,
  isSending: _isSendingComment,
  replyingToUsername: _replyToUsername,
  onCancelReply: () {
    setState(() {
      _replyToUsername = null;
      _replyToPostNumber = null;
    });
  },
  onSend: (content) => _sendComment(content),
  onLoginTap: () => context.push(RoutePaths.login),
  commentCount: _topicDetail?.replyNum ?? 0,
  likeCount: _topicDetail?.action.likeNum ?? 0,
  favoriteCount: _topicDetail?.action.favoriteNum ?? 0,
  shareCount: 0,
  isLiked: _topicDetail?.action.isLike ?? false,
  isFavorited: _topicDetail?.action.isFavorite ?? false,
  onLikeTap: _handleLike,
  onFavoriteTap: _handleFavorite,
  onShareTap: _handleShare,
)
```

### 步骤 4: 删除旧组件定义
删除 `_BottomCommentBar` 和 `_BottomCommentBarState` 类的完整定义（约第 1900-2095 行）。

### 步骤 5: 更新说明文档
在「说明文档.md」中记录本次修改：
1. 更新进度记录，标记为已完成
2. 记录修改内容：替换底部评论栏组件
3. 记录测试结果

## 代码变更详情

### 修改 1: 导入语句（第 30 行后添加）
```dart
import '../../widgets/comment_input_bar.dart';
```

### 修改 2: 在 _FeedDetailPageState 中添加回调方法（第 514 行后添加）
添加 `_handleLike`、`_handleFavorite`、`_handleShare` 三个方法。

### 修改 3: 替换组件使用（第 730-744 行）
将 `_BottomCommentBar(...)` 替换为 `CommentInputBar(...)`。

### 修改 4: 删除旧组件（第 1900-2095 行）
删除 `_BottomCommentBar` 类和 `_BottomCommentBarState` 类的完整定义。

## 依赖检查
- ✅ CommentInputBar 组件已创建
- ✅ 组件已集成 flutter_quill
- ✅ FeedContentData model 有必要的字段
- ✅ likeProvider 已存在，可用于点赞功能
- ✅ _toggleBookmark 方法已存在，可用于收藏功能

## 风险与注意事项
1. 点赞功能使用现有的 likeProvider，需要确认 topicId 的解析逻辑
2. 收藏功能复用现有的 _toggleBookmark 方法
3. 分享功能暂时只复制链接到剪贴板
4. 需要测试展开/收起状态的切换是否正常

## 验证清单
- [ ] 导入语句正确添加
- [ ] 旧组件已删除
- [ ] 新组件参数正确传递
- [ ] 回调函数已实现
- [ ] flutter analyze 无错误
- [ ] 收起状态显示正确（左侧输入提示 + 右侧功能按钮）
- [ ] 展开状态显示正确（编辑器 + 工具栏 + 发布按钮）
- [ ] 点赞功能正常工作
- [ ] 收藏功能正常工作
- [ ] 分享功能正常工作
- [ ] 回复功能正常工作
