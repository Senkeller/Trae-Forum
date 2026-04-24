# TRAE论坛登录API逆向分析文档

## 文档信息
- **分析日期**: 2026-04-24
- **论坛地址**: https://forum.trae.cn
- **登录服务地址**: https://www.trae.cn
- **API基础地址**: https://api.trae.cn
- **分析目标**: TRAE论坛登录流程及API接口

---

## 一、登录架构概述

TRAE论坛采用 **SSO (单点登录)** 架构：
1. 论坛本身 (`forum.trae.cn`) 不直接处理登录
2. 登录由主站 (`www.trae.cn`) 统一处理
3. 登录成功后通过 SSO 机制同步登录状态到论坛
4. 基于字节跳动的 Passport 认证体系

### 登录流程图
```
┌─────────────┐     ┌──────────────┐     ┌─────────────┐
│  forum.trae │────▶│ www.trae.cn  │────▶│ api.trae.cn │
│    .cn      │     │  (登录页面)   │     │  (登录API)  │
└─────────────┘     └──────────────┘     └─────────────┘
       │                    │                    │
       │                    │                    │
       ▼                    ▼                    ▼
  1. 访问登录页        2. 输入手机号/验证码    3. 调用登录API
  重定向到SSO          发送验证码            验证并返回Token
  获取nonce/sig        滑动验证码验证
```

---

## 二、基础信息

### 2.1 认证方式
- **认证类型**: Cookie + Token
- **核心Cookie**: 
  - `ttwid` - 用户身份标识
  - `passport_csrf_token` - CSRF防护Token
  - `sessionid` - 会话ID
- **Token类型**: 字节跳动Passport Token

### 2.2 请求头规范
```http
Content-Type: application/json
Accept: application/json, text/plain, */*
Referer: https://www.trae.cn/
Origin: https://www.trae.cn
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)...
```

### 2.3 通用参数说明
| 参数名 | 说明 | 示例 |
|--------|------|------|
| aid | 应用ID | 711126 |
| passport_jssdk_version | SDK版本 | 3.0.11 |
| language | 语言 | zh |
| msToken | 机器标识Token | 随机生成 |

---

## 三、登录相关API

### 3.1 检查登录状态

**请求信息**
- **Method**: POST
- **URL**: `https://api.trae.cn/cloudide/api/v3/trae/CheckLogin`
- **描述**: 检查当前用户是否已登录

**请求体**
```json
{
  "GetNickNameEditStatus": true
}
```

**响应示例**
```json
{
  "ResponseMetadata": {
    "RequestId": "",
    "TraceID": "00000000000000000000000000000000",
    "WID": "7632312915006604800",
    "OID": "0"
  },
  "Result": {
    "IsLogin": false,
    "ExpiredAt": 0,
    "Region": "",
    "Host": "",
    "NickNameEditStatus": "",
    "UserID": "",
    "AIRegion": "",
    "AIHost": "",
    "AIPayHost": "",
    "PasswordChanged": false
  }
}
```

**响应字段说明**
| 字段名 | 类型 | 说明 |
|--------|------|------|
| IsLogin | boolean | 是否已登录 |
| ExpiredAt | integer | Token过期时间戳 |
| UserID | string | 用户ID |
| NickNameEditStatus | string | 昵称编辑状态 |

---

### 3.2 SSO登录状态检查

**请求信息**
- **Method**: POST
- **URL**: `https://api.trae.cn/cloudide/api/v3/trae/SSOCheckLogin`
- **描述**: 检查SSO登录状态，用于论坛单点登录

**请求体**
```json
{
  "GetNickNameEditStatus": true,
  "SSO": "bm9uY2U9...",  // Base64编码的SSO参数
  "Sig": "4e62aa393df2cbf571523bdcfe39b97f02e2612a6a6ce7a44a79ef88eb478ab1"
}
```

**SSO参数解码后格式**
```
nonce=35c659b48d0bb82c619f8a91169319b6&return_sso_url=https%3A%2F%2Fforum.trae.cn%2Fsession%2Fsso_login
```

**响应示例**
```json
{
  "ResponseMetadata": {
    "RequestId": "",
    "TraceID": "00000000000000000000000000000000",
    "WID": "7632312915006604800",
    "OID": "1364969441726044"
  },
  "Result": {
    "IsLogin": false,
    "ExpiredAt": 0,
    "SSOSuccess": null,
    "RedirectURL": null
  }
}
```

---

### 3.3 发送验证码

**请求信息**
- **Method**: POST
- **URL**: `https://www.trae.cn/passport/web/send_code/`
- **描述**: 向指定手机号发送短信验证码

