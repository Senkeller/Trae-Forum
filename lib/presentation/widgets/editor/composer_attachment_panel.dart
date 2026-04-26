import 'dart:io';
import 'package:flutter/material.dart';
import '../common/cached_image.dart';

/// 附件项数据类
///
/// 表示一个附件的信息
class AttachmentItem {
  /// 附件唯一标识
  final String id;

  /// 附件类型
  final AttachmentType type;

  /// 附件名称
  final String name;

  /// 附件大小（字节）
  final int? size;

  /// 本地文件路径（如果是本地文件）
  final String? localPath;

  /// 远程 URL（如果已上传）
  final String? remoteUrl;

  /// 上传进度（0.0 - 1.0）
  final double uploadProgress;

  /// 上传状态
  final UploadStatus uploadStatus;

  /// 错误信息（如果上传失败）
  final String? errorMessage;

  /// 构造函数
  ///
  /// [id] 附件唯一标识（必填）
  /// [type] 附件类型（必填）
  /// [name] 附件名称（必填）
  /// [size] 附件大小
  /// [localPath] 本地文件路径
  /// [remoteUrl] 远程 URL
  /// [uploadProgress] 上传进度
  /// [uploadStatus] 上传状态
  /// [errorMessage] 错误信息
  const AttachmentItem({
    required this.id,
    required this.type,
    required this.name,
    this.size,
    this.localPath,
    this.remoteUrl,
    this.uploadProgress = 0.0,
    this.uploadStatus = UploadStatus.pending,
    this.errorMessage,
  });

  /// 创建图片附件
  factory AttachmentItem.image({
    required String id,
    required String name,
    int? size,
    String? localPath,
    String? remoteUrl,
    double uploadProgress = 0.0,
    UploadStatus uploadStatus = UploadStatus.pending,
    String? errorMessage,
  }) {
    return AttachmentItem(
      id: id,
      type: AttachmentType.image,
      name: name,
      size: size,
      localPath: localPath,
      remoteUrl: remoteUrl,
      uploadProgress: uploadProgress,
      uploadStatus: uploadStatus,
      errorMessage: errorMessage,
    );
  }

  /// 创建文件附件
  factory AttachmentItem.file({
    required String id,
    required String name,
    int? size,
    String? localPath,
    String? remoteUrl,
    double uploadProgress = 0.0,
    UploadStatus uploadStatus = UploadStatus.pending,
    String? errorMessage,
  }) {
    return AttachmentItem(
      id: id,
      type: AttachmentType.file,
      name: name,
      size: size,
      localPath: localPath,
      remoteUrl: remoteUrl,
      uploadProgress: uploadProgress,
      uploadStatus: uploadStatus,
      errorMessage: errorMessage,
    );
  }

  /// 创建副本并修改属性
  AttachmentItem copyWith({
    String? id,
    AttachmentType? type,
    String? name,
    int? size,
    String? localPath,
    String? remoteUrl,
    double? uploadProgress,
    UploadStatus? uploadStatus,
    String? errorMessage,
  }) {
    return AttachmentItem(
      id: id ?? this.id,
      type: type ?? this.type,
      name: name ?? this.name,
      size: size ?? this.size,
      localPath: localPath ?? this.localPath,
      remoteUrl: remoteUrl ?? this.remoteUrl,
      uploadProgress: uploadProgress ?? this.uploadProgress,
      uploadStatus: uploadStatus ?? this.uploadStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  /// 获取显示用的文件大小字符串
  String get sizeString {
    if (size == null) return '';
    if (size! < 1024) return '${size}B';
    if (size! < 1024 * 1024) return '${(size! / 1024).toStringAsFixed(1)}KB';
    return '${(size! / (1024 * 1024)).toStringAsFixed(1)}MB';
  }

  /// 获取文件图标
  IconData get icon {
    switch (type) {
      case AttachmentType.image:
        return Icons.image;
      case AttachmentType.file:
        return _getFileIcon(name);
    }
  }

  /// 根据文件名获取图标
  IconData _getFileIcon(String filename) {
    final ext = filename.split('.').last.toLowerCase();
    switch (ext) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'doc':
      case 'docx':
        return Icons.description;
      case 'xls':
      case 'xlsx':
        return Icons.table_chart;
      case 'ppt':
      case 'pptx':
        return Icons.slideshow;
      case 'zip':
      case 'rar':
      case '7z':
        return Icons.folder_zip;
      case 'mp3':
      case 'wav':
      case 'flac':
        return Icons.audio_file;
      case 'mp4':
      case 'avi':
      case 'mov':
        return Icons.video_file;
      case 'txt':
        return Icons.text_snippet;
      default:
        return Icons.insert_drive_file;
    }
  }
}

/// 附件类型枚举
enum AttachmentType {
  /// 图片
  image,

  /// 文件
  file,
}

/// 上传状态枚举
enum UploadStatus {
  /// 等待上传
  pending,

  /// 上传中
  uploading,

  /// 上传成功
  success,

