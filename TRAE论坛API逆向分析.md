# TRAE 论坛 API 逆向分析文档

## 一、项目概述

### 1.1 分析目标
对 `https://forum.trae.cn/` 论坛进行 API 逆向工程，获取完整的接口规范、数据模型、业务逻辑，为后续开发提供技术支撑。

### 1.2 分析时间
2026-04-24

### 1.3 技术栈识别
- **框架**: Discourse (开源论坛系统)
- **服务器**: volcalb
- **压缩**: Brotli (content-encoding: br)
- **认证方式**: 基于 Session/Cookie

---

## 二、API 端点总览

### 2.1 公开端点（无需认证）

| 端点 | 功能 | 返回内容 |
|------|------|----------|
| `/site.json` | 站点全局配置 | 通知类型、信任等级、过滤条件、帖子动作类型、颜色主题 |
| `/categories.json` | 分类列表 | 所有分类的元数据 |
| `/tags.json` | 标签列表 | 标签详情和热门标签 |
| `/latest.json` | 最新主题列表 | 按活动时间排序的主题 |
| `/search.json?q={query}` | 搜索功能 | 匹配关键词的帖子 |
| `/t/{topic_id}.json` | 主题详情 | 完整主题信息、帖子流、关联主题 |
| `/c/{category_id}.json` | 分类详情 | 分类下主题列表 |
| `/u/{username}.json` | 用户资料 | 用户信息、徽章、统计 |
| `/u/{username}/activity.json` | 用户活动 | 用户发布的帖子历史 |

### 2.2 认证端点（需要登录）

| 端点 | 功能 | 错误响应 |
|------|------|----------|
| `/notifications.json` | 通知列表 | `{"errors": ["not_logged_in"]}` |
| `/bookmarks.json` | 收藏列表 | `{"errors": ["not_logged_in"]}` |
| `/drafts.json` | 草稿箱 | `{"errors": ["not_logged_in"]}` |

### 2.3 写操作端点（需要认证）

| 端点 | 方法 | 功能 | 认证方式 |
|------|------|------|----------|
| `/posts.json` | POST | 创建话题/回复 | API Key 或 Session |
| `/post_actions.json` | POST | 点赞/举报等操作 | API Key 或 Session |
| `/topics.json` | POST | 创建话题（专用） | API Key 或 Session |
| `/u/{username}.json` | PUT | 更新用户资料 | API Key |

---

## 三、认证方式详解

### 3.1 API Key 认证（推荐用于开发）

**适用场景**: 第三方应用、机器人、管理工具

**请求头格式**:
```http
Api-Key: {api_key}
Api-Username: {username}
Content-Type: application/json
```

**示例**:
```bash
curl -X POST "https://forum.trae.cn/posts.json" \
  -H "Content-Type: application/json" \
  -H "Api-Key: your_api_key_here" \
  -H "Api-Username: system" \
  -d '{"title": "新话题标题", "raw": "话题内容", "category": 11}'
```

**注意**: API Key 需要从 Admin Panel 获取，适用于自动化脚本和后端服务。

### 3.2 Session/Cookie 认证（普通用户登录）

**适用场景**: 模拟用户操作、浏览器自动化

**登录流程**:
1. 调用登录接口获取 Session
2. 将 Session 存入 Cookie
3. 后续请求携带 Cookie

**登录接口**: `POST /session.json`
```json
{
  "login": "username_or_email",
  "password": "password"
}
```

**登录成功响应**:
```json
{
  "user": {
    "id": 9,
    "username": "TRAE-小阳",
    "email": "user@example.com"
  }
}
```

**关键 Cookie（TRAE 论坛）**:
| Cookie 名称 | 说明 | 域名 |
|-------------|------|------|
| `_forum_session` | Forum Session 标识 | forum.trae.cn |
| `_t` | 临时 Token | forum.trae.cn |
| `passport_csrf_token` | 主站 CSRF Token | trae.cn |

**CSRF Token 获取**:
- 从页面 `<meta name="csrf-token">` 标签获取
- 每次页面加载都会更新

**创建话题前的 Draft 机制**:
```http
GET /draft.json?draft_key=new_topic
```
响应:
```json
{
  "draft": null,
  "draft_sequence": 5
}
```

**保存 Draft**:
```http
PUT /draft.json
Content-Type: application/json

{
  "draft_key": "new_topic",
  "data": {
    "title": "草稿标题",
    "reply": "",
    "action": "createTopic",
    "categoryId": 11,
    "tags": ["test"]
  },
  "sequence": 5
}
```