**查询参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| passport_jssdk_version | string | 是 | SDK版本，如 3.0.11 |
| passport_jssdk_type | string | 是 | SDK类型，如 normal |
| aid | integer | 是 | 应用ID，固定 711126 |
| language | string | 是 | 语言，如 zh |
| account_sdk_source | string | 是 | 来源，如 web |
| sign | string | 是 | 请求签名 |
| msToken | string | 是 | 机器标识 |
| a_bogus | string | 是 | 防爬虫参数 |

**请求体 (Form格式)**
```
mix_mode=1&mobile={加密手机号}&type=3731&fixed_mix_mode=1
```

**手机号加密方式**
- 手机号经过特定算法加密
- 例如: `13800138000` → `34363d353534363d353535`

**响应示例 - 需要验证码**
```json
{
  "data": {
    "captcha": "",
    "desc_url": "",
    "description": "滑动滑块进行验证",
    "error_code": 1105,
    "verify_center_decision_conf": "{...}",
    "verify_ticket": "VTIDEFTRYK6VUW9HPTENGTGJEJ4QF99GDBSTW9_lf"
  },
  "message": "error"
}
```

**响应示例 - 发送成功**
```json
{
  "data": {
    "expire_time": 60,
    "error_code": 0,
    "description": ""
  },
  "message": "success"
}
```

**错误码说明**
| 错误码 | 说明 |
|--------|------|
| 0 | 成功 |
| 1105 | 需要滑动验证码验证 |
| 1101 | 发送过于频繁 |
| 1102 | 手机号格式错误 |

---

### 3.4 手机号登录

**请求信息**
- **Method**: POST
- **URL**: `https://www.trae.cn/passport/web/mobile/login/`
- **描述**: 使用手机号和验证码登录

**查询参数**
与发送验证码接口相同

**请求体 (Form格式)**
```
mix_mode=1&mobile={加密手机号}&code={验证码}&type=3731&fixed_mix_mode=1
```

**响应示例 - 登录成功**
```json
{
  "data": {
    "user_id": "123456789",
    "user_name": "用户名",
    "avatar_url": "https://...",
    "token": "xxx",
    "expire_time": 1777036335
  },
  "message": "success"
}
```

---

### 3.5 论坛SSO登录回调

**请求信息**
- **Method**: GET/POST
- **URL**: `https://forum.trae.cn/session/sso_login`
- **描述**: SSO登录成功后回调论坛，完成登录同步

**查询参数**
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| sso | string | 是 | Base64编码的用户信息 |
| sig | string | 是 | 签名验证 |

---

## 四、验证码验证流程

### 4.1 滑动验证码

当触发风控时，需要通过滑动验证码验证：

**验证码加载**
- **URL**: `https://verify.zijieapi.com/captcha/v2`
- **类型**: 滑动拼图验证码

**验证步骤**
1. 加载验证码图片
2. 用户完成滑动操作
3. 前端计算滑动轨迹
4. 提交验证结果
5. 获取 verify_ticket
6. 携带 ticket 重新发送验证码

---

## 五、Cookie管理

### 5.1 关键Cookie

| Cookie名 | 作用 | 有效期 |
|----------|------|--------|
| ttwid | 用户设备标识 | 长期 |
| passport_csrf_token | CSRF防护 | 60天 |
| sessionid | 会话标识 | 会话期间 |
| __tea_cache_tokens_711126 | 用户唯一标识 | 长期 |

### 5.2 Cookie设置示例
```http
Set-Cookie: ttwid=1%7C...; Path=/; Domain=.trae.cn; Max-Age=31536000; Secure; SameSite=None
Set-Cookie: passport_csrf_token=xxx; Path=/; Domain=trae.cn; Max-Age=5184000; Secure; SameSite=None
```

---

## 六、Flutter实现示例

### 6.1 登录服务类

