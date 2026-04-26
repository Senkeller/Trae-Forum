import 'dart:io';
import 'package:flutter/material.dart';
import 'composer_attachment_panel.dart';
import '../../../core/services/image_upload_service.dart';

/// 附件上传管理器
///
/// 管理附件的上传状态，支持：
/// - 批量上传管理
/// - 上传失败自动重试
/// - 定位到具体失败素材
/// - 上传进度追踪
///
/// 使用示例：
/// ```dart
/// AttachmentUploadManager(
///   attachments: attachments,
///   onUploadComplete: (results) => print('上传完成'),
///   child: ComposerAttachmentPanel(...),
/// )
/// ```
class AttachmentUploadManager extends StatefulWidget {
  /// 附件列表
  final List<AttachmentItem> attachments;

  /// 上传完成回调
  final Function(List<ImageUploadResult> results)? onUploadComplete;

  /// 单个附件上传完成回调
  final Function(AttachmentItem attachment, ImageUploadResult result)? onItemUploadComplete;

  /// 上传进度回调
  final Function(AttachmentItem attachment, double progress)? onUploadProgress;

  /// 图片上传接口地址
  final String? uploadUrl;

  /// 图片上传字段名
  final String uploadFieldName;

  /// 图片上传额外参数
  final Map<String, dynamic>? uploadExtraData;

  /// 最大重试次数
  final int maxRetries;

  /// 是否自动开始上传
  final bool autoStart;

  /// 子组件
  final Widget child;

  /// 构造函数
  const AttachmentUploadManager({
    super.key,
    required this.attachments,
    required this.child,
    this.onUploadComplete,
    this.onItemUploadComplete,
    this.onUploadProgress,
    this.uploadUrl,
    this.uploadFieldName = 'file',
    this.uploadExtraData,
    this.maxRetries = 3,
    this.autoStart = false,
  });

  @override
  State<AttachmentUploadManager> createState() => _AttachmentUploadManagerState();
}

class _AttachmentUploadManagerState extends State<AttachmentUploadManager> {
  final ImageUploadService _uploadService = ImageUploadService();
  final Map<String, int> _retryCounts = {};
  final Map<String, double> _uploadProgress = {};
  final List<ImageUploadResult> _uploadResults = [];

  @override
  void initState() {
    super.initState();
    if (widget.autoStart) {
      _startUploadAll();
    }
  }

  @override
  void didUpdateWidget(AttachmentUploadManager oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 如果有新添加的附件且设置了自动上传，则开始上传
    if (widget.autoStart) {
      final newAttachments = widget.attachments.where(
        (a) => a.uploadStatus == UploadStatus.pending && a.localPath != null,
      );
      if (newAttachments.isNotEmpty) {
        for (final attachment in newAttachments) {
          _uploadAttachment(attachment);
        }
      }
    }
  }

  /// 开始上传所有待上传的附件
  Future<void> _startUploadAll() async {
    final pendingAttachments = widget.attachments.where(
      (a) => a.uploadStatus == UploadStatus.pending && a.localPath != null,
    );

    for (final attachment in pendingAttachments) {
      await _uploadAttachment(attachment);
    }

    widget.onUploadComplete?.call(List.unmodifiable(_uploadResults));
  }

  /// 上传单个附件
  Future<ImageUploadResult> _uploadAttachment(AttachmentItem attachment) async {
    if (attachment.localPath == null) {
      final result = ImageUploadResult.failure('没有本地文件路径');
      _uploadResults.add(result);
      widget.onItemUploadComplete?.call(attachment, result);
      return result;
    }

    // 更新状态为上传中
    _updateAttachmentStatus(attachment.id, UploadStatus.uploading);

    final result = await _uploadService.uploadImage(
      filePath: attachment.localPath!,
      uploadUrl: widget.uploadUrl ?? '/upload/image',
      fieldName: widget.uploadFieldName,
      additionalData: widget.uploadExtraData,
      onProgress: (progress) {
        setState(() {
          _uploadProgress[attachment.id] = progress;
        });
        widget.onUploadProgress?.call(attachment, progress);
      },
    );

    _uploadResults.add(result);

    if (result.success) {
      _updateAttachmentStatus(
        attachment.id,
        UploadStatus.success,
        remoteUrl: result.imageUrl,
      );
    } else {
      _updateAttachmentStatus(
        attachment.id,
        UploadStatus.failed,
        errorMessage: result.errorMessage,
      );
    }

    widget.onItemUploadComplete?.call(attachment, result);
    return result;
  }

  /// 重试上传失败的附件
  Future<ImageUploadResult> retryUpload(AttachmentItem attachment) async {
    final currentRetryCount = _retryCounts[attachment.id] ?? 0;
    
    if (currentRetryCount >= widget.maxRetries) {
      final result = ImageUploadResult.failure('已达到最大重试次数');
      widget.onItemUploadComplete?.call(attachment, result);
      return result;
    }

    _retryCounts[attachment.id] = currentRetryCount + 1;
    
    // 重置状态
    _updateAttachmentStatus(attachment.id, UploadStatus.pending);
    
    return await _uploadAttachment(attachment);
  }

