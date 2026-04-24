# TRAE 官方中文社区网页结构详细分析

## 一、分析概述

### 1.1 分析对象
- **目标站点**: https://forum.trae.cn/
- **框架**: Discourse (开源论坛系统)
- **分析时间**: 2026-04-24
- **分析目的**: 全面了解论坛页面结构，为 Flutter 原生化开发提供参考

### 1.2 技术特征

| 特征 | 详情 |
|------|------|
| 服务器 | volcalb |
| 内容编码 | Brotli (br) |
| 安全头 | X-Frame-Options: SAMEORIGIN |
| Discourse路由 | x-discourse-route 响应头标识路由 |
| 缓存标识 | x-discourse-cached: store |

---

## 二、页面结构总览

### 2.1 主要页面类型

```
┌─────────────────────────────────────────────────────────────┐
│                      页面架构                                │
├─────────────────────────────────────────────────────────────┤
│  首页 (/latest.json)           话题列表，按最新活动时间排序   │
│  分类页 (/c/{id}.json)         按分类筛选的话题列表           │
│  标签页 (/tags.json)           标签筛选和浏览                │
│  话题详情 (/t/{id}.json)       话题正文 + 回复流             │
│  用户主页 (/u/{username}.json)  用户资料和活动历史           │
│  搜索页 (/search.json)         内容搜索                     │
│  站点信息 (/site.json)         全局配置和元数据              │
└─────────────────────────────────────────────────────────────┘
```

---

## 三、首页结构 (latest.json)

### 3.1 首页数据结构

```json
{
  "topic_list": {
    "can_create_topic": true,
    "draft": null,
    "draft_key": "new_topic",
    "draft_sequence": 5,
    "for_period": "all",
    "topics": [
      {
        "id": 9360,
        "title": "👉 【新增公益赛道】SOLO 挑战赛「Hello AI 科技致善」...",
        "fancy_title": "👉 【新增公益赛道】SOLO 挑战赛「Hello AI 科技致善」...",
        "slug": "topic",
        "posts_count": 99,
        "reply_count": 85,
        "highest_post_number": 99,
        "image_url": "https://...",
        "created_at": "2026-04-08T09:00:00.000Z",
        "last_posted_at": "2026-04-24T08:17:22.750Z",
        "bumped": true,
        "bumped_at": "2026-04-24T08:17:22.750Z",
        "archetype": "regular",
        "unseen": false,
        "pinned": false,
        "unpinned": null,
        "excerpt": "欢迎来到「AI 无限职场」SOLO 挑战赛！这里是全新公益赛道...",
        "visible": true,
        "closed": false,
        "archived": false,
        "bookmarked": null,
        "liked": null,
        "thumbnails": [...],
        "tags": ["Hello-AI-科技致善", "SOLO赛事速递", "featured"],
        "tags_descriptions": {},
        "like_count": 106,
        "views": 3950,
        "category_id": 35,
        "featured_link": null,
        "op_like_count": 18,
        "has_accepted_answer": false,
        "posters": [
          {
            "extras": null,
            "description": "原始发帖人",
            "user": {"id": 9, "username": "TRAE-小阳", "avatar_template": "..."}
          },
          {
            "extras": "latest",
            "description": "最近回复",
            "user": {"id": 54568, "username": "用户42279", "avatar_template": "..."}
          }
        ]
      }
    ]
  },
  "users": [
    {"id": 9, "username": "TRAE-小阳", "admin": true, "moderator": false, "trust_level": 3}
  ],
  "primaryGroups": [],
  "topic_list": {...},
  "tags": [],
  "categories": [...]
}
```

### 3.2 首页 Feed 卡片展示结构

```
┌─────────────────────────────────────────────────────────────┐
│  [头像] TRAE-小阳                          官方运营  [时间]   │
│          [分类]: SOLO挑战赛专区                           │
│                                                             │
│  👉 【新增公益赛道】SOLO 挑战赛「Hello AI 科技致善」...     │
│                                                             │
│  欢迎来到「AI 无限职场」SOLO 挑战赛！这里是全新公益赛道...   │
│                                                             │
│  [Hello-AI-科技致善] [SOLO赛事速递] [featured]              │
│                                                             │
│  👍106  💬85  👁️3950                      [已收藏]        │
└─────────────────────────────────────────────────────────────┘
```

### 3.3 卡片字段映射

| 字段 | Discourse API | 说明 |
|------|---------------|------|
| 作者头像 | posters[0].user.avatar_template | 需替换{size}并拼接域名 |
| 作者名称 | posters[0].user.username | 显示用户名 |
| 官方标识 | posters[0].user.admin/moderator | 管理员/版主红色标识 |
| 发布/回复时间 | created_at / last_posted_at | 相对时间展示 |
| 分类 | category_id | 关联categories获取名称 |
| 标题 | title | 话题标题 |
| 摘要 | excerpt | 话题首楼文本摘要 |
| 标签 | tags[] | 标签名称列表 |
| 点赞数 | like_count | 话题总点赞 |
| 回复数 | reply_count | 回复数量 |
| 浏览数 | views | 阅读量 |
| 封面图 | image_url / thumbnails[0] | 可选展示 |

---

## 四、话题详情页结构 (t/{id}.json)

### 4.1 话题详情完整数据结构

