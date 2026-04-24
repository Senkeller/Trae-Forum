# TRAE Forum 90% 功能升级任务清单

## M1 基础修复（1-1.5 周）

### Task 1.1: 清理伪实现
**目标**: 移除所有 `Not implemented` 和假实现
- [ ] 审计 `lib/core/network/api_service.dart` 中所有返回 `Not implemented` 的方法
- [ ] 移除所有 `/v6/*` 旧路径调用
- [ ] 移除 `status:404` 假成功逻辑
- [ ] 替换为正确错误返回或删除功能入口

### Task 1.2: 会话与 CSRF 统一
**目标**: 打通登录后会话一致性
- [ ] 确认 Dio CookieJar 与 WebView Cookie 同步机制
- [ ] 实现 CSRF Token 自动注入拦截器
- [ ] 验证登录后写接口可用（回复、点赞、已读）
- [ ] 实现会话过期检测与引导重新登录

### Task 1.3: 路由修复
**目标**: 修复消息跳转与错误路由
- [ ] `lib/config/routes.dart` 中消息详情跳转到真实帖子详情
- [ ] 移除占位路由的假跳转
- [ ] 添加缺失的路由定义

### Task 1.4: 网络错误模型统一
**目标**: 统一错误处理
- [ ] 定义网络错误、鉴权错误、业务错误、限流错误模型
- [ ] 429 实现退避重试策略
- [ ] 错误提示用户可理解

## M2 核心读写闭环（1.5-2 周）

### Task 2.1: 发帖模块
**目标**: 完成新建话题功能
- [ ] 实现 `POST /posts` 发帖接口
- [ ] FeedCreatePage 页面：标题+正文+分类+标签+预览+草稿
- [ ] 草稿自动保存与恢复
- [ ] 发布成功后跳转详情页

### Task 2.2: 回复模块
**目标**: 完成回复发送功能
- [ ] 实现 `POST /posts` 回复接口
- [ ] FeedDetailPage 底部输入改为真实发送
- [ ] FeedReplyPage 独立回复编辑器（支持引用楼层）
- [ ] 乐观更新 + 实际回写
- [ ] 回复失败可重试

### Task 2.3: 详情写操作
**目标**: 完成编辑、删除、点赞、收藏
- [ ] 实现 `PUT /posts/{postId}` 编辑接口
- [ ] 实现 `DELETE /posts/{postId}` 删除接口
- [ ] 实现 `POST /post_actions` 点赞
- [ ] 实现 `DELETE /post_actions/{postId}?post_action_type_id=2` 取消点赞
- [ ] 实现 `POST /bookmarks` 收藏
- [ ] 实现 `DELETE /bookmarks/{postId}` 取消收藏

### Task 2.4: 分类/标签/话题列表页
**目标**: 完成二级列表页
- [ ] TopicListPage - 综合话题流（latest/top/hot/votes/posted/bookmarks）
- [ ] TopicDetailPage - 标签/话题流详情
- [ ] 分类详情页支持话题流与置顶
- [ ] 标签页展示热门标签与标签话题流

### Task 2.5: 关注粉丝列表页
**目标**: 完成社交关系页面
- [ ] FollowListPage - 关注列表、取消关注、跳转用户主页
- [ ] FanListPage - 粉丝列表、回关、跳转用户主页
- [ ] `toggleFollow()` 改为 Discourse 兼容接口
- [ ] 关注状态在刷新后一致

## M3 二级页与消息体系（1.5 周）

### Task 3.1: 消息详情页
**目标**: 完成消息体系
- [ ] MessageDetailPage - 按类型查看通知子流
- [ ] NotificationsPage - 独立通知页（与消息页共享状态）
- [ ] 通知分组、已读、跳转详情、分页
- [ ] 通知点击跳转到真实帖子详情

### Task 3.2: 通知操作
**目标**: 完成通知标记已读
- [ ] 实现 `PUT /notifications/mark-read`
- [ ] 标记单条已读
- [ ] 全部已读
- [ ] 未读角标实时更新

### Task 3.3: 私信与聊天（最小可用）
**目标**: 完成私信基础功能
- [ ] 私信列表
- [ ] 私信详情阅读
- [ ] 私信话题发送回复
- [ ] Chat 频道列表（可选）

