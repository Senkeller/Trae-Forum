import 'package:flutter/material.dart';
import '../../widgets/editor/quill_composer_editor.dart';

/// 编辑器演示页面
///
/// 展示 flutter_quill 编辑器的完整功能
class EditorDemoPage extends StatefulWidget {
  const EditorDemoPage({super.key});

  @override
  State<EditorDemoPage> createState() => _EditorDemoPageState();
}

class _EditorDemoPageState extends State<EditorDemoPage> {
  String _currentText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('编辑器演示'),
        actions: [
          TextButton(
            onPressed: () {
              _showUsageDialog();
            },
            child: const Text('使用说明'),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: QuillComposerEditor(
                hintText: '分享你的想法...\n支持富文本编辑',
                onTextChanged: (text) {
                  setState(() {
                    _currentText = text;
                  });
                  debugPrint('文本变化: ${text.length} 字符');
                },
                minHeight: 300,
              ),
            ),
          ),
          // 显示当前 Markdown 内容
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              border: Border(
                top: BorderSide(color: Colors.grey[300]!),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Markdown 输出 (${_currentText.length} 字符):',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: Text(
                    _currentText.isEmpty ? '（空）' : _currentText,
                    style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ],
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
              Text('• 支持富文本编辑'),
              Text('• 支持 Markdown 语法'),
              Text('• 实时转换为 Markdown'),
              SizedBox(height: 16),
              Text('📝 格式支持：', style: TextStyle(fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              Text('• 标题（H1-H3）'),
              Text('• 加粗、斜体、删除线'),
              Text('• 无序列表、有序列表、任务列表'),
              Text('• 引用块、代码块'),
              Text('• 链接、分割线'),
              Text('• 文本对齐、缩进'),
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
}
