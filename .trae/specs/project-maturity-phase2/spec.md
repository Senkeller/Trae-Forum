# TraeU 项目完善 Phase 2 规格文档

## Why

基于完善度分析报告，当前项目已达到 **90/100** 分，但距离成熟论坛 App 仍有以下关键差距：

1. **测试覆盖不足**（75/100）：页面测试仅 30%，核心流程缺乏 E2E 测试
2. **实时功能缺失**：私信、实时推送未实现
3. **动画体验一般**：缺少页面过渡动画、微交互动画
4. **无障碍支持缺失**：未考虑 Accessibility

目标：在 1 周内完成 Phase 2，将完善度从 90 分提升到 **95+** 分。

## What Changes

### Phase 2-1: 核心页面测试覆盖提升（+3 分）

#### 问题
- 页面测试覆盖率仅 30%
- 大部分页面无测试
- 缺乏用户核心流程的测试

#### 方案
- 为核心页面补充 Widget 测试
- 增加用户任务链的集成测试
- 建立测试基类/工具类提高测试效率

#### 验收
- 核心页面（Feed、Topic、User、Settings）测试覆盖率达到 80%+
- 用户任务链测试全部通过
- 新增测试 20+ 个

### Phase 2-2: 动画体验增强（+1 分）

#### 问题
- 页面切换生硬，无过渡动画
- 缺少微交互动画（点赞、收藏等）
- 整体体验不够流畅

#### 方案
- 添加页面过渡动画（Hero、Slide、Fade）
- 优化点赞按钮动画效果
- 添加列表项入场动画
- 添加下拉刷新/上拉加载动画

#### 验收
- 主要页面切换有平滑过渡动画
- 点赞、收藏等操作有反馈动画
- 列表加载有入场动画效果

### Phase 2-3: 无障碍支持（+1 分）

#### 问题
- 未添加 Semantics 标签
- 屏幕阅读器无法正常使用
- 不符合无障碍标准

#### 方案
- 为核心组件添加 Semantics 标签
- 确保所有可交互元素有正确的标签和提示
- 测试屏幕阅读器兼容性

#### 验收
- 主要页面可通过屏幕阅读器导航
- 所有按钮、链接有正确的语义标签
- 通过无障碍基础检查

### Phase 2-4: 私信功能基础实现（+2 分）

#### 问题
- 缺少私信功能
- 用户间无法直接沟通
- 社交属性不足

#### 方案
- 实现私信会话列表页面
- 实现私信聊天页面（基础版）
- 集成 Discourse 私信 API
- 添加未读消息提示

#### 验收
- 可查看私信会话列表
- 可进入单一会话查看消息
- 可发送新消息
- 有未读消息提示

### Phase 2-5: 实时推送基础框架（+1 分）

#### 问题
- 无实时消息推送
- 用户需手动刷新查看新消息
- 体验不够实时

#### 方案
- 集成 Firebase Cloud Messaging
- 实现推送消息接收和处理
- 添加本地通知展示
- 实现点击通知跳转对应页面

#### 验收
- 可接收推送消息
- 推送消息显示本地通知
- 点击通知可跳转到对应页面

## Impact

### 受影响代码
- `test/` - 新增大量测试
- `lib/presentation/pages/` - 添加 Semantics 标签
- `lib/presentation/widgets/` - 添加动画效果
- `lib/presentation/pages/message/` - 新增私信功能
- `lib/core/services/` - 新增推送服务
- `android/`, `ios/` - 推送配置

## ADDED Requirements

### Requirement: 核心页面测试覆盖
系统 SHALL 为核心页面提供 Widget 测试，确保核心流程可验证。

#### Scenario: Feed 页面测试
- **GIVEN** Feed 页面加载完成
- **WHEN** 用户下拉刷新
- **THEN** 系统 SHALL 触发刷新并显示新内容

#### Scenario: 话题详情页测试
- **GIVEN** 话题详情页加载完成
- **WHEN** 用户点击回复
- **THEN** 系统 SHALL 打开回复输入框

### Requirement: 动画体验
系统 SHALL 提供流畅的页面过渡动画和微交互动画。

#### Scenario: 页面切换
- **GIVEN** 用户导航到新页面
- **WHEN** 页面开始加载
- **THEN** 系统 SHALL 显示平滑的过渡动画

#### Scenario: 点赞操作
- **GIVEN** 用户点击点赞按钮
- **WHEN** 点赞成功
- **THEN** 系统 SHALL 显示点赞动画反馈

### Requirement: 无障碍支持
系统 SHALL 支持屏幕阅读器访问，所有可交互元素有正确的语义标签。

#### Scenario: 屏幕阅读器导航
- **GIVEN** 用户启用屏幕阅读器
- **WHEN** 浏览主要页面
- **THEN** 系统 SHALL 正确朗读所有元素标签

### Requirement: 私信功能
系统 SHALL 支持用户间私信沟通。

#### Scenario: 查看会话列表
- **GIVEN** 用户进入消息页面
- **WHEN** 有私信会话
- **THEN** 系统 SHALL 显示会话列表

#### Scenario: 发送私信
- **GIVEN** 用户在私信聊天页
- **WHEN** 输入消息并发送
- **THEN** 系统 SHALL 发送消息并显示在列表中

### Requirement: 实时推送
系统 SHALL 支持接收推送消息并展示本地通知。

#### Scenario: 接收推送
- **GIVEN** App 在后台或前台
- **WHEN** 有新推送消息
- **THEN** 系统 SHALL 显示本地通知

#### Scenario: 点击通知跳转
- **GIVEN** 用户看到推送通知
- **WHEN** 点击通知
- **THEN** 系统 SHALL 打开对应页面

## MODIFIED Requirements

### Requirement: 测试策略
**原要求**: 基础单元测试和集成测试
**新要求**: 增加核心页面 Widget 测试和 E2E 测试

### Requirement: 用户体验
**原要求**: 基础交互功能
**新要求**: 增加动画反馈和无障碍支持

## REMOVED Requirements

无

## 验收标准

### Phase 2 DoD
- [ ] 核心页面测试覆盖率达到 80%+
- [ ] 主要页面有过渡动画
- [ ] 主要页面可通过屏幕阅读器访问
- [ ] 私信功能基础可用
- [ ] 推送功能基础可用
- [ ] 完善度评分达到 95+

## 验证命令

```bash
flutter pub get
flutter analyze
flutter test
cd integration_test && flutter test integration_test/app_test.dart
```
