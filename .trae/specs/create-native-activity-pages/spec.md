# 创建原生用户活动页面 Spec

## Why
之前使用 WebView 打开论坛网页的方式不够原生体验好，需要创建原生的 Flutter 页面来展示用户的各类活动数据（话题、回复、已读、草稿、赞、书签、已解决、投票）。

## What Changes
- 创建 8 个独立的原生活动列表页面：
  - 话题页面 - 展示用户发布的话题
  - 回复页面 - 展示用户的回复
  - 已读页面 - 展示用户已读的内容
  - 草稿页面 - 展示用户的草稿
  - 赞页面 - 展示用户点赞的内容
  - 书签页面 - 展示用户的书签
  - 已解决页面 - 展示用户标记为已解决的内容
  - 投票页面 - 展示用户投票的内容
- 修改 `profile_page_new.dart` 中的快捷功能入口，使用应用内路由跳转到原生页面
- 复用现有的 API 服务获取数据

## Impact
- Affected specs: 用户个人主页功能导航
- Affected code: 
  - `lib/presentation/pages/user/profile_page_new.dart`
  - 新增 8 个页面文件
  - 可能需要新增或修改路由配置

## ADDED Requirements
### Requirement: 原生活动页面
The system SHALL 提供 8 个原生 Flutter 页面展示用户活动数据

#### Scenario: 用户点击功能入口
- **GIVEN** 用户已登录
- **WHEN** 用户点击"常用功能"中的任意入口
- **THEN** 应用导航到对应的原生页面展示数据

#### Scenario: 页面数据加载
- **GIVEN** 用户进入活动页面
- **WHEN** 页面初始化
- **THEN** 调用 API 加载对应类型的活动数据

## MODIFIED Requirements
### Requirement: 常用功能入口配置
**Current**: 使用 WebView 打开论坛网页
**New**: 使用应用内路由跳转到原生页面

## REMOVED Requirements
### Requirement: WebView 打开论坛页面
**Reason**: 改为使用原生页面提供更好的用户体验
**Migration**: 移除 `_openForumWebView` 方法，改为使用 `context.push` 导航到原生页面