### Task 3.4: 设置子页
**目标**: 完成设置页面体系
- [ ] SettingsPage - 真实可保存项+缓存清理+退出登录
- [ ] ThemeSettingsPage - 主题模式、色彩方案
- [ ] FontSettingsPage - 字体比例、内容密度
- [ ] BlacklistPage - 本地屏蔽词/用户过滤
- [ ] AboutPage - 版本、协议、隐私、开源许可

### Task 3.5: 收藏与历史页
**目标**: 完成本地数据页
- [ ] HistoryPage - 浏览历史（本地存储）
- [ ] FavoritesPage - 收藏列表（服务端书签优先）

## 占位页补完清单（21 个）

### Task 4.1: 内容页占位替换
- [ ] FeedCreatePage - 新建话题页
- [ ] FeedReplyPage - 独立回复编辑器
- [ ] TopicListPage - 综合话题流
- [ ] TopicDetailPage - 标签/话题流详情
- [ ] ProductDetailPage - 专题页（可映射为专题页）

### Task 4.2: 用户社交页占位替换
- [ ] UserEditPage - 编辑昵称/头像/简介/偏好
- [ ] FollowListPage - 关注列表
- [ ] FanListPage - 粉丝列表

### Task 4.3: 消息通知页占位替换
- [ ] SearchResultPage - 搜索结果页
- [ ] MessageDetailPage - 消息详情
- [ ] NotificationsPage - 独立通知页
- [ ] NotificationSettingsPage - 通知偏好开关

### Task 4.4: 设置辅助页占位替换
- [ ] ThemeSettingsPage - 主题设置
- [ ] FontSettingsPage - 字体设置
- [ ] BlacklistPage - 黑名单
- [ ] AboutPage - 关于页
- [ ] RegisterPage - 注册页（跳转 SSO）
- [ ] ForgotPasswordPage - 找回密码页（跳转 SSO）

### Task 4.5: 工具页占位替换
- [ ] HistoryPage - 浏览历史
- [ ] FavoritesPage - 收藏列表
- [ ] ImagePreviewPage - 图片预览（手势缩放、左右滑动）
- [ ] ErrorPage - 统一错误中心（增强）

## M4 收敛与发布（1 周）

### Task 5.1: 性能优化
**目标**: 达到性能指标
- [ ] 首页首屏 P95 <=2.5s
- [ ] 列表滚动 60fps 稳定
- [ ] 图片加载失败率 <2%

### Task 5.2: 测试与回归
**目标**: 建立测试体系
- [ ] 单元测试：Adapter/Repository/Provider
- [ ] Widget 测试：首页、详情、搜索、消息、用户页
- [ ] 集成测试：登录 -> 浏览 -> 回复 -> 点赞 -> 通知已读
- [ ] 回归测试：占位页全部替换后路由冒烟

### Task 5.3: 质量收敛
**目标**: 通过质量门禁
- [ ] `flutter analyze` 无 error
- [ ] 核心链路集成测试全部通过
- [ ] 单元+Widget 测试总通过率 100%

### Task 5.4: 发布准备
**目标**: 完成发布
- [ ] 90% 覆盖自评
- [ ] 发布说明文档
- [ ] APK 构建验证

## 子任务包（并行执行）

| 包ID | 名称 | 输入 | 输出 |
|------|------|------|------|
| P1 | Discourse写接口打通 | `discourse_api_service.dart` | 发帖/回复/点赞/已读可用 |
| P2 | 会话与CSRF统一 | `dio_client.dart`, interceptors | 登录后写接口稳定 |
| P3 | 占位页替换I | 路由+页面骨架 | 10个页面可用 |
| P4 | 占位页替换II | 路由+页面骨架 | 剩余11个页面可用 |
| P5 | 消息与通知闭环 | message/notification providers | 通知与详情跳转闭环 |
| P6 | 用户社交闭环 | user providers/pages | 关注粉丝与活动闭环 |
| P7 | 测试与回归 | test目录 | 覆盖并通过质量门禁 |

## 任务依赖关系

```
P1 (Discourse写接口) → P2 (会话统一) → P3/P4 (页面实现) → P5/P6 (闭环) → P7 (测试)
                                                                   ↓
                                                          M1 → M2 → M3 → M4
```