```dart
import 'package:dio/dio.dart';

class TraeLoginService {
  static const String _baseUrl = 'https://www.trae.cn';
  static const String _apiBaseUrl = 'https://api.trae.cn';
  static const String _aid = '711126';
  
  final Dio _dio = Dio();
  
  /// 检查登录状态
  Future<CheckLoginResult> checkLoginStatus() async {
    final response = await _dio.post(
      '$_apiBaseUrl/cloudide/api/v3/trae/CheckLogin',
      data: {'GetNickNameEditStatus': true},
      options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Referer': 'https://www.trae.cn/',
        },
      ),
    );
    
    return CheckLoginResult.fromJson(response.data['Result']);
  }
  
  /// 发送验证码
  Future<SendCodeResult> sendVerificationCode(String phone) async {
    final encryptedPhone = _encryptPhone(phone);
    
    final response = await _dio.post(
      '$_baseUrl/passport/web/send_code/',
      queryParameters: {
        'passport_jssdk_version': '3.0.11',
        'passport_jssdk_type': 'normal',
        'aid': _aid,
        'language': 'zh',
        'account_sdk_source': 'web',
      },
      data: FormData.fromMap({
        'mix_mode': '1',
        'mobile': encryptedPhone,
        'type': '3731',
        'fixed_mix_mode': '1',
      }),
      options: Options(
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Referer': 'https://www.trae.cn/login',
        },
      ),
    );
    
    return SendCodeResult.fromJson(response.data);
  }
  
  /// 手机号登录
  Future<LoginResult> loginWithPhone(String phone, String code) async {
    final encryptedPhone = _encryptPhone(phone);
    
    final response = await _dio.post(
      '$_baseUrl/passport/web/mobile/login/',
      queryParameters: {
        'passport_jssdk_version': '3.0.11',
        'aid': _aid,
        'language': 'zh',
      },
      data: FormData.fromMap({
        'mix_mode': '1',
        'mobile': encryptedPhone,
        'code': code,
        'type': '3731',
      }),
      options: Options(
        headers: {
          'Referer': 'https://www.trae.cn/login',
        },
      ),
    );
    
    return LoginResult.fromJson(response.data);
  }
  
  /// 加密手机号
  String _encryptPhone(String phone) {
    // 实现手机号加密算法
    // 需要将手机号转换为特定格式
    return phone; // 简化处理
  }
}

/// 登录结果模型
class LoginResult {
  final bool success;
  final String? userId;
  final String? userName;
  final String? avatarUrl;
  final String? errorMessage;
  
  LoginResult({
    required this.success,
    this.userId,
    this.userName,
    this.avatarUrl,
    this.errorMessage,
  });
  
  factory LoginResult.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return LoginResult(
      success: json['message'] == 'success',
      userId: data?['user_id']?.toString(),
      userName: data?['user_name'],
      avatarUrl: data?['avatar_url'],
      errorMessage: data?['description'],
    );
  }
}
```

### 6.2 登录页面使用示例

```dart
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();
  final _loginService = TraeLoginService();
  bool _isLoading = false;
  
  Future<void> _sendCode() async {
    try {
      final result = await _loginService.sendVerificationCode(
        _phoneController.text,
      );
      
      if (result.needCaptcha) {
        // 显示滑动验证码
        _showCaptchaDialog();
      } else if (result.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('验证码已发送')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('发送失败: $e')),
      );
    }
  }
  
  Future<void> _login() async {
    setState(() => _isLoading = true);
    
    try {
      final result = await _loginService.loginWithPhone(
        _phoneController.text,
        _codeController.text,
      );
      
      if (result.success) {
        // 保存登录状态
        await _saveLoginState(result);
        // 跳转到首页
        context.go('/');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result.errorMessage ?? '登录失败')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('登录失败: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }
  
  Future<void> _saveLoginState(LoginResult result) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userId', result.userId ?? '');
    await prefs.setString('userName', result.userName ?? '');
    await prefs.setString('avatarUrl', result.avatarUrl ?? '');
  }
}
```

---

## 七、注意事项

### 7.1 安全提示
1. **签名验证**: 所有请求都需要正确的签名参数
2. **防爬虫**: 包含 a_bogus 等防爬虫参数
3. **频率限制**: 验证码发送有频率限制
4. **设备绑定**: Token与设备标识绑定

### 7.2 开发建议
1. 使用 WebView 加载官方登录页面是最稳定的方案
2. 如需原生实现，需要处理滑动验证码等风控机制
3. 妥善保存 Cookie 和 Token
4. 定期刷新登录状态

### 7.3 替代方案
考虑到登录流程的复杂性，推荐以下替代方案：

1. **WebView登录** (推荐)
   - 使用 WebView 加载 `https://www.trae.cn/login`
   - 监听登录成功后的跳转
   - 提取 Cookie 同步到原生端

2. **Chrome Custom Tabs** (Android)
   - 使用系统浏览器打开登录页
   - 通过 Deep Link 回调登录结果

---

## 八、更新记录

| 日期 | 版本 | 更新内容 |
|------|------|----------|
| 2026-04-24 | 1.0 | 初始版本，完成登录API逆向分析 |

---

*本文档仅供技术学习和研究使用，请遵守相关法律法规和网站服务条款。*
