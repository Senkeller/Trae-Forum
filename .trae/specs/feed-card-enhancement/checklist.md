# Feed 卡片增强功能验收清单

## Phase 1: 精选评论展示

### 数据模型
- [x] `FeedItem` 类包含 `topComment` 字段
- [x] `TopComment` 数据类正确定义
- [x] Freezed 代码生成成功
- [x] `TopicAdapter` 正确映射精选评论数据

### 组件实现
- [x] `FeaturedComment` 组件存在且可渲染
- [x] 高赞标签显示正确（绿色背景、白色文字）
- [x] 评论者用户名显示为品牌主色
- [x] 内容摘要正确截断
- [x] 无评论时不渲染组件

### 集成验证
- [x] FeedCard 正确展示精选评论区域
- [x] 点击精选评论跳转到详情页
- [x] 详情页自动滚动到对应评论位置
- [x] 首页 Feed 列表正确传递数据

## Phase 2: 快速输入栏

