# 常用功能入口适配论坛链接 Spec

## Why
当前"我的"页面中的"常用功能"入口使用的是应用内路由，需要将它们适配为直接跳转到论坛网页的对应功能页面，以便用户能够访问更完整的论坛功能。

## What Changes
- 修改 `profile_page_new.dart` 中的快捷功能网格配置
- 新增论坛网页链接支持，使用 WebView 打开论坛页面
- 替换现有功能入口为论坛对应链接：
  - 话题 → `/u/{username}/activity`
  - 回复 → `/u/{username}/activity/replies`
  - 已读 → `/u/{username}/activity/read`
  - 草稿 → `/u/{username}/activity/drafts`
  - 赞 → `/u/{username}/activity/likes-given`
  - 书签 → `/u/{username}/activity/bookmarks`
  - 已解决 → `/u/{username}/activity/solved`
  - 投票 → `/u/{username}/activity/votes`

## Impact
- Affected specs: 用户个人主页功能导航
- Affected code: 
  - `lib/presentation/pages/user/profile_page_new.dart`
  - 可能需要新增或修改路由配置

## ADDED Requirements
### Requirement: 论坛网页链接支持
The system SHALL 支持通过 WebView 打开论坛用户活动页面

#### Scenario: 用户点击功能入口
- **GIVEN** 用户已登录
- **WHEN** 用户点击"常用功能"中的任意入口
- **THEN** 应用通过 WebView 打开对应的论坛网页链接

#### Scenario: 构建论坛链接
- **GIVEN** 当前登录用户的 username
- **WHEN** 需要打开论坛活动页面
- **THEN** 系统使用 `https://forum.trae.cn/u/{username}/activity/{category}` 格式构建 URL

## MODIFIED Requirements
### Requirement: 常用功能入口配置
**Current**: 使用应用内路由和 onTap 回调
**New**: 使用论坛网页链接，通过 WebView 打开

## REMOVED Requirements
### Requirement: 本地功能页面
**Reason**: 改为直接使用论坛网页功能
**Migration**: 移除本地收藏、浏览历史、我常去等本地功能入口，替换为论坛功能链接