```json
{
  "post_stream": {
    "posts": [
      {
        "id": 48298,
        "name": "",
        "username": "TRAE-小阳",
        "avatar_template": "/user_avatar/forum.trae.cn/trae-小阳/{size}/5101_2.png",
        "created_at": "2026-04-08T09:00:00.000Z",
        "cooked": "<p>欢迎来到「AI 无限职场」SOLO 挑战赛...</p><p><img src=\"...\">...</p>",
        "post_number": 1,
        "post_type": 1,
        "posts_count": 99,
        "updated_at": "2026-04-08T09:00:00.000Z",
        "reply_count": 0,
        "reply_to_post_number": null,
        "quote_count": 0,
        "incoming_link_count": 0,
        "reads": 3950,
        "score": 2564.5,
        "yours": false,
        "topic_id": 9360,
        "topic_slug": "topic",
        "display_username": "",
        "primary_group_name": null,
        "flair_name": null,
        "flair_url": null,
        "flair_bg_color": null,
        "flair_color": null,
        "flair_group_id": null,
        "badges_granted": [],
        "version": 1,
        "can_edit": false,
        "can_delete": false,
        "can_recover": false,
        "can_see_hidden_post": false,
        "can_wiki": false,
        "read": true,
        "user_title": "TRAE官方运营",
        "title_is_group": false,
        "bookmarked": false,
        "actions_summary": [
          {"id": 2, "count": 18}
        ],
        "moderator": false,
        "admin": true,
        "staff": true,
        "user_id": 9,
        "hidden": false,
        "trust_level": 3,
        "deleted_at": null,
        "user_deleted": false,
        "edit_reason": null,
        "can_view_edit_history": true,
        "wiki": false,
        "post_url": "/t/topic/9360/1",
        "can_accept_answer": false,
        "can_unaccept_answer": false,
        "accepted_answer": false,
        "topic_accepted_answer": null,
        "can_vote": false,
        "voted": false,
        "anonymous": false
      }
    ],
    "stream": [48298, 48972, 48973, ...]
  },
  "timeline_lookup": [[1, 0]],
  "suggested_topics": [
    {
      "id": 7225,
      "title": "SOLO挑战赛常见问题FAQ",
      "slug": "topic",
      "posts_count": 50,
      "reply_count": 35,
      "image_url": null,
      "created_at": "2026-04-01T00:00:00.000Z",
      "last_posted_at": "2026-04-20T00:00:00.000Z",
      "bumped": true,
      "bumped_at": "2026-04-20T00:00:00.000Z",
      "archetype": "regular",
      "unseen": false,
      "pinned": false,
      "excerpt": "",
      "visible": true,
      "closed": false,
      "archived": false,
      "bookmarked": null,
      "liked": null,
      "thumbnails": [],
      "tags": ["SOLO赛事速递"],
      "like_count": 89,
      "views": 2340,
      "category_id": 35,
      "featured_link": null,
      "op_like_count": 20,
      "has_accepted_answer": true,
      "posters": [...]
    }
  ],
  "id": 9360,
  "title": "👉 【新增公益赛道】SOLO 挑战赛「Hello AI 科技致善」...",
  "fancy_title": "👉 【新增公益赛道】SOLO 挑战赛「Hello AI 科技致善」...",
  "slug": "topic",
  "posts_count": 99,
  "reply_count": 85,
  "highest_post_number": 99,
  "image_url": "https://...",
  "created_at": "2026-04-08T09:00:00.000Z",
  "last_posted_at": "2026-04-24T08:17:22.750Z",
  "bumped": true,
  "bumped_at": "2026-04-24T08:17:22.750Z",
  "archetype": "regular",
  "unseen": false,
  "pinned": false,
  "unpinned": null,
  "excerpt": "欢迎来到「AI 无限职场」SOLO 挑战赛！...",
  "visible": true,
  "closed": false,
  "archived": false,
  "bookmarked": null,
  "liked": null,
  "thumbnails": [...],
  "tags": ["Hello-AI-科技致善", "SOLO赛事速递", "featured"],
  "tags_descriptions": {},
  "like_count": 106,
  "views": 3950,
  "category_id": 35,
  "featured_link": null,
  "op_like_count": 18,
  "has_accepted_answer": false,
  "posters": [
    {
      "extras": null,
      "description": "Original Poster",
      "user": {"id": 9, "username": "TRAE-小阳", "name": "", "avatar_template": "..."}
    }
  ],
  "primary_groups": [],
  "is_owner": false,
  "can_edit": false,
  "last_poster": {"id": 54568, "username": "用户42279", "avatar_template": "..."}
}
```

### 4.2 回复帖子数据结构

```json
{
  "id": 59466,
  "name": "",
  "username": "TRAE-小阳",
  "avatar_template": "/user_avatar/forum.trae.cn/trae-小阳/{size}/5101_2.png",
  "created_at": "2026-04-24T06:56:32.961Z",
  "cooked": "<p>稍等，我看一下</p>",
  "post_number": 2,
  "post_type": 1,
  "posts_count": 5,
  "updated_at": "2026-04-24T06:56:32.961Z",
  "reply_count": 0,
  "reply_to_post_number": null,
  "quote_count": 0,
  "incoming_link_count": 0,
  "reads": 9,
  "readers_count": 8,
  "score": 16.8,
  "yours": false,
  "topic_id": 12116,
  "topic_slug": "topic",
  "display_username": "",
  "primary_group_name": null,
  "flair_name": null,
  "flair_url": null,
  "flair_bg_color": null,
  "flair_color": null,
  "flair_group_id": null,
  "badges_granted": [],
  "version": 1,
  "can_edit": false,
  "can_delete": false,
  "can_recover": false,
  "can_see_hidden_post": false,
  "can_wiki": false,
  "read": true,
  "user_title": "TRAE官方运营",
  "title_is_group": false,
  "bookmarked": false,
  "actions_summary": [
    {"id": 2, "count": 1}
  ],
  "moderator": false,
  "admin": true,
  "staff": true,
  "user_id": 9,
  "hidden": false,
  "trust_level": 3,
  "deleted_at": null,
  "user_deleted": false,
  "edit_reason": null,
  "can_view_edit_history": true,
  "wiki": false,
  "post_url": "/t/topic/12116/2",
  "can_accept_answer": false,
  "can_unaccept_answer": false,
  "accepted_answer": false,
  "topic_accepted_answer": null,
  "can_vote": false,
  "reply_to_user": {
    "id": 8586,
    "username": "TRAE宝",
    "name": "",
    "avatar_template": "/user_avatar/forum.trae.cn/trae宝/{size}/10316_2.png"
  }
}
```

### 4.3 话题详情页布局结构

