import 'package:flutter/material.dart';
import '../../widgets/editor/composer_editor.dart';
import '../../widgets/editor/composer_attachment_panel.dart';
import '../../../core/services/emoji_cache_service.dart';

/// 编辑器演示页面
///
/// 展示 Markdown 编辑器的完整功能，包括：
/// - 图片上传与 Markdown 插入
/// - 表情包选择
/// - 最近使用记录
/// - 上传失败重试
class EditorDemoPage extends StatefulWidget {
  const EditorDemoPage({super.key});

  @override
  State<EditorDemoPage> createState() => _EditorDemoPageState();
}

class _EditorDemoPageState extends State<EditorDemoPage> {
  final List<AttachmentItem> _attachments = [];
  final EmojiCacheService _emojiCache = EmojiCacheService();

  // 示例表情包 URL 列表
  final List<String> _stickerUrls = [
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/325/grinning-face_1f600.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/325/rolling-on-the-floor-laughing_1f923.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/325/smiling-face-with-heart-eyes_1f60d.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/325/thumbs-up_1f44d.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/325/fire_1f525.png',
    'https://emojipedia-us.s3.dualstack.us-west-1.amazonaws.com/thumbs/120/apple/325/party-popper_1f389.png',
  ];

  @override
  void initState() {
    super.initState();
    _initEmojiCache();
  }

  Future<void> _initEmojiCache() async {
    await _emojiCache.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑器演示'),
        actions: [
          TextButton(
            onPressed: () {
              // 显示使用说明
              _showUsageDialog();
            },
            child: const Text('使用说明'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ComposerEditor(
              title: '发布新内容',
              hintText: '分享你的想法...\n支持 Markdown 语法',
              enableEmojiPicker: true,
              stickerUrls: _stickerUrls,
              showAttachmentPanel: true,
              enableSplitView: true,
              imageUploadUrl: '/api/upload/image',
              onTextChanged: (text) {
                debugPrint('文本变化: ${text.length} 字符');
              },
              onSubmit: (text, attachments) {
                debugPrint('提交内容: $text');
                debugPrint('附件数量: ${attachments.length}');
                _showSubmitSuccessDialog(text, attachments);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showFeatureDemo();
        },
        label: const Text('功能演示'),
        icon: const Icon(Icons.lightbulb_outline),
      ),
    );
  }

  /// 显示使用说明对话框
  void _showUsageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('编辑器功能说明'),
        content: const SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('✨ 核心功能：', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• 支持 Markdown 语法编辑'),
              Text('• 实时预览模式'),
              Text('• 分屏编辑/预览'),
              SizedBox(height: 16),
              Text('📷 图片功能：', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• 点击工具栏图片按钮插入 Markdown'),
              Text('• 支持图片上传到服务器'),
              Text('• 上传成功后自动插入 ![alt](url)'),
              Text('• 上传失败可重试'),
              SizedBox(height: 16),
              Text('😊 表情包功能：', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• 点击工具栏表情按钮打开选择器'),
              Text('• 支持 Unicode 表情'),
              Text('• 支持自定义表情包'),
              Text('• 自动记录最近使用'),
              SizedBox(height: 16),
              Text('📎 附件管理：', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• 显示上传进度'),
              Text('• 上传失败高亮显示'),
              Text('• 点击失败项可重试'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('知道了'),
          ),
        ],
      ),
    );
  }

  /// 显示功能演示
  void _showFeatureDemo() {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text('插入图片 Markdown'),
              subtitle: const Text('在光标处插入 ![alt](url)'),
              onTap: () {
                Navigator.pop(context);
                // 这里可以通过 GlobalKey 访问编辑器状态
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('请使用工具栏的图片按钮')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.emoji_emotions),
              title: const Text('打开表情包选择器'),
              subtitle: const Text('查看最近使用记录'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('请使用工具栏的表情按钮')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.storage),
              title: const Text('查看本地缓存'),
              subtitle: const Text('最近使用的表情和表情包'),
              onTap: () {
                Navigator.pop(context);
                _showCacheInfo();
              },
            ),
            ListTile(
              leading: const Icon(Icons.clear_all),
              title: const Text('清空缓存'),
              subtitle: const Text('清除所有最近使用记录'),
              onTap: () {
                Navigator.pop(context);
                _emojiCache.clearAllCache();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('缓存已清空')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// 显示缓存信息
  void _showCacheInfo() {
    final recentEmojis = _emojiCache.getRecentEmojis();
    final recentStickers = _emojiCache.getRecentStickerEmojis();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('本地缓存信息'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('最近使用表情 (${recentEmojis.length})：'),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: recentEmojis
                    .take(10)
                    .map((e) => Text(e, style: const TextStyle(fontSize: 24)))
                    .toList(),
              ),
              const SizedBox(height: 16),
              Text('最近使用表情包 (${recentStickers.length})：'),
              const SizedBox(height: 8),
              ...recentStickers.take(3).map((url) => Text(
                    url.length > 50 ? '${url.substring(0, 50)}...' : url,
                    style: const TextStyle(fontSize: 12),
                  )),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('关闭'),
          ),
        ],
      ),
    );
  }

  /// 显示提交成功对话框
  void _showSubmitSuccessDialog(String text, List<AttachmentItem> attachments) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提交成功'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('内容预览：', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  text.length > 200 ? '${text.substring(0, 200)}...' : text,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 16),
              Text('附件数量: ${attachments.length}'),
              if (attachments.isNotEmpty) ...[
                const SizedBox(height: 8),
                ...attachments.map((a) => Text(
                      '• ${a.name} (${a.uploadStatus.name})',
                      style: const TextStyle(fontSize: 12),
                    )),
              ],
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