  /// 上传失败
  failed,
}

/// 附件面板组件
///
/// 用于管理和展示编辑器附件，支持：
/// - 图片附件预览
/// - 文件附件列表
/// - 上传进度显示
/// - 删除附件
///
/// 使用示例：
/// ```dart
/// ComposerAttachmentPanel(
///   attachments: attachments,
///   onAttachmentAdded: (item) => print('添加: ${item.name}'),
///   onAttachmentRemoved: (item) => print('删除: ${item.name}'),
/// )
/// ```
class ComposerAttachmentPanel extends StatelessWidget {
  /// 附件列表
  final List<AttachmentItem> attachments;

  /// 附件添加回调
  final Function(AttachmentItem item)? onAttachmentAdded;

  /// 附件删除回调
  final Function(AttachmentItem item)? onAttachmentRemoved;

  /// 附件点击回调
  final Function(AttachmentItem item)? onAttachmentTap;

  /// 最大附件数量
  final int maxAttachments;

  /// 是否显示添加按钮
  final bool showAddButton;

  /// 添加按钮点击回调
  final VoidCallback? onAddTap;

  /// 面板高度
  final double? height;

  /// 背景颜色
  final Color? backgroundColor;

  /// 构造函数
  ///
  /// [attachments] 附件列表，默认空列表
  /// [onAttachmentAdded] 附件添加回调
  /// [onAttachmentRemoved] 附件删除回调
  /// [onAttachmentTap] 附件点击回调
  /// [maxAttachments] 最大附件数量，默认 9
  /// [showAddButton] 是否显示添加按钮，默认 true
  /// [onAddTap] 添加按钮点击回调
  /// [height] 面板高度
  /// [backgroundColor] 背景颜色
  const ComposerAttachmentPanel({
    super.key,
    this.attachments = const [],
    this.onAttachmentAdded,
    this.onAttachmentRemoved,
    this.onAttachmentTap,
    this.maxAttachments = 9,
    this.showAddButton = true,
    this.onAddTap,
    this.height,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (attachments.isEmpty && !showAddButton) {
      return const SizedBox.shrink();
    }

    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: backgroundColor ?? colorScheme.surface,
        border: Border(
          top: BorderSide(
            color: colorScheme.outline.withOpacity(0.2),
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 标题栏
          Row(
            children: [
              Icon(
                Icons.attach_file,
                size: 18,
                color: colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 8),
              Text(
                '附件',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              Text(
                '${attachments.length}/$maxAttachments',
                style: TextStyle(
                  fontSize: 12,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),

          if (attachments.isNotEmpty) ...[
            const SizedBox(height: 12),
            // 附件列表
            _buildAttachmentList(context),
          ],

          // 添加按钮
          if (showAddButton && attachments.length < maxAttachments) ...[
            const SizedBox(height: 12),
            _buildAddButton(context),
          ],
        ],
      ),
    );
  }

  /// 构建附件列表
  Widget _buildAttachmentList(BuildContext context) {
    // 分离图片和文件
    final images = attachments.where((a) => a.type == AttachmentType.image).toList();
    final files = attachments.where((a) => a.type == AttachmentType.file).toList();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 图片网格
        if (images.isNotEmpty) ...[
          _buildImageGrid(context, images),
          if (files.isNotEmpty) const SizedBox(height: 12),
        ],
        // 文件列表
        if (files.isNotEmpty)
          _buildFileList(context, files),
      ],
    );
  }

  /// 构建图片网格
  Widget _buildImageGrid(BuildContext context, List<AttachmentItem> images) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: images.length,
      itemBuilder: (context, index) {
        return _ImageAttachmentItem(
          attachment: images[index],
          onRemove: () => onAttachmentRemoved?.call(images[index]),
          onTap: () => onAttachmentTap?.call(images[index]),
        );
      },
    );
  }

  /// 构建文件列表
  Widget _buildFileList(BuildContext context, List<AttachmentItem> files) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: files.map((file) {
        return _FileAttachmentItem(
          attachment: file,
          onRemove: () => onAttachmentRemoved?.call(file),
          onTap: () => onAttachmentTap?.call(file),
        );
      }).toList(),
    );
  }

  /// 构建添加按钮
  Widget _buildAddButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onAddTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: colorScheme.outline.withOpacity(0.3),
            style: BorderStyle.solid,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              size: 20,
              color: colorScheme.primary,
            ),
            const SizedBox(width: 8),
            Text(
              '添加附件',
              style: TextStyle(
                fontSize: 14,
                color: colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 图片附件项
class _ImageAttachmentItem extends StatelessWidget {
  final AttachmentItem attachment;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const _ImageAttachmentItem({
    required this.attachment,
    this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          // 图片
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              decoration: BoxDecoration(
                color: colorScheme.surfaceVariant,
              ),
              child: _buildImage(),
            ),
          ),

          // 删除按钮
          Positioned(
            top: 4,
            right: 4,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close,
                  size: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          // 上传进度/状态
          if (attachment.uploadStatus != UploadStatus.success)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: _buildStatusOverlay(context),
            ),
        ],
      ),
    );
  }

  /// 构建图片
  Widget _buildImage() {
    if (attachment.localPath != null) {
      return Image.file(
        File(attachment.localPath!),
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    } else if (attachment.remoteUrl != null) {
      return CachedImage(
        imageUrl: attachment.remoteUrl!,
        fit: BoxFit.cover,
      );
    }
    return const Icon(Icons.image);
  }

  /// 构建状态覆盖层
  Widget _buildStatusOverlay(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (attachment.uploadStatus) {
      case UploadStatus.pending:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: const Icon(
            Icons.schedule,
            size: 16,
            color: Colors.white,
          ),
        );
      case UploadStatus.uploading:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: LinearProgressIndicator(
            value: attachment.uploadProgress,
            backgroundColor: Colors.white.withOpacity(0.3),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            minHeight: 3,
          ),
        );
      case UploadStatus.failed:
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: colorScheme.error.withOpacity(0.8),
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
          ),
          child: const Icon(
            Icons.error_outline,
            size: 16,
            color: Colors.white,
          ),
        );
      case UploadStatus.success:
        return const SizedBox.shrink();
    }
  }
}