```
┌─────────────────────────────────────────────────────────────┐
│  ← 返回                    话题详情              [分享]    │
├─────────────────────────────────────────────────────────────┤
│  [分类: SOLO挑战赛专区]                                     │
│                                                             │
│  👉 【新增公益赛道】SOLO 挑战赛「Hello AI 科技致善」...     │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │ [头像] TRAE-小阳  官方运营     2026-04-08 09:00    │    │
│  ├─────────────────────────────────────────────────────┤    │
│  │                                                     │    │
│  │  <p>欢迎来到「AI 无限职场」SOLO 挑战赛！</p>        │    │
│  │  <p><img src="cover.jpg"></p>                       │    │
│  │  <blockquote>引用内容...</blockquote>               │    │
│  │  <pre><code>代码块...</code></pre>                  │    │
│  │                                                     │    │
│  ├─────────────────────────────────────────────────────┤    │
│  │ 👍18    🔖收藏    📤分享                            │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                             │
│  ─────────────── 回复 (98) ───────────────                  │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │ #2  用户42279                        2分钟前        │    │
│  │ [头像]                                            │    │
│  │ 稍等，我看一下                                     │    │
│  │ 👍1    回复                                       │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │ #3  TRAE-小阳                      官方运营  1分钟前│    │
│  │ [头像]                                            │    │
│  │ <p>引用用户42279的回复...</p>                     │    │
│  │ 我理解你的心情～                                  │    │
│  │ 👍2    回复                                      │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                             │
│  ─────────────── 推荐阅读 ───────────────                    │
│  • SOLO挑战赛常见问题FAQ                                    │
│  • 如何使用TRAE SOLO提高开发效率                             │
│                                                             │
├─────────────────────────────────────────────────────────────┤
│  [评论输入框: 输入回复... ]                    [发送]       │
└─────────────────────────────────────────────────────────────┘
```

---

## 五、用户主页结构 (u/{username}.json)

### 5.1 用户主页完整数据结构

```json
{
  "user_badges": [
    {
      "id": 53,
      "granted_at": "2026-04-10T04:00:48.117Z",
      "created_at": "2026-04-10T04:00:48.117Z",
      "count": 1,
      "badge_id": 3,
      "user_id": 9,
      "granted_by_id": -1
    }
  ],
  "badges": [
    {
      "id": 3,
      "name": "活跃用户",
      "description": "<a href=\"...\">授予</a>重新分类、重命名、关注链接、Wiki、更多赞",
      "grant_count": 15,
      "allow_title": true,
      "multiple_grant": false,
      "icon": "user",
      "image_url": null,
      "listable": true,
      "enabled": true,
      "badge_grouping_id": 4,
      "system": true,
      "slug": "-",
      "manually_grantable": false,
      "show_in_post_header": false,
      "badge_type_id": 2
    },
    {
      "id": 20,
      "name": "精彩的话题",
      "description": "话题获得 50 个赞",
      "grant_count": 3,
      "allow_title": false,
      "multiple_grant": true,
      "icon": "file-signature",
      "badge_grouping_id": 3,
      "badge_type_id": 1
    }
  ],
  "badge_types": [
    {"id": 2, "name": "Silver", "sort_order": 8},
    {"id": 1, "name": "Gold", "sort_order": 9}
  ],
  "users": [
    {"id": 9, "username": "TRAE-小阳", "avatar_template": "...", "admin": true, "trust_level": 3},
    {"id": -1, "username": "system", "admin": true, "moderator": true, "trust_level": 4}
  ],
  "user": {
    "id": 9,
    "username": "TRAE-小阳",
    "name": "",
    "avatar_template": "/user_avatar/forum.trae.cn/trae-小阳/{size}/5101_2.png",
    "last_posted_at": "2026-04-24T08:17:22.750Z",
    "last_seen_at": "2026-04-24T09:19:19.097Z",
    "created_at": "2026-01-30T07:53:28.645Z",
    "ignored": false,
    "muted": false,
    "can_ignore_user": false,
    "can_mute_user": false,
    "can_send_private_messages": false,
    "can_send_private_message_to_user": false,
    "trust_level": 3,
    "moderator": false,
    "admin": true,
    "title": "TRAE官方运营",
    "badge_count": 2,
    "custom_fields": {},
    "time_read": 239643,
    "recent_time_read": 217639,
    "primary_group_id": null,
    "primary_group_name": null,
    "flair_group_id": null,
    "flair_name": null,
    "flair_url": null,
    "flair_bg_color": null,
    "flair_color": null,
    "featured_topic": null,
    "can_edit": false,
    "can_edit_username": false,
    "can_edit_email": false,
    "can_edit_name": false,
    "uploaded_avatar_id": 5101,
    "pending_count": 0,
    "profile_view_count": 2289,
    "can_upload_profile_header": false,
    "can_upload_user_card_background": false,
    "no_password": true,
    "custom_avatar_upload_id": 5101,
    "custom_avatar_template": "/user_avatar/forum.trae.cn/trae-小阳/{size}/5101_2.png",
    "can_chat_user": false,
    "gamification_score": 3304,
    "accepted_answers": 5,
    "featured_user_badge_ids": [53, 25],
    "invited_by": null,
    "groups": []
  }
}
```

### 5.2 用户主页布局结构

```
┌─────────────────────────────────────────────────────────────┐
│  ← 返回                      TRAE-小阳                       │
├─────────────────────────────────────────────────────────────┤
│                                                             │
│              ┌─────────────┐                                 │
│              │   [头像]    │          TRAE-小阳             │
│              │   96x96     │          TRAE官方运营           │
│              └─────────────┘                                 │
│                                                             │
│  ┌──────────┬──────────┬──────────┬──────────┐              │
│  │   2289   │  239643  │   3304   │    5     │              │
│  │  个人主页 │  阅读时间  │  游戏分数 │ 被采纳答案 │              │
│  │  访问量  │  (分钟)   │          │          │              │
│  └──────────┴──────────┴──────────┴──────────┘              │
│                                                             │
│  ─────────────── 成就徽章 ───────────────                    │
│  ┌─────────┐ ┌─────────┐                                     │
│  │  🥈活跃用户 │ │ 🏅精彩话题 │                                 │
│  │  15次获得  │ │ 3次获得   │                                 │
│  └─────────┘ └─────────┘                                     │
│                                                             │
│  ─────────────── 最新活动 ───────────────                    │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │ 2分钟前 在话题 #7225 中回复                          │    │
│  │ 会在2天内开通资格，直接登录solo就有权益了             │    │
│  │ 👍1  💬1                                             │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                             │
│  ┌─────────────────────────────────────────────────────┐    │
│  │ 30分钟前 在话题 #11916 中回复                        │    │
│  │ 可以去参加SOLO挑战赛了                                │    │
│  │ 👍0                                                 │    │
│  └─────────────────────────────────────────────────────┘    │
│                                                             │
└─────────────────────────────────────────────────────────────┘
```

