# Discourse 创建话题 API 逆向分析文档

> 基于 TRAE 项目代码逆向分析  
> 分析日期: 2026-04-26  
> 目标平台: https://forum.trae.cn

---

## 一、API 概览

| 项目 | 内容 |
|------|------|
| **API 端点** | `POST /posts` |
| **基础 URL** | `https://forum.trae.cn` |
| **完整 URL** | `https://forum.trae.cn/posts` |
| **请求方式** | POST |
| **Content-Type** | `application/json` (或 `application/x-www-form-urlencoded`) |

---

## 二、请求参数

### 2.1 请求体 (Body)

| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| `title` | String | ✅ 是 | 话题标题 |
| `raw` | String | ✅ 是 | 话题内容（Markdown 格式） |
| `category` | Integer | ❌ 否 | 分类 ID，指定话题所属分类 |
| `reply_to_post_number` | Integer | ❌ 否 | 回复的帖子编号（用于楼中楼回复） |

### 2.2 请求头 (Headers)

| 头部字段 | 值 | 说明 |
|----------|-----|------|
| `X-Requested-With` | `XMLHttpRequest` | 标识 AJAX 请求 |
| `Discourse-Logged-In` | `true` | 标识用户已登录 |
| `Discourse-Present` | `true` | 标识用户在线 |
| `X-CSRF-Token` | `{csrf_token}` | CSRF 防护令牌（可选，但建议携带） |

---

## 三、代码实现分析

### 3.1 核心实现代码

**文件位置**: `lib/core/network/discourse_api_service.dart` (第 626-662 行)

```dart
/// 创建新话题
///
/// [title] 话题标题
/// [raw] 话题内容（Markdown格式）
/// [category] 分类ID（可选）
/// [replyToPostNumber] 回复的帖子编号（可选，用于楼中楼回复）
/// 调用 Discourse POST /posts API
Future<Response> createTopic({
  required String title,
  required String raw,
  int? category,
  int? replyToPostNumber,
}) async {
  final data = <String, dynamic>{'title': title, 'raw': raw};

  if (category != null) {
    data['category'] = category;
  }

  if (replyToPostNumber != null) {
    data['reply_to_post_number'] = replyToPostNumber;
  }

  return _dio.post(
    '$_baseUrl/posts',
    data: data,
    options: Options(
      headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'Discourse-Logged-In': 'true',
        'Discourse-Present': 'true',
      },
    ),
  );
}
```

### 3.2 上层封装调用

**文件位置**: `lib/core/network/api_service.dart` (第 905-944 行)

```dart
/// 发布动态
Future<CreateFeedResponse> postCreateFeed({
  required Map<String, String> data,
}) async {
  try {
    final title = data['title'] ?? '';
    final content = data['content'] ?? '';
    final categoryStr = data['category'];
    final category = categoryStr != null ? int.tryParse(categoryStr) : null;

    await _discourseApi.createTopic(
      title: title,
      raw: content,
      category: category,
    );

    return CreateFeedResponse(
      status: 200,
      message: 'success',
      data: {'title': title},
    );
  } catch (e) {
    if (e is DioException) {
      if (e.response?.statusCode == 403) {
        return CreateFeedResponse(
          status: 401,
          message: 'Unauthorized - please login first',
        );
      }
      return CreateFeedResponse(
        status: e.response?.statusCode ?? 500,
        message: 'Failed to create feed: $e',
      );
    }
    return CreateFeedResponse(
      status: 500,
      message: 'Failed to create feed: $e',
    );
  }
}
```

---

## 四、CSRF Token 机制

### 4.1 Token 获取端点

| 项目 | 内容 |
|------|------|
| **端点** | `GET /session/csrf.json` |
| **响应格式** | JSON |

### 4.2 Token 管理器实现

**文件位置**: `lib/core/network/interceptors/csrf_token_manager.dart`

```dart
class DiscourseCsrfToken {
  static String? _token;
  static DateTime? _tokenTime;
  static const Duration _tokenValidityPeriod = Duration(minutes: 30);

  /// 从 CSRF 专用端点获取 Token
  static Future<bool> fetchToken(Dio dio) async {
    final response = await dio.get('/session/csrf.json');
    if (response.data != null && response.data is Map) {
      final payload = response.data as Map;
      final tokenValue = payload['csrfToken'] ?? payload['csrf'] ?? payload['token'];
      final newToken = tokenValue is String ? tokenValue : tokenValue?.toString();
      if (newToken != null && newToken.isNotEmpty) {
        _token = newToken;
        _tokenTime = DateTime.now();
        return true;
      }
    }
    return false;
  }

  /// 确保拥有有效的 CSRF Token
  static Future<void> ensureValid(Dio dio) async {
    if (isExpired) {
      await fetchToken(dio);
    }
  }
}
```