/// 文件附件项
class _FileAttachmentItem extends StatelessWidget {
  final AttachmentItem attachment;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;

  const _FileAttachmentItem({
    required this.attachment,
    this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.surfaceVariant.withOpacity(0.3),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: colorScheme.outline.withOpacity(0.2),
          ),
        ),
        child: Row(
          children: [
            // 文件图标
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                attachment.icon,
                size: 24,
                color: colorScheme.primary,
              ),
            ),
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
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  if (attachment.uploadStatus == UploadStatus.uploading)
                    _buildProgressIndicator(context)
                  else
                    Text(
                      '${attachment.sizeString} • ${_getStatusText()}',
                      style: TextStyle(
                        fontSize: 12,
                        color: _getStatusColor(colorScheme),
                      ),
                    ),
                ],
              ),
            ),

            // 删除按钮
            GestureDetector(
              onTap: onRemove,
              child: Container(
                padding: const EdgeInsets.all(4),
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 构建进度指示器
  Widget _buildProgressIndicator(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: LinearProgressIndicator(
            value: attachment.uploadProgress,
            backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
            minHeight: 3,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          '${(attachment.uploadProgress * 100).toInt()}%',
          style: TextStyle(
            fontSize: 11,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// 获取状态文字
  String _getStatusText() {
    switch (attachment.uploadStatus) {
      case UploadStatus.pending:
        return '等待上传';
      case UploadStatus.uploading:
        return '上传中';
      case UploadStatus.success:
        return '已上传';
      case UploadStatus.failed:
        return '上传失败';
    }
  }

  /// 获取状态颜色
  Color _getStatusColor(ColorScheme colorScheme) {
    switch (attachment.uploadStatus) {
      case UploadStatus.pending:
        return colorScheme.onSurfaceVariant;
      case UploadStatus.uploading:
        return colorScheme.primary;
      case UploadStatus.success:
        return Colors.green;
      case UploadStatus.failed:
        return colorScheme.error;
    }
  }
}

/// 附件选择器弹窗
///
/// 用于选择附件类型（图片、文件等）
class AttachmentPickerDialog extends StatelessWidget {
  /// 选择图片回调
  final VoidCallback? onImagePick;

  /// 选择文件回调
  final VoidCallback? onFilePick;

  /// 拍照回调
  final VoidCallback? onCameraPick;

  /// 构造函数
  const AttachmentPickerDialog({
    super.key,
    this.onImagePick,
    this.onFilePick,
    this.onCameraPick,
  });

  /// 显示弹窗
  static Future<void> show({
    required BuildContext context,
    VoidCallback? onImagePick,
    VoidCallback? onFilePick,
    VoidCallback? onCameraPick,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => AttachmentPickerDialog(
        onImagePick: onImagePick,
        onFilePick: onFilePick,
        onCameraPick: onCameraPick,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 拖动条
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outline.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 16),

            // 标题
            Text(
              '添加附件',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),

            const SizedBox(height: 16),

            // 选项列表
            if (onCameraPick != null)
              _buildOption(
                context,
                icon: Icons.camera_alt,
                label: '拍照',
                onTap: () {
                  Navigator.pop(context);
                  onCameraPick!();
                },
              ),

            if (onImagePick != null)
              _buildOption(
                context,
                icon: Icons.photo_library,
                label: '从相册选择',
                onTap: () {
                  Navigator.pop(context);
                  onImagePick!();
                },
              ),

            if (onFilePick != null)
              _buildOption(
                context,
                icon: Icons.insert_drive_file,
                label: '选择文件',
                onTap: () {
                  Navigator.pop(context);
                  onFilePick!();
                },
              ),

            const SizedBox(height: 16),

            // 取消按钮
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceVariant.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    '取消',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: colorScheme.onSurface,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  /// 构建选项
  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                size: 24,
                color: colorScheme.primary,
              ),
            ),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: colorScheme.onSurface,
              ),
            ),
            const Spacer(),
            Icon(
              Icons.chevron_right,
              color: colorScheme.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