### 5.3 用户统计字段说明

| 字段 | 说明 | 示例值 |
|------|------|--------|
| profile_view_count | 个人主页访问量 | 2289 |
| time_read | 累计阅读时间(分钟) | 239643 |
| recent_time_read | 最近阅读时间(分钟) | 217639 |
| gamification_score | 游戏化积分 | 3304 |
| accepted_answers | 被采纳答案数 | 5 |
| trust_level | 信任等级 (0-4) | 3 |
| badge_count | 徽章总数 | 2 |

### 5.4 信任等级对照

| 等级 | 名称 | 权限 |
|------|------|------|
| 0 | newuser | 新用户，基础操作受限 |
| 1 | basic | 基础用户，可发帖 |
| 2 | member | 正式成员，可投票 |
| 3 | regular | 活跃用户，可标记最佳答案 |
| 4 | leader | 社区领袖，可编辑分类 |

---

## 六、用户活动页结构 (u/{username}/activity.json)

### 6.1 用户活动数据结构

```json
[
  {
    "id": 59650,
    "name": "",
    "username": "TRAE-小阳",
    "avatar_template": "/user_avatar/forum.trae.cn/trae-小阳/{size}/5101_2.png",
    "created_at": "2026-04-24T08:17:22.750Z",
    "cooked": "<p>会在2天内开通资格，直接登录solo就有权益了</p>\n<aside class=\"quote no-group\" data-username=\"用户40995\" data-post=\"273\" data-topic=\"7225\">\n<blockquote><p>已经报名，且提交作品，没有收到邀请码</p></blockquote>\n</aside>",
    "post_number": 276,
    "post_type": 1,
    "posts_count": 277,
    "updated_at": "2026-04-24T08:17:22.750Z",
    "reply_count": 0,
    "reply_to_post_number": 273,
    "quote_count": 1,
    "incoming_link_count": 0,
    "reads": 6,
    "readers_count": 5,
    "score": 1.0,
    "yours": false,
    "topic_id": 7225,
    "topic_slug": "topic",
    "display_username": "",
    "primary_group_name": null,
    "flair_name": null,
    "flair_url": null,
    "flair_bg_color": null,
    "flair_color": null,
    "flair_group_id": null,
    "badges_granted": [],
    "version": 1,
    "can_edit": false,
    "can_delete": false,
    "can_recover": false,
    "can_see_hidden_post": false,
    "can_wiki": false,
    "user_title": "TRAE官方运营",
    "title_is_group": false,
    "bookmarked": false,
    "actions_summary": [{"id": 2, "count": 1}],
    "moderator": false,
    "admin": true,
    "staff": true,
    "user_id": 9,
    "hidden": false,
    "trust_level": 3,
    "deleted_at": null,
    "user_deleted": false,
    "edit_reason": null,
    "can_view_edit_history": true,
    "wiki": false,
    "excerpt": "会在2天内开通资格，直接登录solo就有权益了",
    "truncated": true,
    "post_url": "/t/topic/7225/276",
    "can_accept_answer": false,
    "can_unaccept_answer": false,
    "accepted_answer": false,
    "topic_accepted_answer": null
  }
]
```

---

## 七、分类页结构 (c/{id}.json)

### 7.1 分类页完整数据结构

```json
{
  "topic_list": {
    "can_create_topic": true,
    "draft": null,
    "draft_key": "new_topic",
    "draft_sequence": 3,
    "for_period": "all",
    "topics": [
      {
        "id": 62,
        "title": "社区新人报到处",
        "fancy_title": "社区新人报到处",
        "slug": "topic",
        "posts_count": 3570,
        "reply_count": 1784,
        "highest_post_number": 3570,
        "image_url": null,
        "created_at": "2026-01-30T08:00:00.000Z",
        "last_posted_at": "2026-04-24T09:00:00.000Z",
        "bumped": true,
        "bumped_at": "2026-04-24T09:00:00.000Z",
        "archetype": "regular",
        "unseen": false,
        "pinned": true,
        "excerpt": "欢迎新朋友！在这里报到领取新人福利...",
        "visible": true,
        "closed": false,
        "archived": false,
        "bookmarked": null,
        "liked": null,
        "thumbnails": [],
        "tags": ["新人必看"],
        "like_count": 567,
        "views": 89000,
        "category_id": 11,
        "featured_link": null,
        "op_like_count": 89,
        "has_accepted_answer": false,
        "posters": [
          {
            "extras": null,
            "description": "Original Poster",
            "user": {"id": 9, "username": "TRAE-小阳"}
          }
        ]
      },
      {
        "id": 20,
        "title": "关于「互动交流」版块",
        "fancy_title": "关于「互动交流」版块",
        "slug": "topic",
        "posts_count": 11,
        "reply_count": 1,
        "highest_post_number": 11,
        "image_url": null,
        "created_at": "2026-01-30T08:00:00.000Z",
        "last_posted_at": "2026-02-01T00:00:00.000Z",
        "bumped": false,
        "excerpt": "互动交流版块使用说明...",
        "visible": true,
        "closed": false,
        "archived": false,
        "tags": [],
        "like_count": 12,
        "views": 1200,
        "category_id": 11
      }
    ],
    "users": [
      {"id": 9, "username": "TRAE-小阳", "admin": true, "moderator": false, "trust_level": 3},
      {"id": 24, "username": "Damond", "admin": false, "moderator": true, "trust_level": 4}
    ]
  },
  "top_tags": [
    {"id": 46, "name": "新SOLO初体验", "slug": "46-tag"},
    {"id": 11, "name": "基础技巧", "slug": "11-tag"}
  ],
  "categories": [
    {"id": 11, "name": "互动交流", "color": "00ACC1", "slug": "11-category"}
  ]
}
```

---

## 八、站点配置结构 (site.json)

