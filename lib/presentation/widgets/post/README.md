# 帖子回复功能实现文档

## 概述

本文档描述了TRAE论坛帖子详情页面的回复功能实现，包括API服务、状态管理、UI组件和页面集成。

## 文件结构

```
lib/
├── core/network/
│   └── discourse_api_service.dart    # Discourse API服务（已扩展）
├── data/
│   ├── models/
│   │   ├── reply_result.dart         # 回复结果模型
│   │   ├── draft_model.dart          # 草稿模型
│   │   └── discourse/
│   │       └── discourse_post.dart   # 帖子模型（已存在）
│   └── repositories/
│       └── comment_repository.dart   # 评论仓库（已扩展）
├── presentation/
│   ├── providers/
│   │   └── reply_provider.dart       # 回复状态管理
│   ├── widgets/post/
│   │   ├── post_reply_input.dart     # 回复输入组件
│   │   ├── post_reply_list.dart      # 回复列表组件
│   │   └── README.md                 # 本文档
│   └── pages/topic/
│       └── topic_detail_page_example.dart  # 示例页面
```

## API功能

### DiscourseApiService 新增方法

1. **createPost** - 创建帖子/回复
   - POST /posts
   - 参数: topicId, raw, replyToPostNumber

2. **editPost** - 编辑帖子/回复
   - PUT /posts/{id}
   - 参数: postId, raw, editReason

3. **deletePost** - 删除帖子/回复
   - DELETE /posts/{id}
   - 参数: postId, forceDestroy

4. **saveDraft** - 保存草稿
   - POST /drafts
   - 参数: draftKey, data, sequence

5. **getDraft** - 获取草稿
   - GET /drafts/{draft_key}
   - 参数: draftKey

6. **deleteDraft** - 删除草稿
   - DELETE /drafts/{draft_key}
   - 参数: draftKey, sequence

7. **likePost** - 点赞帖子
   - POST /post_actions
   - 参数: postId

8. **unlikePost** - 取消点赞
   - DELETE /post_actions/{id}
   - 参数: postId

## 状态管理

### ReplyProvider

提供以下功能：

1. **ReplyNotifier** - 回复状态管理器
   - `sendReply()` - 发送回复
   - `saveDraft()` - 保存草稿
   - `loadDraft()` - 加载草稿
   - `deleteDraft()` - 删除草稿
   - `editReply()` - 编辑回复
   - `deleteReply()` - 删除回复

2. **CurrentReplyTarget** - 当前回复目标
   - 用于楼中楼回复
   - 管理回复的目标用户和楼层

3. **ReplyDraft** - 草稿内容管理
   - 管理输入框的草稿内容

4. **ReplyListRefresh** - 回复列表刷新触发器
   - 触发回复列表刷新

## UI组件

### PostReplyInput

帖子回复输入组件，功能包括：
- 多行文本输入
- 发送按钮（带加载状态）
- 字数统计
- 回复目标指示（楼中楼回复）
- 自动保存和加载草稿

### PostReplyBottomBar

帖子详情页底部操作栏，功能包括：
- 输入框占位（点击展开）
- 点赞按钮
- 评论数显示
- 收藏按钮
- 分享按钮

### ReplyInputDialog

全屏回复输入弹窗，功能包括：
- 更大的输入空间
- 与PostReplyInput集成
- 动画效果

### PostReplyList

帖子回复列表组件，功能包括：
- 显示所有回复
- 下拉刷新
- 上拉加载更多
- 空状态显示

### PostReplyItem

单个回复项组件，功能包括：
- 用户头像和名称
- 楼层号显示
- 回复内容（HTML渲染）
- 点赞按钮和数量
- 回复按钮（用于楼中楼）
- 时间显示
- 更多操作菜单（复制、举报、编辑、删除）

## 使用示例

### 基本使用

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'presentation/providers/reply_provider.dart';
import 'presentation/widgets/post/post_reply_input.dart';
import 'presentation/widgets/post/post_reply_list.dart';

class TopicDetailPage extends ConsumerWidget {
  final int topicId;

  const TopicDetailPage({super.key, required this.topicId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          // 回复列表
          Expanded(
            child: PostReplyList(
              topicId: topicId,
              posts: posts,
              onReplyTap: (post) {
                // 设置回复目标
                ref.read(currentReplyTargetProvider.notifier).setTarget(
                  postNumber: post.postNumber,
                  username: post.username,
                );
              },
            ),
          ),
          // 底部输入栏
          PostReplyBottomBar(
            onInputTap: () {
              ReplyInputDialog.show(
                context: context,
                topicId: topicId,
              );
            },
          ),
        ],
      ),
    );
  }
}
```

### 发送回复

```dart
final notifier = ref.read(replyNotifierProvider.notifier);
final result = await notifier.sendReply(
  topicId: topicId,
  content: '回复内容',
  replyToPostNumber: null, // 或指定楼层号进行楼中楼回复
);

if (result.success) {
  // 发送成功
} else {
  // 显示错误
  print(result.errorMessage);
}
```

### 楼中楼回复

```dart
// 点击某条回复的回复按钮
void onReplyTap(DiscoursePost post) {
  ref.read(currentReplyTargetProvider.notifier).setTarget(
    postNumber: post.postNumber,
    username: post.username,
  );

  // 显示回复输入
  ReplyInputDialog.show(
    context: context,
    topicId: widget.topicId,
  );
}
```

## 依赖项

确保在 `pubspec.yaml` 中包含以下依赖：

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^2.4.0
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1
  dio: ^5.3.0
  flutter_html: ^3.0.0-beta.2

dev_dependencies:
  build_runner: ^2.4.0
  freezed: ^2.4.0
  json_serializable: ^6.7.0
  riverpod_generator: ^2.3.0
```

## 注意事项

1. **认证要求**：所有回复相关API需要用户登录，确保在调用前检查登录状态
2. **CSRF Token**：Discourse API需要CSRF Token， DioClient需要正确配置
3. **错误处理**：所有API调用都有错误处理，建议监听replyProvider的状态变化
4. **草稿管理**：草稿会自动保存和加载，但建议定期手动保存重要内容
5. **楼中楼回复**：使用replyToPostNumber参数指定回复的目标楼层

## 后续优化建议

1. 实现实时消息推送（Message Bus）
2. 添加图片上传功能
3. 实现@用户功能
4. 添加表情选择器
5. 实现回复的嵌套显示（树形结构）
6. 添加回复的搜索和筛选功能