### 3.3 创建话题 API（核心）

**端点**: `POST https://forum.trae.cn/posts.json`

**认证要求**: 必须携带有效的 Session Cookie 或 API Key

**请求头（从浏览器提取）**:
```http
POST /posts.json HTTP/1.1
Host: forum.trae.cn
Content-Type: application/json
x-csrf-token: 0hShy-ILRKma2ONijV_Et-Dz7J4X6l31OXP-_z1yscO67DlMI5F-RcGe9fLZJVpyzvTN4C1l3GQRFabl74Txng
discourse-logged-in: true
discourse-present: true
x-requested-with: XMLHttpRequest
Cookie: _forum_session=xxx; _t=yyy
```

**请求体参数**:
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| `title` | string | **创建话题时必填** | 话题标题（最大255字符） |
| `raw` | string | **必填** | 话题正文内容（支持 Markdown） |
| `topic_id` | integer | **回复时必填** | 话题ID（提供则创建回复） |
| `category` | integer | 可选 | 分类 ID（默认分类为 1） |
| `tags` | array | 可选 | 标签名称数组 |
| `reply_to_post_number` | integer | 可选 | 回复指定楼层 |
| `archetype` | string | 可选 | `regular`(普通话题) 或 `private_message`(私信) |
| `target_recipients` | string | 可选 | 私信接收人（逗号分隔用户名） |
| `created_at` | string | 可选 | ISO 8601 时间戳 |
| `embed_url` | string | 可选 | 外部系统关联 URL |
| `external_id` | string | 可选 | 外部系统 ID |
| `auto_track` | boolean | 可选 | 是否自动跟踪话题（默认 true） |

**创建话题完整示例**:
```json
{
  "title": "【测试】API 创建话题测试",
  "raw": "这是通过 API 创建的话题内容。\n\n支持 Markdown 格式：\n- 列表\n- **粗体**\n- `代码`",
  "category": 11,
  "tags": ["test", "api测试"]
}
```

**创建回复完整示例**:
```json
{
  "raw": "这是对指定话题的回复内容",
  "topic_id": 9360,
  "reply_to_post_number": 5
}
```

**成功响应（201 Created）**:
```json
{
  "id": 12345,
  "name": "",
  "username": "用户名",
  "avatar_template": "/user_avatar/forum.trae.cn/username/{size}/123_2.png",
  "created_at": "2026-04-24T12:00:00.000Z",
  "raw": "话题正文",
  "cooked": "<p>话题正文</p>",
  "post_number": 1,
  "post_type": 1,
  "posts_count": 1,
  "topic_id": 12345,
  "topic_slug": "topic",
  "yours": true,
  "user_id": 9,
  "draft_sequence": 3,
  "pending_posts": []
}
```

**错误响应**:
| 状态码 | 错误类型 | 说明 |
|--------|----------|------|
| 403 | `not_logged_in` | 未登录或 Session 失效 |
| 403 | `invalid_access` | 权限不足（如信任等级不够） |
| 422 | `can't_perform_action` | 操作被拒绝（如禁言状态） |
| 429 | `rate_limit` | 请求过于频繁 |
| 500 | `server_error` | 服务器内部错误 |

### 3.4 新建话题页面 API（/new.json）

**端点**: `GET https://forum.trae.cn/new.json`

**功能**: 获取新建话题页面的上下文信息，包括可用分类、标签、用户信息等

**请求头**:
```http
GET /new.json HTTP/1.1
Host: forum.trae.cn
x-csrf-token: 0hShy-ILRKma2ONijV_Et-Dz7J4X6l31OXP-_z1yscO67DlMI5F-RcGe9fLZJVpyzvTN4C1l3GQRFabl74Txng
discourse-logged-in: true
discourse-present: true
x-requested-with: XMLHttpRequest
```

**响应关键字段**:
```json
{
  "users": [...],
  "topic_list": {
    "can_create_topic": true,
    "more_topics_url": "/new?page=1",
    "per_page": 30,
    "top_tags": [
      {"id": 47, "name": "Code-with-SOLO", "slug": "47-tag"},
      {"id": 46, "name": "新SOLO初体验", "slug": "46-tag"},
      ...
    ]
  }
}
```

### 3.5 编辑器提示 API

**端点**: `GET https://forum.trae.cn/composer_messages?composer_action=createTopic`

**功能**: 获取创建话题时的编辑器提示信息