### 8.1 站点配置完整数据

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
    "invited_to_private_message": 7,
    "invitee_accepted": 8,
    "posted": 9,
    "moved_post": 10,
    "linked": 11,
    "granted_badge": 12,
    "invited_to_topic": 13,
    "custom": 14,
    "group_mentioned": 15,
    "group_message_summary": 16,
    "watching_first_post": 17,
    "topic_reminder": 18,
    "liked_consolidated": 19,
    "post_approved": 20,
    "code_review_commit_approved": 21,
    "membership_request_accepted": 22,
    "membership_request_consolidated": 23,
    "bookmark_reminder": 24,
    "reaction": 25,
    "votes_released": 26,
    "event_reminder": 27,
    "event_invitation": 28,
    "chat_mention": 29,
    "chat_message": 30,
    "chat_invitation": 31,
    "chat_group_mention": 32,
    "chat_quoted": 33,
    "assigned": 34,
    "question_answer_user_commented": 35,
    "watching_category_or_tag": 36,
    "new_features": 37,
    "admin_problems": 38,
    "linked_consolidated": 39,
    "chat_watched_thread": 40,
    "upcoming_change_available": 41,
    "upcoming_change_automatically_promoted": 42,
    "following": 800,
    "following_created_topic": 801,
    "following_replied": 802,
    "circles_activity": 900
  },
  "post_types": {
    "regular": 1,
    "moderator_action": 2,
    "small_action": 3,
    "whisper": 4
  },
  "trust_levels": {
    "newuser": 0,
    "basic": 1,
    "member": 2,
    "regular": 3,
    "leader": 4
  },
  "groups": [],
  "filters": [
    "latest",
    "unread",
    "new",
    "unseen",
    "top",
    "read",
    "posted",
    "bookmarks",
    "hot",
    "votes"
  ],
  "periods": [
    "all",
    "yearly",
    "quarterly",
    "monthly",
    "weekly",
    "daily"
  ],
  "top_menu_items": [
    "latest",
    "unread",
    "new",
    "unseen",
    "top",
    "read",
    "posted",
    "bookmarks",
    "hot",
    "categories",
    "votes"
  ],
  "anonymous_top_menu_items": [
    "latest",
    "top",
    "categories",
    "hot",
    "categories",
    "top",
    "votes"
  ],
  "uncategorized_category_id": 1,
  "user_field_max_length": 2048,
  "post_action_types": [
    {
      "id": 6,
      "name": "向 @{username} 发送消息",
      "name_key": "notify_user",
      "description": "我想亲自与此人私下交流关于其帖子的事情。",
      "short_description": "我想亲自与此人私下交流关于其帖子的事情。",
      "applies_to": ["Post", "Chat::Message"],
      "position": 1,
      "require_message": true,
      "enabled": true,
      "is_flag": true,
      "is_used": true,
      "auto_action_type": false,
      "system": true
    },
    {
      "id": 3,
      "name": "偏离话题",
      "name_key": "off_topic",
      "description": "此帖子与标题和第一个帖子定义的当前讨论无关，可能应该移到其他地方。",
      "short_description": "与讨论无关",
      "applies_to": ["Post", "Chat::Message"],
      "position": 2,
      "require_message": false,
      "enabled": true,
      "is_flag": true,
      "is_used": true,
      "auto_action_type": true,
      "system": true
    },
    {
      "id": 4,
      "name": "不当言论",
      "name_key": "inappropriate",
      "description": "这个帖子包含的内容会被一个有理性的人认为具有冒犯性、侮辱性、属于仇恨行为或违反<a href=\"/guidelines\">我们的社区准则</a>。",
      "short_description": "违反了<a href=\"/guidelines\">我们的社区准则</a>",
      "applies_to": ["Post", "Topic", "Chat::Message"],
      "position": 3,
      "require_message": false,
      "enabled": true,
      "is_flag": true,
      "is_used": true,
      "auto_action_type": true,
      "system": true
    },
    {
      "id": 8,
      "name": "垃圾信息",
      "name_key": "spam",
      "description": "此帖子是广告或者蓄意破坏讨论。帖子没有价值或者与当前话题无关。",
      "short_description": "这是广告或者蓄意破坏行为",
      "applies_to": ["Post", "Topic", "Chat::Message"],
      "position": 4,
      "require_message": false,
      "enabled": true,
      "is_flag": true,
      "is_used": true,
      "auto_action_type": true,
      "system": true
    },
    {
      "id": 10,
      "name": "非法",
      "name_key": "illegal",
      "description": "此帖子需要工作人员注意，因为我认为其中包含非法内容。",
      "short_description": "这是非法的",
      "applies_to": ["Post", "Topic", "Chat::Message"],
      "position": 5,
      "require_message": true,
      "enabled": true,
      "is_flag": true,
      "is_used": false,
      "auto_action_type": false,
      "system": true
    },
    {
      "id": 7,
      "name": "其他内容",
      "name_key": "notify_moderators",
      "description": "由于上面未列出的另一个原因，此帖子需要管理人员注意。",
      "short_description": "因其他原因需要管理人员注意",
      "applies_to": ["Post", "Topic", "Chat::Message"],
      "position": 6,
      "require_message": true,
      "enabled": true,
      "is_flag": true,
      "is_used": true,
      "auto_action_type": false,
      "system": true
    },
    {
      "id": 2,
      "name": "点赞",
      "name_key": "like",
      "description": "点赞此帖子",
      "short_description": "点赞此帖子",
      "applies_to": ["Post"],
      "position": 8,
      "require_message": false,
      "enabled": true,
      "is_flag": false,
      "is_used": true,
      "auto_action_type": false,
      "system": true
    }
  ],
  "topic_flag_types": [
    {"id": 4, "name": "不当言论", "name_key": "inappropriate"},
    {"id": 8, "name": "垃圾信息", "name_key": "spam"},
    {"id": 10, "name": "非法", "name_key": "illegal"},
    {"id": 7, "name": "其他内容", "name_key": "notify_moderators"}
  ],
  "can_create_tag": false,
  "can_tag_topics": false,
  "can_tag_pms": false,
  "tags_filter_regexp": "[/\\\\?#\\\\[\\\\]@!\\\\$\\u0026'\\\\(\\\\)\\*\\\\+,;=\\\\.%\\\\\\\\`^\\\\s|\\\\{\\\\}\\\"\\u003c\\u003e]+",
  "top_tags": [
    {"id": 47, "name": "Code-with-SOLO", "slug": "47-tag"},
    {"id": 46, "name": "新SOLO初体验", "slug": "46-tag"},
    {"id": 11, "name": "基础技巧", "slug": "11-tag"},
    {"id": 48, "name": "More-than-Coding", "slug": "48-tag"},
    {"id": 2, "name": "solo", "slug": "2-tag"},
    {"id": 20, "name": "已解决", "slug": "20-tag"},
    {"id": 7, "name": "Skills", "slug": "7-tag"},
    {"id": 51, "name": "Hello-AI-科技致善", "slug": "51-tag"},
    {"id": 3, "name": "模型", "slug": "3-tag"},
    {"id": 17, "name": "trae技巧便利店", "slug": "17-tag"}
  ],
  "navigation_menu_site_top_tags": [
    {"id": 47, "name": "Code-with-SOLO", "slug": "47-tag"},
    {"id": 46, "name": "新SOLO初体验", "slug": "46-tag"},
    {"id": 11, "name": "基础技巧", "slug": "11-tag"},
    {"id": 48, "name": "More-than-Coding", "slug": "48-tag"},
    {"id": 2, "name": "solo", "slug": "2-tag"}
  ],
  "topic_featured_link_allowed_category_ids": [
    1, 6, 11, 18, 28, 14, 25, 35, 5, 23, 8, 29, 4, 19, 20, 31, 34, 7,
    16, 17, 27, 12, 26, 3, 15, 33, 24, 9, 30, 22, 32, 10
  ],
  "user_themes": [
    {"theme_id": -1, "name": "Foundation", "default": true, "color_scheme_id": 21, "dark_color_scheme_id": 21}
  ],
  "user_color_schemes": [],
  "default_light_color_scheme": {
    "id": 21,
    "name": "新调色板",
    "colors": [
      {"name": "primary", "hex": "1A1B1D", "default_hex": "1a1a1a", "is_advanced": false},
      {"name": "secondary", "hex": "F3F4F5", "default_hex": "ffffff", "is_advanced": false},
      {"name": "tertiary", "hex": "0AB861", "default_hex": "39845b", "is_advanced": false},
      {"name": "quaternary", "hex": "0FDC78", "default_hex": "e45735", "is_advanced": false},
      {"name": "header_background", "hex": "1A1B1D", "default_hex": "ffffff", "is_advanced": false},
      {"name": "header_primary", "hex": "FFFFFF", "default_hex": "1a1a1a", "is_advanced": false},
      {"name": "selected", "hex": "DFE1E5", "default_hex": "c6f1d5", "is_advanced": false},
      {"name": "hover", "hex": "E6E8EB", "default_hex": "d5f5e0", "is_advanced": false},
      {"name": "highlight", "hex": "F39D35", "default_hex": "ffff4d", "is_advanced": false},
      {"name": "danger", "hex": "E8463A", "default_hex": "c80001", "is_advanced": false},
      {"name": "success", "hex": "32F08C", "default_hex": "090", "is_advanced": false},
      {"name": "love", "hex": "F53CFF", "default_hex": "fa6c8d", "is_advanced": false}
    ]
  },
  "default_dark_color_scheme": {...},
  "censored_regexp": [],
  "custom_emoji_translation": {},
  "watched_words_replace": null,
  "watched_words_link": null,
  "categories": [
    {"id": 1, "name": "未分类", "color": "0088CC", "text_color": "FFFFFF", "slug": ""},
    {"id": 4, "name": "官方公告", "color": "BF1E2E", "text_color": "FFFFFF", "slug": "4-category"},
    {"id": 7, "name": "帮助与支持", "color": "FF661A", "text_color": "FFFFFF", "slug": "7-category"},
    {"id": 8, "name": "产品建议", "color": "3ABBE8", "text_color": "FFFFFF", "slug": "8-category"},
    {"id": 9, "name": "技巧分享", "color": "499A4F", "text_color": "FFFFFF", "slug": "9-category"},
    {"id": 10, "name": "案例与作品", "color": "B47B3E", "text_color": "FFFFFF", "slug": "10-category"},
    {"id": 11, "name": "互动交流", "color": "00ACC1", "text_color": "FFFFFF", "slug": "11-category"},
    {"id": 29, "name": "福利活动", "color": "27ADF2", "text_color": "FFFFFF", "slug": "29-category"},
    {"id": 33, "name": "社区伙伴", "color": "008A6C", "text_color": "FFFFFF", "slug": "33-category"},
    {"id": 35, "name": "SOLO挑战赛专区", "color": "E91E63", "text_color": "FFFFFF", "slug": "35-category"}
  ]
}
```

---

## 九、分类结构 (categories.json)

### 9.1 分类完整数据

```json
{
  "category_list": {
    "can_create_category": false,
    "categories": [
      {
        "id": 1,
        "name": "未分类",
        "color": "0088CC",
        "text_color": "FFFFFF",
        "style_type": "square",
        "icon": null,
        "emoji": null,
        "slug": "",
        "topic_count": 0,
        "post_count": 0,
        "position": 0,
        "description": "",
        "description_text": "不需要类别或不适合任何其他现有类别的话题。",
        "description_excerpt": "不需要类别或不适合任何其他现有类别的话题。",
        "show_subcategory_list": false,
        "subcategory_ids": [],
        "default_view": "",
        "default_new_topic_banner": null
      },
      {
        "id": 4,
        "name": "官方公告",
        "color": "BF1E2E",
        "text_color": "FFFFFF",
        "style_type": "square",
        "slug": "4-category",
        "topic_count": 15,
        "post_count": 89,
        "position": 1,
        "description_text": "TRAE 官方公告和产品更新信息发布区",
        "subcategory_ids": []
      },
      {
        "id": 35,
        "name": "SOLO挑战赛专区",
        "color": "E91E63",
        "text_color": "FFFFFF",
        "style_type": "square",
        "slug": "35-category",
        "topic_count": 156,
        "post_count": 2340,
        "position": 8,
        "description_text": "SOLO 挑战赛作品展示、赛事讨论和官方通知"
      },
      {
        "id": 11,
        "name": "互动交流",
        "color": "00ACC1",
        "text_color": "FFFFFF",
        "style_type": "square",
        "slug": "11-category",
        "topic_count": 892,
        "post_count": 15678,
        "position": 4,
        "description_text": "开发者交流讨论区"
      }
    ]
  }
}
```

---

## 十、标签结构 (tags.json)

### 10.1 标签完整数据

```json
{
  "tags": [
    {"id": 47, "name": "Code-with-SOLO", "slug": "47-tag", "count": 125},
    {"id": 46, "name": "新SOLO初体验", "slug": "46-tag", "count": 89},
    {"id": 11, "name": "基础技巧", "slug": "11-tag", "count": 67},
    {"id": 48, "name": "More-than-Coding", "slug": "48-tag", "count": 45},
    {"id": 2, "name": "solo", "slug": "2-tag", "count": 234},
    {"id": 20, "name": "已解决", "slug": "20-tag", "count": 156},
    {"id": 7, "name": "Skills", "slug": "7-tag", "count": 34},
    {"id": 51, "name": "Hello-AI-科技致善", "slug": "51-tag", "count": 78},
    {"id": 3, "name": "模型", "slug": "3-tag", "count": 23},
    {"id": 17, "name": "trae技巧便利店", "slug": "17-tag", "count": 56}
  ],
  "extras": {
    "tags_section_description": "标签用于标记话题内容，方便搜索和筛选"
  },
  "top_tags": [
    {"id": 47, "name": "Code-with-SOLO", "slug": "47-tag"},
    {"id": 46, "name": "新SOLO初体验", "slug": "46-tag"},
    {"id": 11, "name": "基础技巧", "slug": "11-tag"},
    {"id": 48, "name": "More-than-Coding", "slug": "48-tag"},
    {"id": 2, "name": "solo", "slug": "2-tag"}
  ]
}
```

---

## 十一、搜索结果结构 (search.json)

### 11.1 搜索结果数据

```json
{
  "posts": [
    {
      "id": 40533,
      "name": "",
      "username": "邪修airobot",
      "avatar_template": "/user_avatar/forum.trae.cn/邪修airobot/{size}/4805_2.png",
      "created_at": "2026-04-10T03:58:07.163Z",
      "like_count": 1,
      "blurb": "1. 系统概述 AI-Video-Framework 是一个面向视频生成的全自动化生产框架。系统通过 AI 作文生成、图片处理、TTS 语音合成、ASR 字幕识别、剪映草稿构建、视频导出六大核心能力，实现从文本到视频的端到端自动化生产。",
      "post_number": 1,
      "topic_id": 7531
    },
    {
      "id": 47538,
      "name": "",
      "username": "用户31433",
      "avatar_template": "/user_avatar/forum.trae.cn/用户31433/{size}/947_2.png",
      "created_at": "2026-04-15T05:50:18.181Z",
      "like_count": 1,
      "blurb": "在VSCode中安装了TRAE AI 扩展件，老是自动打开aiServerMainV2.js文件",
      "post_number": 1,
      "topic_id": 9175
    },
    {
      "id": 10243,
      "name": "",
      "username": "Damond",
      "avatar_template": "/user_avatar/forum.trae.cn/damond/{size}/7344_2.png",
      "created_at": "2026-03-13T03:18:26.758Z",
      "like_count": 2,
      "blurb": "ai-coding-memory 是一个 AI Coding 项目记忆系统，用于： ...",
      "post_number": 1,
      "topic_id": 2100
    }
  ],
  "topics": [
    {
      "id": 7531,
      "title": "AI-Video-Framework - AI视频全自动生产框架",
      "reply_count": 12,
      "like_count": 5
    },
    {
      "id": 9175,
      "title": "VSCode安装TRAE AI扩展件后出现异常",
      "reply_count": 8,
      "like_count": 2
    }
  ],
  "users": [
    {"id": 100, "username": "邪修airobot", "name": ""},
    {"id": 101, "username": "用户31433", "name": ""}
  ],
  "categories": [],
  "tags": [],
  "groups": []
}
```

---

## 十二、Cooked HTML 内容结构

### 12.1 支持的 HTML 标签

| 标签 | 含义 | 渲染方式 |
|------|------|----------|
| `<p>` | 段落 | 文本块 |
| `<h1>` - `<h4>` | 标题 | 加粗标题 |
| `<img>` | 图片 | 带懒加载的图片 |
| `<a>` | 链接 | 可点击链接 |
| `<blockquote>` | 引用 | 带左边框的引用块 |
| `<pre><code>` | 代码块 | 等宽字体代码块 |
| `<ul>` / `<ol>` | 列表 | 有序/无序列表 |
| `<aside class="quote">` | 引用回复 | 嵌套引用卡片 |
| `<emoji>` | 表情 | emoji图标 |
| `<video>` | 视频 | 视频播放器 |

### 12.2 Cooked HTML 示例

```html
<p>欢迎来到「AI 无限职场」SOLO 挑战赛！这里是全新公益赛道「Hello AI 科技致善」的作品提交指南。</p>