### 4.3 Token 响应格式

```json
{
  "csrfToken": "abc123xyz..."
}
```

---

## 五、响应结果

### 5.1 成功响应 (200 OK)

```json
{
  "id": 12345,
  "name": "username",
  "username": "username",
  "avatar_template": "/user_avatar/forum.trae.cn/username/{size}/1_1.png",
  "created_at": "2024-01-15T10:30:00.000Z",
  "cooked": "<p>话题内容 HTML</p>",
  "post_number": 1,
  "post_type": 1,
  "updated_at": "2024-01-15T10:30:00.000Z",
  "reply_count": 0,
  "reply_to_post_number": null,
  "quote_count": 0,
  "incoming_link_count": 0,
  "reads": 0,
  "readers_count": 0,
  "score": 0,
  "yours": true,
  "topic_id": 6789,
  "topic_slug": "topic-title",
  "display_username": "User Name",
  "primary_group_name": null,
  "flair_name": null,
  "flair_url": null,
  "flair_bg_color": null,
  "flair_color": null,
  "version": 1,
  "can_edit": true,
  "can_delete": true,
  "can_permanently_delete": false,
  "can_wiki": false,
  "user_title": null,
  "bookmarked": false,
  "raw": "原始 Markdown 内容",
  "actions_summary": [],
  "moderator": false,
  "admin": false,
  "staff": false,
  "user_id": 123,
  "draft_sequence": 1,
  "hidden": false,
  "trust_level": 1,
  "deleted_at": null,
  "user_deleted": false,
  "edit_reason": null,
  "wiki": false,
  "reviewable_id": null,
  "reviewable_score_count": 0,
  "reviewable_score_pending_count": 0
}
```

### 5.2 错误响应

| HTTP 状态码 | 说明 |
|-------------|------|
| `403` | 未授权 - 用户未登录 |
| `422` | 参数错误 - 标题或内容为空 |
| `429` | 请求过于频繁 |
| `500` | 服务器内部错误 |

---

## 六、使用示例

### 6.1 基础调用示例

```dart
// 创建简单话题
final response = await discourseApi.createTopic(
  title: '这是一个测试话题',
  raw: '这是话题的详细内容，支持 **Markdown** 格式。',
);

// 创建带分类的话题
final response = await discourseApi.createTopic(
  title: 'Bug 反馈',
  raw: '发现了一个问题...',
  category: 5, // Bug 反馈分类
);
```

### 6.2 完整调用流程（含 CSRF）

```dart
// 1. 确保 CSRF Token 有效
await DiscourseCsrfToken.ensureValid(dio);

// 2. 获取 Token
final csrfToken = DiscourseCsrfToken.token;

// 3. 发送创建请求
final response = await dio.post(
  'https://forum.trae.cn/posts',
  data: {
    'title': '话题标题',
    'raw': '话题内容',
    'category': 1,
  },
  options: Options(
    headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'Discourse-Logged-In': 'true',
      'Discourse-Present': 'true',
      'X-CSRF-Token': csrfToken,
    },
  ),
);
```

---

## 七、注意事项

1. **认证要求**：用户必须已登录（携带有效的 Session Cookie）
2. **CSRF 防护**：虽然代码中未强制要求 CSRF Token，但建议携带以增强安全性
3. **内容格式**：`raw` 字段支持标准 Markdown 语法
4. **分类限制**：某些分类可能需要特定权限才能发布
5. **频率限制**：Discourse 通常有发帖频率限制，避免过于频繁的请求

---

## 八、相关 API 对比

| 功能 | 端点 | 说明 |
|------|------|------|
| 创建话题 | `POST /posts` | 本 API，创建新话题 |
| 创建评论 | `POST /posts` | 相同端点，需传入 `topic_id` |
| 上传图片 | `POST /uploads.json` | 先上传图片，再插入到内容中 |
| 保存草稿 | `POST /drafts` | 自动保存草稿功能 |

---

## 九、参考文件

- `lib/core/network/discourse_api_service.dart` - API 服务实现
- `lib/core/network/api_service.dart` - 上层业务封装
- `lib/core/network/interceptors/csrf_token_manager.dart` - CSRF Token 管理
- `test/write_operations_test.dart` - 单元测试

---

*文档生成时间: 2026-04-26*
