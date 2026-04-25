# TRAE论坛消息功能API逆向分析文档

## 文档信息
- **分析日期**: 2026-04-24
- **论坛地址**: https://forum.trae.cn
- **分析目标**: 右侧头像点击后的消息功能

---

## 一、功能概述

TRAE论坛的消息功能位于页面右上角头像点击后的下拉菜单中，包含以下主要功能模块：

1. **通知中心** - 显示系统通知、回复、点赞等
2. **私信功能** - 个人消息收发
3. **聊天功能** - 实时聊天频道
4. **书签功能** - 收藏的话题和帖子
5. **个人资料** - 用户信息管理

---

## 二、基础信息

### 2.1 认证方式
- **认证类型**: Cookie + CSRF Token
- **CSRF Token**: 通过 `x-csrf-token` Header 传递
- **Session Cookie**: `_forum_session`, `_t`, `sessionid` 等

### 2.2 请求头规范
```
Content-Type: application/json; charset=utf-8
Accept: application/json, text/javascript, */*; q=0.01
X-Requested-With: XMLHttpRequest
X-CSRF-Token: {csrf_token}
Discourse-Logged-In: true
Discourse-Present: true
```

### 2.3 响应格式
所有API返回JSON格式数据，统一包含以下响应头：
```
Content-Type: application/json; charset=utf-8
X-Discourse-Route: {路由标识}
X-Discourse-Username: {当前用户名}
```

---

## 三、通知相关API

### 3.1 获取所有通知

**请求信息**
- **Method**: GET
- **URL**: `/notifications`
- **描述**: 获取当前用户的所有通知列表

**请求参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| limit | integer | 否 | 返回数量限制，默认30 |
| recent | boolean | 否 | 是否只返回最近通知 |
| bump_last_seen_reviewable | boolean | 否 | 是否更新最后查看时间 |

**响应示例**
```json
{
  "notifications": [],
  "seen_notification_id": 0
}
```

---

### 3.2 按类型筛选通知

**请求信息**
- **Method**: GET
- **URL**: `/notifications`
- **描述**: 根据通知类型筛选获取通知

**请求参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| limit | integer | 否 | 返回数量限制 |
| recent | boolean | 否 | 是否只返回最近通知 |
| bump_last_seen_reviewable | boolean | 否 | 是否更新最后查看时间 |
| filter_by_types | string | 是 | 通知类型，多个类型用逗号分隔 |
| silent | boolean | 否 | 静默模式 |

**通知类型枚举**
| 类型值 | 说明 |
|--------|------|
| mentioned | 被提及(@) |
| group_mentioned | 被群组提及 |
| posted | 有新回复 |
| quoted | 被引用 |
| replied | 被回复 |
| liked | 被点赞 |
| liked_consolidated | 被点赞(合并) |
| reaction | 表情回应 |
| chat_invitation | 聊天邀请 |
| chat_mention | 聊天中被提及 |
| chat_message | 聊天消息 |
| chat_quoted | 聊天中被引用 |
| chat_watched_thread | 关注的聊天线程 |
| edited | 帖子被编辑 |
| invited_to_private_message | 被邀请加入私信 |
| invitee_accepted | 邀请被接受 |
| moved_post | 帖子被移动 |
| linked | 被链接 |
| granted_badge | 获得徽章 |
| invited_to_topic | 被邀请参与话题 |
| custom | 自定义通知 |
| watching_first_post | 关注的首帖 |
| topic_reminder | 话题提醒 |
| post_approved | 帖子被批准 |
| membership_request_accepted | 成员请求被接受 |
| votes_released | 投票释放 |
| event_reminder | 事件提醒 |
| event_invitation | 事件邀请 |
| assigned | 被分配 |
| following | 被关注 |
| following_created_topic | 关注者创建话题 |
| following_replied | 关注者回复 |

**请求示例**
```
GET /notifications?limit=30&recent=true&bump_last_seen_reviewable=true&filter_by_types=mentioned,group_mentioned,posted,quoted,replied&silent=true
```

---

## 四、私信相关API

### 4.1 获取私信菜单数据

**请求信息**
- **Method**: GET
- **URL**: `/u/{username}/user-menu-private-messages`
- **描述**: 获取用户私信菜单的预览数据

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| username | string | 是 | 用户名（URL编码） |

**响应示例**
```json
{
  "unread_notifications": [],
  "read_notifications": [],
  "topics": [],
  "users": []
}
```

---

### 4.2 获取私信话题列表