**响应示例**:
```json
{
  "composer_messages": [{
    "id": "education",
    "templateName": "education",
    "wait_for_typing": true,
    "body": "<p>感谢您对 TRAE 官方中文社区 做出贡献！</p><p>发帖之前，请选择一个类别或标签...</p>"
  }]
}
```

### 3.6 创建回复 API

**端点**: `POST https://forum.trae.cn/posts.json`

**请求体参数**:
```json
{
  "raw": "必填 - 回复内容",
  "topic_id": "必填 - 话题 ID",
  "reply_to_post_number": "可选 - 回复指定楼层"
}
```

**示例**:
```json
{
  "raw": "这是我的回复内容",
  "topic_id": 9360,
  "reply_to_post_number": 5
}
```

**回复成功响应**: 与创建话题相同，新增 `post_number` 表示楼层号。

### 3.5 点赞/操作 API

**端点**: `POST https://forum.trae.cn/post_actions.json`

**请求体参数**:
```json
{
  "id": "必填 - 帖子 ID",
  "post_action_type_id": "必填 - 操作类型 ID",
  "flag_topic": "可选 - 是否举报整个话题（仅举报时）"
}
```

**常用操作类型 ID**:
| post_action_type_id | name_key | 说明 |
|---------------------|----------|------|
| 2 | like | 点赞 |
| 3 | off_topic | 偏离话题举报 |
| 4 | inappropriate | 不当言论举报 |
| 6 | notify_user | 私信通知 |
| 7 | notify_moderators | 举报版主 |
| 8 | spam | 垃圾信息举报 |

**点赞示例**:
```json
{
  "id": 59465,
  "post_action_type_id": 2
}
```

**取消操作**: 使用 `DELETE /post_actions/{id}.json`

### 3.6 更新话题状态

**端点**: `PUT https://forum.trae.cn/topic/{id}.json`

**请求体参数**:
```json
{
  "topic_id": 9360,
  "status": "closed",
  "enabled": "true",
  "until": "2030-12-31"
}
```

**可用状态**: `closed`, `pinned`, `pinned_globally`, `archived`, `visible`

### 3.7 话题定时器

**端点**: `POST https://forum.trae.cn/topic/{id}/timer.json`

**请求体参数**:
```json
{
  "time": "24",
  "status_type": "close",
  "based_on_last_post": false,
  "category_id": 11
}
```

### 3.8 用户操作相关

**更新用户资料**: `PUT /u/{username}.json`
```json
{
  "name": "新昵称",
  "bio_raw": "个人简介"
}
```

**更新头像**: `PUT /u/{username}/preferences/avatar.json`
```json
{
  "upload_id": 12345,
  "type": "uploaded"
}
```

**发送私信**: 通过创建话题时设置 `archetype: "private_message"` 和 `target_recipients` 实现

### 3.9 认证相关错误处理

**未登录错误**:
```json
{
  "errors": ["not_logged_in"],
  "error_type": "not_logged_in"
}
```

**权限不足错误**:
```json
{
  "errors": ["You don't have permission to do that."],
  "error_type": "invalid_access"
}
```

**频率限制错误**:
```json
{
  "errors": ["Too many requests. Please try again later."],
  "error_type": "rate_limit"
}
```

---

## 四、数据模型详解

### 4.1 站点配置 (site.json)

**端点**: `GET https://forum.trae.cn/site.json`

```json
{
  "default_archetype": "regular",
  "notification_types": {
    "mentioned": 1,
    "replied": 2,
    "quoted": 3,
    "edited": 4,
    "liked": 5,
    "private_message": 6,
    "bookmark_reminder": 24,
    "reaction": 25,
    "following": 800,
    "following_replied": 802
  },
  "trust_levels": {
    "newuser": 0,
    "basic": 1,
    "member": 2,
    "regular": 3,
    "leader": 4
  },
  "filters": ["latest", "unread", "new", "unseen", "top", "read", "posted", "bookmarks", "hot", "votes"],
  "periods": ["all", "yearly", "quarterly", "monthly", "weekly", "daily"],
  "post_action_types": [
    {"id": 2, "name": "点赞", "name_key": "like"},
    {"id": 3, "name": "偏离话题", "name_key": "off_topic"},
    {"id": 4, "name": "不当言论", "name_key": "inappropriate"},
    {"id": 6, "name": "向 @%{username} 发送消息", "name_key": "notify_user"},
    {"id": 8, "name": "垃圾信息", "name_key": "spam"}
  ],
  "top_tags": [
    {"id": 47, "name": "Code-with-SOLO", "slug": "47-tag"},
    {"id": 46, "name": "新SOLO初体验", "slug": "46-tag"},
    {"id": 11, "name": "基础技巧", "slug": "11-tag"}
  ],
  "user_themes": [{"theme_id": -1, "name": "Foundation", "default": true}],
  "default_light_color_scheme": {
    "id": 21,
    "name": "新调色板",
    "colors": [
      {"name": "primary", "hex": "1A1B1D"},
      {"name": "secondary", "hex": "F3F4F5"},
      {"name": "tertiary", "hex": "0AB861"},
      {"name": "header_background", "hex": "1A1B1D"},
      {"name": "highlight", "hex": "F39D35"},
      {"name": "danger", "hex": "E8463A"}
    ]
  }
}
```

