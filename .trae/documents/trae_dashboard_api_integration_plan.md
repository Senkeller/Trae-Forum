# Trae Dashboard API 集成计划

## 目标
复用 WebView 登录后的 Cookie，直接调用 Trae Dashboard API 获取用户统计数据（热力图、代码采纳、模型偏好、编程时段等），并在应用中展示。

## 当前状态分析

### 已有基础
1. **WebView 登录实现** (`webview_login_page.dart`)
   - 使用 `webview_flutter` 加载 Trae 登录页面
   - 登录成功后跳转到论坛首页
   - 已保存用户基本信息到 SharedPreferences

2. **认证管理** (`auth_provider.dart`)
   - 使用 Riverpod 管理认证状态
   - 保存 uid, username, avatarUrl 到本地

3. **网络层** (`api_service.dart`)
   - 使用 Dio 进行 HTTP 请求
   - 已适配 Discourse API

### 缺失部分
1. 没有保存/管理 Trae Dashboard 所需的 Cookie
2. 没有 Trae Dashboard API 的数据模型
3. 没有 Trae Dashboard API 的调用实现
4. 没有展示 Dashboard 数据的 UI 页面

---

## 实施步骤

### 阶段 1: Cookie 管理

#### 1.1 创建 Cookie 管理器
**文件**: `lib/core/network/cookie_manager.dart`

- 创建 `TraeCookieManager` 类
- 使用 `webview_flutter` 的 `CookieManager` 提取 Cookie
- 保存 Cookie 到 SharedPreferences
- 提供 Cookie 读取接口供 Dio 使用

#### 1.2 修改 WebView 登录页面
**文件**: `lib/presentation/pages/user/webview_login_page.dart`

- 登录成功后提取 Trae Cookie
- 保存关键 Cookie: `sessionid`, `sessionid_ss`, `sid_tt`, `ttwid`, `X-Cloudide-Session`
- 调用 `TraeCookieManager.saveCookies()`

### 阶段 2: 数据模型创建

#### 2.1 创建 Trae Dashboard 数据模型
**文件**: `lib/data/models/trae_dashboard.dart`

使用 Freezed 创建以下模型:
- `TraeUserStats` - 用户统计数据主模型
- `DailyActivity` - 每日活跃数据（热力图）
- `LanguageStats` - 编程语言统计
- `AgentStats` - 智能体使用统计
- `ModelStats` - AI 模型调用统计
- `HourlyActivity` - 时段活跃统计

### 阶段 3: API 服务实现

#### 3.1 创建 Trae Dashboard API 服务
**文件**: `lib/core/network/trae_dashboard_api.dart`

- 创建 `TraeDashboardApi` 类
- 配置 Dio 实例（BaseURL: `https://api.trae.cn`）
- 添加 Cookie 拦截器
- 实现 API 方法:
  - `getUserStats()` - 获取用户统计数据
  - `getUserInfo()` - 获取用户信息

#### 3.2 创建 Repository 层
**文件**: `lib/data/repositories/trae_dashboard_repository.dart`

- 创建 `TraeDashboardRepository` 类
- 封装 API 调用
- 处理错误和数据转换

### 阶段 4: State Management

#### 4.1 创建 Dashboard Provider
**文件**: `lib/presentation/providers/trae_dashboard_provider.dart`

- 创建 `TraeDashboardNotifier` (StateNotifier)
- 管理 Dashboard 数据状态
- 提供刷新数据方法

### 阶段 5: UI 实现

#### 5.1 创建 Dashboard 页面
**文件**: `lib/presentation/pages/dashboard/trae_dashboard_page.dart`

包含以下组件:
- 用户信息卡片
- 活跃天数热力图 (使用 `heatmap` 或自定义 Grid)
- 代码采纳统计卡片
- 编程语言分布图
- 智能体使用统计
- AI 模型偏好排行
- 编程时段分布图（波浪曲线）

#### 5.2 创建图表组件
**文件**: `lib/presentation/widgets/dashboard/`

- `activity_heatmap.dart` - 活跃热力图
- `language_bar_chart.dart` - 语言分布条形图
- `model_preference_list.dart` - 模型偏好列表
- `hourly_activity_curve.dart` - 时段分布曲线

### 阶段 6: 路由集成

#### 6.1 添加路由
**文件**: `lib/config/router.dart`

- 添加 `/trae-dashboard` 路由
- 在主页或用户页面添加入口

---

## 技术细节

### API 端点
```
POST https://api.trae.cn/cloudide/api/v3/trae/GetUserStasticData
Content-Type: application/json
Cookie: [登录后的 Cookie]

Request Body:
{
  "LocalTime": "2026-04-24T13:48:26.149Z"
}
```

### 关键 Cookie 字段
- `sessionid` - 会话 ID
- `sessionid_ss` - 安全会话 ID
- `sid_tt` - 用户标识
- `ttwid` - 抖音/字节系用户标识
- `X-Cloudide-Session` - CloudIDE 会话

### 依赖包
```yaml
dependencies:
  # 已有
  dio: ^x.x.x
  webview_flutter: ^x.x.x
  shared_preferences: ^x.x.x
  flutter_riverpod: ^x.x.x
  freezed_annotation: ^x.x.x
  
  # 新增
  heatmap_calendar: ^x.x.x  # 或自定义实现
  fl_chart: ^x.x.x          # 图表库
```

---

## 文件结构

```
lib/
├── core/
│   └── network/
│       ├── cookie_manager.dart          # Cookie 管理
│       └── trae_dashboard_api.dart      # Dashboard API 服务
├── data/
│   ├── models/
│   │   └── trae_dashboard.dart          # 数据模型
│   └── repositories/
│       └── trae_dashboard_repository.dart
├── presentation/
│   ├── pages/
│   │   └── dashboard/
│   │       └── trae_dashboard_page.dart
│   ├── providers/
│   │   └── trae_dashboard_provider.dart
│   └── widgets/
│       └── dashboard/
│           ├── activity_heatmap.dart
│           ├── language_bar_chart.dart
│           ├── model_preference_list.dart
│           └── hourly_activity_curve.dart
```

---

## 风险与注意事项

1. **Cookie 过期**: Trae Cookie 有过期时间，需要处理过期后的重新登录
2. **API 变动**: 逆向 API 可能随时变动，需要做好错误处理
3. **CORS 限制**: 直接调用可能遇到跨域问题，考虑使用 WebView 或代理
4. **隐私合规**: 确保用户数据使用符合隐私政策

---

## 验证清单

- [ ] Cookie 成功提取并保存
- [ ] API 调用返回正确数据
- [ ] 热力图正确显示 365 天数据
- [ ] 代码采纳统计准确
- [ ] 模型偏好排行正确
- [ ] 编程时段曲线正常显示
- [ ] 页面加载有 loading 状态
- [ ] 错误处理完善（网络错误、未登录等）
