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
```