### 4.2 主题详情 (t/{id}.json)

**端点**: `GET https://forum.trae.cn/t/{topic_id}.json`

```json
{
  "post_stream": {
    "posts": [{
      "id": 59465,
      "username": "用户42279",
      "avatar_template": "/user_avatar/forum.trae.cn/用户42279/{size}/174_2.png",
      "created_at": "2026-04-24T06:56:20.096Z",
      "cooked": "<p>HTML格式的帖子内容</p>",
      "post_number": 1,
      "post_type": 1,
      "posts_count": 5,
      "reply_count": 0,
      "reply_to_post_number": null,
      "quote_count": 0,
      "incoming_link_count": 3,
      "reads": 9,
      "readers_count": 8,
      "score": 31.8,
      "yours": false,
      "topic_id": 12116,
      "user_id": 54568,
      "trust_level": 1,
      "admin": false,
      "moderator": false,
      "staff": false,
      "user_title": null,
      "bookmarked": false,
      "actions_summary": [{"id": 2, "count": 1}],
      "reply_to_user": {"id": 43, "username": "TRAE技术支持_小欣"},
      "can_edit": false,
      "can_delete": false,
      "can_recover": false,
      "wiki": false,
      "can_accept_answer": false,
      "accepted_answer": false
    }],
    "stream": [59465, 59466, 59467, 59496, 59498]
  },
  "timeline_lookup": [[1, 0]],
  "suggested_topics": [],
  "id": 12116,
  "title": "主题标题",
  "slug": "topic",
  "posts_count": 5,
  "reply_count": 3,
  "highest_post_number": 5,
  "image_url": "https://...",
  "created_at": "2026-04-24T06:56:20.096Z",
  "last_posted_at": "2026-04-24T07:10:17.076Z",
  "bumped": true,
  "bumped_at": "2026-04-17T09:47:42.972Z",
  "archetype": "regular",
  "visible": true,
  "closed": false,
  "archived": false,
  "tags": [],
  "like_count": 6,
  "views": 54,
  "category_id": 24,
  "op_like_count": 1,
  "has_accepted_answer": false,
  "posters": [{
    "extras": null,
    "description": "原始发帖人",
    "user": {"id": 54568, "username": "用户42279", "trust_level": 1}
  }]
}
```

### 4.3 用户资料 (u/{username}.json)

**端点**: `GET https://forum.trae.cn/u/{username}.json`

```json
{
  "user_badges": [{
    "id": 53,
    "granted_at": "2026-04-10T04:00:48.117Z",
    "badge_id": 3,
    "user_id": 9,
    "count": 1
  }],
  "badges": [{
    "id": 3,
    "name": "活跃用户",
    "description": "授予重新分类、重命名、关注链接、Wiki、更多赞",
    "grant_count": 15,
    "allow_title": true,
    "multiple_grant": false,
    "icon": "user",
    "badge_grouping_id": 4,
    "badge_type_id": 2
  }],
  "badge_types": [
    {"id": 2, "name": "Silver", "sort_order": 8},
    {"id": 1, "name": "Gold", "sort_order": 9}
  ],
  "user": {
    "id": 9,
    "username": "TRAE-小阳",
    "name": "",
    "avatar_template": "/user_avatar/forum.trae.cn/trae-小阳/{size}/5101_2.png",
    "last_posted_at": "2026-04-24T08:17:22.750Z",
    "last_seen_at": "2026-04-24T09:19:19.097Z",
    "created_at": "2026-01-30T07:53:28.645Z",
    "trust_level": 3,
    "moderator": false,
    "admin": true,
    "title": "TRAE官方运营",
    "badge_count": 2,
    "time_read": 239643,
    "recent_time_read": 217639,
    "gamification_score": 3304,
    "accepted_answers": 5,
    "profile_view_count": 2289
  }
}
```