  /// 更新附件状态
  void _updateAttachmentStatus(
    String attachmentId,
    UploadStatus status, {
    String? remoteUrl,
    String? errorMessage,
  }) {
    final index = widget.attachments.indexWhere((a) => a.id == attachmentId);
    if (index == -1) return;

    setState(() {
      widget.attachments[index] = widget.attachments[index].copyWith(
        uploadStatus: status,
        remoteUrl: remoteUrl,
        errorMessage: errorMessage,
        uploadProgress: status == UploadStatus.success ? 1.0 : _uploadProgress[attachmentId] ?? 0,
      );
    });
  }

  /// 获取失败的附件列表
  List<AttachmentItem> get failedAttachments {
    return widget.attachments
        .where((a) => a.uploadStatus == UploadStatus.failed)
        .toList();
  }

  /// 获取上传中的附件列表
  List<AttachmentItem> get uploadingAttachments {
    return widget.attachments
        .where((a) => a.uploadStatus == UploadStatus.uploading)
        .toList();
  }

  /// 是否所有附件都上传完成
  bool get isAllComplete {
    return widget.attachments.every(
      (a) => a.uploadStatus == UploadStatus.success || a.uploadStatus == UploadStatus.failed,
    );
  }

  /// 是否所有附件都上传成功
  bool get isAllSuccess {
    return widget.attachments.every((a) => a.uploadStatus == UploadStatus.success);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// 带重试功能的附件项组件
///
/// 显示附件信息和上传状态，支持点击重试
class RetryableAttachmentItem extends StatelessWidget {
  /// 附件数据
  final AttachmentItem attachment;

  /// 删除回调
  final VoidCallback? onRemove;

  /// 点击回调（通常用于重试）
  final VoidCallback? onTap;

  /// 重试回调
  final VoidCallback? onRetry;

  /// 是否显示重试按钮
  final bool showRetryButton;

  /// 构造函数
  const RetryableAttachmentItem({
    super.key,
    required this.attachment,
    this.onRemove,
    this.onTap,
    this.onRetry,
    this.showRetryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isFailed = attachment.uploadStatus == UploadStatus.failed;
    final isUploading = attachment.uploadStatus == UploadStatus.uploading;

    return GestureDetector(
      onTap: isFailed ? (onRetry ?? onTap) : onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _getBackgroundColor(colorScheme),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isFailed
                ? colorScheme.error.withOpacity(0.5)
                : colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            // 文件图标或图片缩略图
            _buildThumbnail(context),
            const SizedBox(width: 12),

            // 文件信息
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    attachment.name,
                    style: TextStyle(
                      fontSize: 14,
                      color: isFailed ? colorScheme.error : colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  _buildStatusText(context),
                ],
              ),
            ),

            // 操作按钮
            if (isFailed && showRetryButton)
              _buildRetryButton(context)
            else if (isUploading)
              _buildProgressIndicator(context)
            else
              _buildRemoveButton(context),
          ],
        ),
      ),
    );
  }

  /// 获取背景颜色
  Color _getBackgroundColor(ColorScheme colorScheme) {
    switch (attachment.uploadStatus) {
      case UploadStatus.failed:
        return colorScheme.errorContainer.withOpacity(0.3);
      case UploadStatus.uploading:
        return colorScheme.primaryContainer.withOpacity(0.2);
      case UploadStatus.success:
        return colorScheme.surfaceVariant.withOpacity(0.3);
      case UploadStatus.pending:
        return colorScheme.surfaceVariant.withOpacity(0.3);
    }
  }

  /// 构建缩略图
  Widget _buildThumbnail(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (attachment.type == AttachmentType.image && attachment.localPath != null) {
      return Container(
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
            image: FileImage(File(attachment.localPath!)),
            fit: BoxFit.cover,
          ),
        ),
      );
    }

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: colorScheme.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        attachment.icon,
        size: 24,
        color: attachment.uploadStatus == UploadStatus.failed
            ? colorScheme.error
            : colorScheme.primary,
      ),
    );
  }

  /// 构建状态文本
  Widget _buildStatusText(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (attachment.uploadStatus) {
      case UploadStatus.pending:
        return Text(
          '${attachment.sizeString} • 等待上传',
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.onSurfaceVariant,
          ),
        );
      case UploadStatus.uploading:
        return Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: attachment.uploadProgress,
                backgroundColor: colorScheme.surfaceVariant,
                minHeight: 3,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              '${(attachment.uploadProgress * 100).toInt()}%',
              style: TextStyle(
                fontSize: 11,
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        );
      case UploadStatus.success:
        return Text(
          '${attachment.sizeString} • 上传成功',
          style: TextStyle(
            fontSize: 12,
            color: Colors.green,
          ),
        );
      case UploadStatus.failed:
        return Text(
          '${attachment.sizeString} • 上传失败${attachment.errorMessage != null ? ': ${attachment.errorMessage}' : ''}',
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.error,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        );
    }
  }

  /// 构建重试按钮
  Widget _buildRetryButton(BuildContext context) {
    return GestureDetector(
      onTap: onRetry,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '重试',
          style: TextStyle(
            fontSize: 12,
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  /// 构建进度指示器
  Widget _buildProgressIndicator(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        value: attachment.uploadProgress > 0 ? attachment.uploadProgress : null,
      ),
    );
  }

  /// 构建删除按钮
  Widget _buildRemoveButton(BuildContext context) {
    return GestureDetector(
      onTap: onRemove,
      child: Container(
        padding: const EdgeInsets.all(4),
        child: Icon(
          Icons.close,
          size: 18,
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}