**请求信息**
- **Method**: GET
- **URL**: `/topics/private-messages/{username}.json`
- **描述**: 获取用户的所有私信话题列表

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| username | string | 是 | 用户名（URL编码） |

**响应示例**
```json
{
  "topic_list": {
    "can_create_topic": true,
    "per_page": 30,
    "top_tags": [...],
    "topics": []
  }
}
```

---

### 4.3 获取私信追踪状态

**请求信息**
- **Method**: GET
- **URL**: `/u/{username}/private-message-topic-tracking-state`
- **描述**: 获取私信话题的追踪状态

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| username | string | 是 | 用户名（URL编码） |

---

## 五、书签相关API

### 5.1 获取书签菜单数据

**请求信息**
- **Method**: GET
- **URL**: `/u/{username}/user-menu-bookmarks`
- **描述**: 获取用户书签菜单的预览数据

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| username | string | 是 | 用户名（URL编码） |

**响应示例**
```json
{
  "notifications": [],
  "bookmarks": []
}
```

---

### 5.2 添加话题书签

**请求信息**
- **Method**: POST
- **URL**: `/bookmarks.json`
- **描述**: 将话题添加到用户书签
- **逆向分析时间**: 2026-04-25

**请求头**
```
Content-Type: application/x-www-form-urlencoded; charset=UTF-8
X-CSRF-Token: {csrf_token}
X-Requested-With: XMLHttpRequest
Discourse-Logged-In: true
Discourse-Present: true
Referer: https://forum.trae.cn/t/topic/{topic_id}
```

**请求体参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| bookmarkable_id | integer | 是 | 被收藏的ID（话题ID） |
| bookmarkable_type | string | 是 | 收藏类型（Topic/Post） |
| auto_delete_preference | integer | 否 | 自动删除偏好（默认为3） |
| reminder_at | string | 否 | 提醒时间（ISO8601格式） |

**请求示例**
```
POST /bookmarks.json
bookmarkable_id=12341&bookmarkable_type=Topic&auto_delete_preference=3
```

**成功响应**
```json
{
  "success": "OK",
  "id": 2090
}
```

**响应头信息**
- `X-Discourse-Route: bookmarks/create`
- `X-Discourse-Username: 用户名`

---

### 5.3 删除书签

**请求信息**
- **Method**: DELETE
- **URL**: `/bookmarks/{id}.json`
- **描述**: 删除用户书签
- **逆向分析时间**: 2026-04-25

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| id | integer | 是 | 书签ID |

**请求头**
```
X-CSRF-Token: {csrf_token}
X-Requested-With: XMLHttpRequest
Discourse-Logged-In: true
Discourse-Present: true
```

**成功响应**
```json
{
  "success": "OK"
}
```

---

### 5.4 获取用户书签列表

**请求信息**
- **Method**: GET
- **URL**: `/user_activity_bookmarks.json`
- **描述**: 获取当前用户的书签列表
- **逆向分析时间**: 2026-04-25

**请求参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| page | integer | 否 | 页码，从0开始 |

**响应示例**
```json
{
  "bookmarks": [],
  "load_more_url": "/user_activity_bookmarks.json?page=1"
}
```

---

## 六、点赞相关API

### 6.1 点赞帖子

**请求信息**
- **Method**: POST
- **URL**: `/post_actions`
- **描述**: 对帖子进行点赞操作
- **逆向分析时间**: 2026-04-25

**请求头**
```
Content-Type: application/x-www-form-urlencoded; charset=UTF-8
X-CSRF-Token: {csrf_token}
X-Requested-With: XMLHttpRequest
Discourse-Logged-In: true
Discourse-Present: true
Referer: https://forum.trae.cn/t/topic/{topic_id}/{post_number}
```

**请求体参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| id | integer | 是 | 帖子ID（post_id） |
| post_action_type_id | integer | 是 | 操作类型ID（2=点赞） |
| flag_topic | boolean | 否 | 是否举报话题（默认false） |

**请求示例**
```
POST /post_actions
id=60309&post_action_type_id=2&flag_topic=false
```

**成功响应**
```json
{
  "id": 60309,
  "name": "",
  "username": "用户名",
  "actions_summary": [
    {"id": 2, "count": 1, "acted": true, "can_undo": true},
    {"id": 6, "can_act": true},
    {"id": 3, "can_act": true},
    {"id": 4, "can_act": true},
    {"id": 8, "can_act": true},
    {"id": 10, "can_act": true},
    {"id": 7, "can_act": true}
  ],
  ...
}
```