### 3.4 用户活动 (u/{username}/activity.json)

**端点**: `GET https://forum.trae.cn/u/{username}/activity.json`

```json
[{
  "id": 59650,
  "username": "TRAE-小阳",
  "created_at": "2026-04-24T08:17:22.750Z",
  "cooked": "<p>帖子内容</p>",
  "post_number": 276,
  "post_type": 1,
  "posts_count": 277,
  "reply_count": 0,
  "reply_to_post_number": 273,
  "quote_count": 1,
  "reads": 6,
  "score": 1.0,
  "topic_id": 7225,
  "topic_slug": "topic",
  "user_title": "TRAE官方运营",
  "actions_summary": [{"id": 2, "count": 1}],
  "admin": true,
  "staff": true,
  "trust_level": 3,
  "truncated": true,
  "post_url": "/t/topic/7225/276",
  "accepted_answer": false
}]
```

### 3.5 搜索响应 (search.json?q={query})

**端点**: `GET https://forum.trae.cn/search.json?q={query}`

```json
{
  "posts": [{
    "id": 40533,
    "username": "邪修airobot",
    "avatar_template": "/user_avatar/forum.trae.cn/邪修airobot/{size}/4805_2.png",
    "created_at": "2026-04-10T03:58:07.163Z",
    "like_count": 1,
    "blurb": "帖子摘要内容...",
    "post_number": 1,
    "topic_id": 7531
  }]
}
```

### 3.6 分类结构 (categories.json)

**端点**: `GET https://forum.trae.cn/categories.json`

```json
{
  "categories": [{
    "id": 1,
    "name": "未分类",
    "color": "0088CC",
    "text_color": "FFFFFF",
    "style_type": "square",
    "slug": "",
    "topic_count": 0,
    "post_count": 0,
    "position": 0,
    "description_text": "不需要类别或不适合任何其他现有类别的话题。"
  }]
}
```

### 4.7 标签结构 (tags.json)

**端点**: `GET https://forum.trae.cn/tags.json`

```json
{
  "tags": [{
    "id": 47,
    "name": "Code-with-SOLO",
    "slug": "47-tag",
    "count": 125
  }],
  "top_tags": [{
    "id": 47,
    "name": "Code-with-SOLO",
    "slug": "47-tag"
  }]
}
```

---

## 五、业务字段说明

### 5.1 用户角色标识

| 字段 | 类型 | 说明 |
|------|------|------|
| `admin` | boolean | 是否管理员 |
| `moderator` | boolean | 是否版主 |
| `staff` | boolean | 是否工作人员 |
| `trust_level` | integer | 信任等级 (0-4) |

### 5.2 帖子状态标识

| 字段 | 类型 | 说明 |
|------|------|------|
| `post_type` | integer | 1=普通帖, 2=版主操作, 3=小动作, 4=悄悄话 |
| `wiki` | boolean | 是否为Wiki帖 |
| `deleted_at` | string/null | 删除时间 |
| `user_deleted` | boolean | 用户是否已删除 |

### 5.3 互动动作类型 (actions_summary)

| id | name_key | 说明 |
|----|----------|------|
| 2 | like | 点赞 |
| 3 | off_topic | 偏离话题举报 |
| 4 | inappropriate | 不当言论举报 |
| 6 | notify_user | 私信通知 |
| 8 | spam | 垃圾信息举报 |

---

## 五、HTTP 响应头信息

### 5.1 关键响应头

| 响应头 | 值 | 说明 |
|--------|-----|------|
| `x-discourse-route` | users/show, topics/show, posts/user_posts_feed | 路由映射 |
| `x-discourse-cached` | store | 缓存标记 |
| `x-runtime` | 0.047981 | 请求处理时间(秒) |
| `content-encoding` | br | Brotli压缩 |
| `server` | volcalb | 服务器类型 |

### 5.2 安全响应头

```
X-Frame-Options: SAMEORIGIN
X-Content-Type-Options: nosniff
X-Permitted-Cross-Domain-Policies: none
X-Robots-Tag: noindex
```

---

## 六、已验证不可用端点

| 端点 | 状态 | 说明 |
|------|------|------|
| `/users/list.json?order=likes_received&period=monthly` | 404 | 无用户列表接口 |
| `/t/topic/{id}/post_ids.json` | 404 | 无独立post_ids接口 |
| `/reviewable_approved.json` | 404 | 无审核列表接口 |
| `/tag/{slug}/{id}.json` | 404 | 无标签详情接口 |
| `/topics/similar_to.json?title=xxx` | 200(空) | 相似主题接口存在但返回空 |

