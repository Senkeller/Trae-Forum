# 论坛用户活动 API 逆向工程 Spec

## Why
现有的 API 可能无法完全覆盖论坛网页的所有功能，需要通过逆向工程分析论坛网页的实际 API 调用，以确保 8 个用户活动页面能够正确获取数据。

## What Changes
- 分析论坛网页的 8 个用户活动页面的 API 调用：
  - 话题: `/u/{username}/activity`
  - 回复: `/u/{username}/activity/replies`
  - 已读: `/u/{username}/activity/read`
  - 草稿: `/u/{username}/activity/drafts`
  - 赞: `/u/{username}/activity/likes-given`
  - 书签: `/u/{username}/activity/bookmarks`
  - 已解决: `/u/{username}/activity/solved`
  - 投票: `/u/{username}/activity/votes`
- 分析 API 请求参数、响应数据结构
- 更新或新增 API 方法到 `discourse_api_service.dart`
- 更新页面代码以使用正确的 API

## Impact
- Affected specs: 用户活动页面数据获取
- Affected code:
  - `lib/core/network/discourse_api_service.dart`
  - 8 个用户活动页面文件

## ADDED Requirements
### Requirement: API 逆向分析
The system SHALL 通过浏览器开发者工具分析论坛网页的 API 调用

#### Scenario: 分析话题页面 API
- **WHEN** 访问论坛用户话题页面
- **THEN** 捕获并分析 API 请求和响应

#### Scenario: 更新 API 服务
- **GIVEN** 已分析出正确的 API 端点
- **WHEN** 更新 `discourse_api_service.dart`
- **THEN** 页面能够正确获取数据

## MODIFIED Requirements
### Requirement: 用户活动页面 API 调用
**Current**: 使用推测的 API 端点
**New**: 使用逆向工程确认的正确 API 端点