**actions_summary 说明**
| id | 类型 | 说明 |
|----|------|------|
| 2 | like | 点赞 |
| 3 | bookmark | 书签 |
| 4 | like | ... |
| 6 | ... | ... |

**响应头信息**
- `X-Discourse-Route: post_actions/create`
- `Discourse-Actions-Max: 2000`
- `Discourse-Actions-Remaining: 1999`

---

### 6.2 取消点赞帖子

**请求信息**
- **Method**: DELETE
- **URL**: `/post_actions/{post_id}`
- **描述**: 取消对帖子的点赞
- **逆向分析时间**: 2026-04-25

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| post_id | integer | 是 | 帖子ID |

**查询参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| post_action_type_id | integer | 是 | 操作类型ID（2=点赞） |

**请求示例**
```
DELETE /post_actions/60309?post_action_type_id=2
```

---

## 七、回复相关API

### 7.1 创建回复

**请求信息**
- **Method**: POST
- **URL**: `/posts`
- **描述**: 在话题下创建回复
- **逆向分析时间**: 2026-04-25

**请求头**
```
Content-Type: application/x-www-form-urlencoded; charset=UTF-8
X-CSRF-Token: {csrf_token}
X-Requested-With: XMLHttpRequest
Discourse-Logged-In: true
Discourse-Present: true
```

**请求体参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| topic_id | integer | 是 | 话题ID |
| raw | string | 是 | 回复内容（Markdown格式） |
| reply_to_post_number | integer | 否 | 回复的目标帖子编号（楼中楼回复） |

**请求示例**
```
POST /posts
topic_id=12341&raw=这是我的回复内容&reply_to_post_number=2
```

**成功响应**
```json
{
  "id": 60310,
  "topic_id": 12341,
  "post_number": 3,
  "created_at": "2026-04-25T03:00:00.000Z",
  ...
}
```

---

### 7.2 编辑回复

**请求信息**
- **Method**: PUT
- **URL**: `/posts/{post_id}`
- **描述**: 编辑已发布的回复
- **逆向分析时间**: 2026-04-25

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| post_id | integer | 是 | 帖子ID |

**请求体参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| raw | string | 是 | 新的回复内容（Markdown格式） |
| edit_reason | string | 否 | 编辑原因 |

---

### 7.3 删除回复

**请求信息**
- **Method**: DELETE
- **URL**: `/posts/{post_id}`
- **描述**: 删除已发布的回复
- **逆向分析时间**: 2026-04-25

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| post_id | integer | 是 | 帖子ID |

**查询参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| force_destroy | boolean | 否 | 是否强制删除（管理员使用） |

---

## 八、聊天相关API

### 6.1 获取当前用户聊天频道

**请求信息**
- **Method**: GET
- **URL**: `/chat/api/me/channels`
- **描述**: 获取当前用户的所有聊天频道

**响应示例**
```json
{
  "public_channels": [],
  "direct_message_channels": [],
  "tracking": {
    "channel_tracking": {},
    "thread_tracking": {}
  },
  "meta": {
    "message_bus_last_ids": {
      "channel_metadata": 9734,
      "channel_edits": 4,
      "channel_status": 0,
      "new_channel": 7875,
      "archive_status": 0,
      "user_tracking_state": 0,
      "user_has_threads": 0
    }
  },
  "unread_thread_overview": {},
  "has_threads": false,
  "global_presence_channel_state": {
    "count": 0,
    "last_message_id": 19961,
    "users": []
  }
}
```

---

### 6.2 获取公开聊天频道列表

**请求信息**
- **Method**: GET
- **URL**: `/chat/api/channels`
- **描述**: 获取公开的聊天频道列表

**请求参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| limit | integer | 否 | 返回数量限制 |
| filter | string | 否 | 筛选条件 |
| status | string | 否 | 频道状态(open/closed/archived) |
| offset | integer | 否 | 分页偏移量 |

**响应示例**
```json
{
  "channels": [],
  "meta": {
    "load_more_url": "/chat/api/channels?chatable_id=&chatable_type=&filter=&limit=10&offset=10&status=open"
  }
}
```

---

### 6.3 更新在线状态

**请求信息**
- **Method**: POST
- **URL**: `/presence/update`
- **描述**: 更新用户的在线状态

---

## 七、用户相关API

### 7.1 获取用户信息

