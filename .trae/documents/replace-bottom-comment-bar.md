# 替换 _BottomCommentBar 为 CommentInputBar 计划

## 目标
将 feed_detail_page.dart 中的 `_BottomCommentBar` 替换为新的 `CommentInputBar` 组件，实现图一和图二的设计效果。

## 分析

### 当前状态
- `_BottomCommentBar` 是一个私有组件，位于 feed_detail_page.dart 中
- 当前设计：左侧图片按钮 + 中间编辑器 + 右侧发送按钮
- 缺少：评论/点赞/收藏/分享按钮的显示

### 新组件特性
- `CommentInputBar` 已创建，位于 `lib/presentation/widgets/comment_input_bar.dart`
- 支持收起/展开两种状态
- 收起状态：左侧输入提示 + 右侧功能按钮（评论、点赞、收藏、分享）
- 展开状态：富文本编辑器 + 工具栏 + 发布按钮

## 实施步骤

### 步骤 1: 导入新组件
**文件**: `lib/presentation/pages/feed/feed_detail_page.dart`

在文件顶部添加导入：
```dart
import '../../widgets/comment_input_bar.dart';
```

### 步骤 2: 删除旧的 _BottomCommentBar 组件
**文件**: `lib/presentation/pages/feed/feed_detail_page.dart`

删除以下内容：
1. `_BottomCommentBar` 类定义（约 1900-2095 行）
2. `_BottomCommentBarState` 类

### 步骤 3: 修改使用 _BottomCommentBar 的地方
**文件**: `lib/presentation/pages/feed/feed_detail_page.dart`

找到所有使用 `_BottomCommentBar` 的地方，替换为 `CommentInputBar`。

需要传递的参数：
- `isLoggedIn`: 当前登录状态
- `isSending`: 是否正在发送
- `replyingToUsername`: 回复目标用户名
- `onCancelReply`: 取消回复回调
- `onSend`: 发送回调
- `onLoginTap`: 登录回调
- `commentCount`: 评论数量
- `likeCount`: 点赞数量
- `favoriteCount`: 收藏数量
- `shareCount`: 分享数量
- `isLiked`: 是否已点赞
- `isFavorited`: 是否已收藏
- `onLikeTap`: 点赞回调
- `onFavoriteTap`: 收藏回调
- `onShareTap`: 分享回调

### 步骤 4: 添加缺失的状态和数据
**文件**: `lib/presentation/pages/feed/feed_detail_page.dart`

需要确保页面有以下数据：
1. 评论数量 - 从 topic detail 中获取
2. 点赞数量 - 从 topic detail 中获取
3. 收藏数量 - 可能需要额外获取
4. 分享数量 - 可能需要额外获取或估算
5. 是否已点赞 - 从 topic detail 中获取
6. 是否已收藏 - 从 topic detail 中获取

### 步骤 5: 实现回调函数
**文件**: `lib/presentation/pages/feed/feed_detail_page.dart`

需要实现以下回调：
1. `onLikeTap` - 调用点赞 API
2. `onFavoriteTap` - 调用收藏 API
3. `onShareTap` - 显示分享选项

### 步骤 6: 验证编译
运行 flutter analyze 确保无错误。

## 详细代码修改

### 修改 1: 导入语句
```dart
// 在文件顶部添加
import '../../widgets/comment_input_bar.dart';
```

### 修改 2: 替换组件使用
```dart
// 旧代码
_BottomCommentBar(
  isLoggedIn: widget.isLoggedIn,
  isSending: _isSendingComment,
  isUploadingImage: _isUploadingImage,
  replyingToUsername: _replyingToUsername,
  onCancelReply: _cancelReply,
  onSend: _sendComment,
  onPickImage: _pickImagesForComment,
  onLoginTap: () => context.push(RoutePaths.login),
)

// 新代码
CommentInputBar(
  isLoggedIn: widget.isLoggedIn,
  isSending: _isSendingComment,
  replyingToUsername: _replyingToUsername,
  onCancelReply: _cancelReply,
  onSend: _sendComment,
  onLoginTap: () => context.push(RoutePaths.login),
  commentCount: _topicDetail?.commentsCount ?? 0,
  likeCount: _topicDetail?.likeCount ?? 0,
  favoriteCount: _topicDetail?.favoriteCount ?? 0,
  shareCount: 0, // 分享数量可能需要在 model 中添加
  isLiked: _topicDetail?.isLiked ?? false,
  isFavorited: _topicDetail?.isFavorited ?? false,
  onLikeTap: _handleLike,
  onFavoriteTap: _handleFavorite,
  onShareTap: _handleShare,
)
```

### 修改 3: 删除旧组件定义
删除 `_BottomCommentBar` 和 `_BottomCommentBarState` 类的完整定义。

### 修改 4: 添加回调方法
在 `_FeedDetailPageState` 中添加：
```dart
Future<void> _handleLike() async {
  // 实现点赞逻辑
}

Future<void> _handleFavorite() async {
  // 实现收藏逻辑
}

void _handleShare() {
  // 实现分享逻辑
}
```

## 依赖检查
- ✅ CommentInputBar 组件已创建
- ✅ 组件已集成 flutter_quill
- ✅ 组件已集成图片上传功能
- ⏳ 需要确认 topic detail model 中的字段名

## 风险与注意事项
1. 需要确认 `TopicDetail` model 中是否有 `favoriteCount` 和 `isFavorited` 字段
2. 如果没有，可能需要修改 model 或暂时使用默认值
3. 点赞/收藏/分享的回调需要调用相应的 API

## 验证清单
- [ ] 导入语句正确添加
- [ ] 旧组件已删除
- [ ] 新组件参数正确传递
- [ ] 回调函数已实现
- [ ] flutter analyze 无错误
- [ ] 收起状态显示正确（左侧输入提示 + 右侧功能按钮）
- [ ] 展开状态显示正确（编辑器 + 工具栏 + 发布按钮）