<p><img src="https://forum.trae.cn/uploads/default/original/1X/abc123.jpg" alt="封面图"></p>

<blockquote>
  <p>引用内容：已经报名，且提交作品，没有收到邀请码</p>
  <footer>— 用户40995</footer>
</blockquote>

<pre><code class="language-python">
def hello():
    print("Hello AI!")
</code></pre>

<aside class="quote no-group" data-username="TRAE-小阳" data-post="2" data-topic="7225">
  <div class="title">
    <img alt="" width="24" height="24" src="..."> TRAE-小阳:
  </div>
  <blockquote><p>会尽快处理...</p></blockquote>
</aside>

<p><img src="https://forum.trae.cn/images/emoji/twitter/tada.png?v=15" title=":tada:" class="emoji" alt=":tada:"></p>
```

---

## 十三、头像 URL 构造规则

### 13.1 Avatar 模板格式

```
{avatar_template} = /user_avatar/forum.trae.cn/{username}/{size}/{upload_id}_2.png
```

### 13.2 可用尺寸

| size值 | 用途 |
|--------|------|
| 24 | 小图标、徽章 |
| 48 | 列表缩略图 |
| 96 | 中等尺寸 |
| 120 | 大尺寸 |
| 240 | 高分辨率 |

### 13.3 完整 URL 构造示例

```
原始模板: /user_avatar/forum.trae.cn/trae-小阳/{size}/5101_2.png
构造URL:  https://forum.trae.cn/user_avatar/forum.trae.cn/trae-小阳/96/5101_2.png
```

---

## 十四、分类 ID 映射表

| ID | 名称 | slug | 颜色 | 话题数 | 说明 |
|----|------|------|------|--------|------|
| 1 | 未分类 | (无) | #0088CC | - | 默认分类 |
| 4 | 官方公告 | 4-category | #BF1E2E | 15 | 官方通知 |
| 7 | 帮助与支持 | 7-category | #FF661A | - | 技术支持 |
| 8 | 产品建议 | 8-category | #3ABBE8 | - | 反馈建议 |
| 9 | 技巧分享 | 9-category | #499A4F | - | 教程经验 |
| 10 | 案例与作品 | 10-category | #B47B3E | - | 作品展示 |
| 11 | 互动交流 | 11-category | #00ACC1 | 892 | 讨论区 |
| 29 | 福利活动 | 29-category | #27ADF2 | - | 活动福利 |
| 33 | 社区伙伴 | 33-category | #008A6C | - | 生态协作 |
| 35 | SOLO挑战赛专区 | 35-category | #E91E63 | 156 | 赛事专区 |

---

## 十五、热门标签映射表

| ID | 名称 | slug | 话题数 |
|----|------|------|--------|
| 47 | Code-with-SOLO | 47-tag | 125 |
| 46 | 新SOLO初体验 | 46-tag | 89 |
| 11 | 基础技巧 | 11-tag | 67 |
| 48 | More-than-Coding | 48-tag | 45 |
| 2 | solo | 2-tag | 234 |
| 20 | 已解决 | 20-tag | 156 |
| 7 | Skills | 7-tag | 34 |
| 51 | Hello-AI-科技致善 | 51-tag | 78 |
| 3 | 模型 | 3-tag | 23 |
| 17 | trae技巧便利店 | 17-tag | 56 |

---

## 十六、动作类型 ID 映射

| action_id | name_key | 显示名称 | 是否为举报 | 说明 |
|------------|----------|----------|------------|------|
| 2 | like | 点赞 | 否 | 普通互动 |
| 3 | off_topic | 偏离话题 | 是 | 举报类型 |
| 4 | inappropriate | 不当言论 | 是 | 举报类型 |
| 6 | notify_user | 发送消息 | 否 | 私信 |
| 7 | notify_moderators | 其他内容 | 是 | 举报类型 |
| 8 | spam | 垃圾信息 | 是 | 举报类型 |
| 10 | illegal | 非法 | 是 | 举报类型 |

---

## 十七、帖子类型 ID 映射

| post_type | 类型名称 | 说明 |
|------------|----------|------|
| 1 | regular | 普通帖子 |
| 2 | moderator_action | 版主操作 |
| 3 | small_action | 小动作（如移动、合并等系统消息） |
| 4 | whisper | 悄悄话（仅特定用户可见） |

---

## 十八、通知类型 ID 映射

| type_id | name_key | 说明 |
|---------|----------|------|
| 1 | mentioned | 被@ |
| 2 | replied | 被回复 |
| 3 | quoted | 被引用 |
| 4 | edited | 内容被编辑 |
| 5 | liked | 获得点赞 |
| 6 | private_message | 私信 |
| 9 | posted | 发布新帖 |
| 12 | granted_badge | 获得徽章 |
| 17 | watching_first_post | 关注的话题有新帖 |
| 24 | bookmark_reminder | 收藏提醒 |
| 25 | reaction | 表情反应 |
| 800 | following | 关注 |
| 801 | following_created_topic | 关注的人发新帖 |
| 802 | following_replied | 关注的人回复 |

---

## 十九、页面响应头关键信息

### 19.1 Discourse 路由标识 (x-discourse-route)

| route | 对应页面 |
|-------|----------|
| site/site | 站点首页 |
| topics/show | 话题详情 |
| posts/user_posts_feed | 用户活动 |
| users/show | 用户资料 |
| categories/index | 分类列表 |
| tags/index | 标签列表 |
| search/index | 搜索结果 |

### 19.2 缓存标识

| x-discourse-cached | 说明 |
|---------------------|------|
| store | 来自缓存的响应 |

---

## 二十、已验证不可用端点

| 端点 | 状态码 | 说明 |
|------|--------|------|
| `/users/list.json?order=likes_received&period=monthly` | 404 | 无独立用户列表API |
| `/t/topic/{id}/post_ids.json` | 404 | 无独立post_ids接口 |
| `/reviewable_approved.json` | 404 | 无审核队列公开API |
| `/tag/{slug}/{id}.json` | 404 | 无标签详情独立接口 |
| `/topics/similar_to.json?title=xxx` | 200(空) | 接口存在但无数据 |
| `/notifications.json` | 需认证 | 需要登录 |
| `/bookmarks.json` | 需认证 | 需要登录 |
| `/drafts.json` | 需认证 | 需要登录 |

---

## 二十一、开发注意事项

### 21.1 API 调用规范
1. 所有 API 均支持 `.json` 格式
2. 请求无需认证即可读取公开数据
3. Brotli 压缩响应，需客户端支持解压
4. 相对 URL 需拼接完整域名

### 21.2 数据处理要点
1. `avatar_template` 中的 `{size}` 需替换为具体数值
2. `cooked` HTML 需使用 `flutter_html` 或类似库渲染
3. 时间字段为 ISO 8601 格式，需转换本地时间
4. `post_stream.stream` 包含有序的帖子 ID 列表

### 21.3 错误处理
1. 网络错误：显示重试入口
2. 4xx/5xx：显示友好错误提示
3. 解析失败：记录日志并显示空态
4. 认证错误：引导用户登录

---

**文档版本**: v1.0
**创建时间**: 2026-04-24
**更新记录**: 初始版本