**请求信息**
- **Method**: GET
- **URL**: `/u/{username}.json`
- **描述**: 获取用户详细信息

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| username | string | 是 | 用户名（URL编码） |

**响应字段说明**
| 字段名 | 类型 | 说明 |
|--------|------|------|
| id | integer | 用户ID |
| username | string | 用户名 |
| name | string | 显示名称 |
| avatar_template | string | 头像模板URL |
| email | string | 邮箱地址 |
| trust_level | integer | 信任等级 |
| moderator | boolean | 是否版主 |
| admin | boolean | 是否管理员 |
| created_at | string | 创建时间 |
| last_seen_at | string | 最后在线时间 |
| can_send_private_messages | boolean | 是否可以发送私信 |
| can_edit | boolean | 是否可以编辑资料 |
| user_option | object | 用户设置选项 |
| sidebar_tags | array | 侧边栏标签 |
| sidebar_category_ids | array | 侧边栏分类ID |

---

## 八、Message Bus API（实时通信）

### 8.1 消息轮询

**请求信息**
- **Method**: POST
- **URL**: `/message-bus/{client_id}/poll`
- **描述**: 长轮询获取实时消息通知

**路径参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| client_id | string | 是 | 客户端唯一标识 |

**说明**: 这是Discourse框架的实时消息推送机制，用于接收新通知、私信、聊天消息等实时更新。

---

## 九、API调用示例

### 9.1 获取回复通知
```bash
curl 'https://forum.trae.cn/notifications?limit=30&recent=true&bump_last_seen_reviewable=true&filter_by_types=mentioned,group_mentioned,posted,quoted,replied&silent=true' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'X-CSRF-Token: {your_csrf_token}' \
  -H 'Discourse-Logged-In: true' \
  -b '_forum_session={session_cookie}; _t={t_cookie}'
```

### 9.2 获取点赞通知
```bash
curl 'https://forum.trae.cn/notifications?limit=30&recent=true&bump_last_seen_reviewable=true&filter_by_types=liked,liked_consolidated,reaction&silent=true' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'X-CSRF-Token: {your_csrf_token}' \
  -H 'Discourse-Logged-In: true' \
  -b '_forum_session={session_cookie}; _t={t_cookie}'
```

### 9.3 获取私信列表
```bash
curl 'https://forum.trae.cn/topics/private-messages/{username}.json' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'X-CSRF-Token: {your_csrf_token}' \
  -H 'Discourse-Logged-In: true' \
  -b '_forum_session={session_cookie}; _t={t_cookie}'
```

### 9.4 获取聊天频道
```bash
curl 'https://forum.trae.cn/chat/api/me/channels' \
  -H 'Accept: application/json, text/javascript, */*; q=0.01' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'X-CSRF-Token: {your_csrf_token}' \
  -H 'Discourse-Logged-In: true' \
  -b '_forum_session={session_cookie}; _t={t_cookie}'
```

---

## 十、技术架构分析

### 10.1 框架识别
TRAE论坛基于 **Discourse** 开源论坛框架构建，具有以下特征：
- 使用Ruby on Rails后端
- 使用Ember.js前端框架
- 使用Message Bus进行实时通信
- 使用PostgreSQL数据库

### 10.2 消息推送机制
1. **轮询机制**: 通过 `/message-bus/{client_id}/poll` 进行长轮询
2. **通知分类**: 支持30+种通知类型，可按类型筛选
3. **状态追踪**: 自动追踪已读/未读状态

### 10.3 安全机制
1. **CSRF防护**: 所有POST请求需要携带CSRF Token
2. **Session管理**: 使用加密Cookie进行会话管理
3. **XSS防护**: 响应头包含 `X-XSS-Protection: 0`（由框架自行处理）

---

## 十一、注意事项

1. **Cookie有效期**: Session Cookie有过期时间，需要定期更新
2. **CSRF Token**: 每次页面加载都会生成新的CSRF Token
3. **请求频率**: 避免过于频繁的API调用，防止触发限流
4. **编码问题**: 用户名等参数需要进行URL编码（如中文用户名）
5. **权限检查**: 某些API需要特定的用户权限才能访问

---

## 十二、更新记录

| 日期 | 版本 | 更新内容 |
|------|------|----------|
| 2026-04-24 | 1.0 | 初始版本，完成基础API逆向分析 |
| 2026-04-25 | 1.1 | 新增书签/收藏API、点赞API、回复API的详细逆向分析 |

---

*本文档仅供技术学习和研究使用，请遵守相关法律法规和网站服务条款。*