---

## 七、Avatar 头像 URL 构造规则

```
/user_avatar/forum.trae.cn/{username}/{size}/{upload_id}.png
```
- `{size}`: 可用值 24, 48, 96, 144, 240, 480, 原始尺寸
- 示例: `/user_avatar/forum.trae.cn/trae-小阳/48/5101_2.png`

---

## 九、后续开发建议

### 8.1 可开发功能
1. 论坛内容聚合阅读器
2. 用户数据统计工具
3. 内容搜索与过滤
4. 帖子内容分析与导出
5. 自动签到/互动机器人（需账号）

### 8.2 注意事项
- 认证端点需要有效 Session/Cookie
- 部分接口有请求频率限制
- 图片资源使用独立 CDN 域名
- 建议实现 Brotli 解压支持

---

## 十、附录：完整分类 ID 映射

### 10.1 分类列表

| ID | 分类名称 | 说明 |
|----|----------|------|
| 1 | 未分类 | 不需要类别或不适合任何其他现有类别的话题 |
| 4 | 官方公告 | 用于发布 TRAE 官方通知 |
| 5 | 新手入门 | 新用户入门指南 |
| 6 | 官方活动 | TRAE 官方活动 |
| 7 | 帮助与支持 | 技术支持、产品问题 |
| 8 | 产品建议 | 产品功能建议和反馈 |
| 9 | 技巧分享 | 社区技巧分享 |
| 10 | 案例与作品 | 用户作品展示 |
| 11 | 互动交流 | 自由讨论区 |
| 12 | 入门教程 | 入门教程 |
| 14 | 最佳实践 | 最佳实践 |
| 15 | TRAE Friends | TRAE 社区伙伴 |
| 16 | TRAE on Campus | 校园活动 |
| 17 | 产品更新 | 产品更新公告 |
| 18 | 模型更新 | 模型更新公告 |
| 22 | Bug 反馈 | Bug 反馈 |
| 24 | 福利活动 | 福利活动 |
| 29 | 福利活动 | 福利活动 |
| 33 | 社区伙伴 | 社区伙伴 |
| 35 | SOLO挑战赛专区 | SOLO 挑战赛作品提交区 |

### 10.2 热门标签

| ID | 标签名称 | slug |
|----|----------|------|
| 47 | Code-with-SOLO | 47-tag |
| 46 | 新SOLO初体验 | 46-tag |
| 11 | 基础技巧 | 11-tag |
| 48 | More-than-Coding | 48-tag |
| 2 | solo | 2-tag |
| 20 | 已解决 | 20-tag |
| 7 | Skills | 7-tag |
| 51 | Hello-AI-科技致善 | 51-tag |
| 3 | 模型 | 3-tag |
| 17 | trae技巧便利店 | 17-tag |
| 26 | trae今日打卡 | 26-tag |
| 44 | SOLO独立端 | 44-tag |
| 8 | mcp | 8-tag |
| 6 | rules | 6-tag |
| 10 | 自定义智能体 | 10-tag |
| 32 | 精华神帖 | 32-tag |
| 50 | SOLO赛事速递 | 50-tag |
| 39 | openclaw | 39-tag |
| 16 | 活动回顾 | 16-tag |
| 30 | trae的n种用法 | 30-tag |
| 40 | 新人必看 | 40-tag |
| 42 | featured | 42-tag |
| 33 | 产品 | 33-tag |
| 45 | 游戏 | 45-tag |
| 19 | 游戏开发 | 19-tag |
| 41 | 设计 | 41-tag |
| 12 | 远程开发 | 12-tag |
| 9 | cue | 9-tag |
| 18 | 全栈开发 | 18-tag |
| 25 | 周五用trae早下班 | 25-tag |
| 5 | 提示词工程 | 5-tag |

### 10.3 编辑器规格

| 项目 | 规格 |
|------|------|
| 标题最大长度 | 255 字符 |
| 正文编辑器 | ProseMirror ( contenteditable div) |
| 占位符文本 | "在此处输入。使用工具栏或 Markdown 进行格式化。拖放或粘贴图片。" |
| 支持格式 | Markdown、拖放图片 |

---

**文档版本**: v1.1
**创建时间**: 2026-04-24
**更新记录**:
- v1.0: 初始版本
- v1.1: 添加创建话题 API 详细分析（/new.json、composer_messages）、完整分类/标签映射、CSRF Token 说明
