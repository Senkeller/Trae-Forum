import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as html_parser;
import 'package:url_launcher/url_launcher.dart';

import '../../../config/constants.dart';
import '../../../core/utils/discourse_image_url_resolver.dart';
import '../../pages/common/image_preview_page.dart';
import '../common/cached_image.dart';

enum TopicContentBlockType {
  paragraph,
  heading,
  image,
  imageGroup,
  quote,
  code,
  list,
  link,
  table,
}

class TopicContentBlock {
  final TopicContentBlockType type;
  final String text;
  final int headingLevel;
  final List<String> images;
  final List<String> listItems;
  final List<String> tableHeaders;
  final List<List<String>> tableRows;
  final bool ordered;
  final String? href;

  const TopicContentBlock._({
    required this.type,
    this.text = '',
    this.headingLevel = 1,
    this.images = const [],
    this.listItems = const [],
    this.tableHeaders = const [],
    this.tableRows = const [],
    this.ordered = false,
    this.href,
  });

  const TopicContentBlock.paragraph(String text)
      : this._(type: TopicContentBlockType.paragraph, text: text);

  const TopicContentBlock.heading(String text, int level)
      : this._(
          type: TopicContentBlockType.heading,
          text: text,
          headingLevel: level,
        );

  TopicContentBlock.image(String image)
      : this._(type: TopicContentBlockType.image, images: [image]);

  const TopicContentBlock.imageGroup(List<String> images)
      : this._(type: TopicContentBlockType.imageGroup, images: images);

  const TopicContentBlock.quote(String text)
      : this._(type: TopicContentBlockType.quote, text: text);

  const TopicContentBlock.code(String text)
      : this._(type: TopicContentBlockType.code, text: text);

  const TopicContentBlock.list(List<String> items, {required bool ordered})
      : this._(
          type: TopicContentBlockType.list,
          listItems: items,
          ordered: ordered,
        );

  const TopicContentBlock.link({required String title, required String href})
      : this._(
          type: TopicContentBlockType.link,
          text: title,
          href: href,
        );

  const TopicContentBlock.table({
    required List<String> headers,
    required List<List<String>> rows,
  }) : this._(
          type: TopicContentBlockType.table,
          tableHeaders: headers,
          tableRows: rows,
        );
}

class TopicCookedParser {
  static final RegExp _multiSpaceRegex = RegExp(r'\s+');

  static List<TopicContentBlock> parse(String cookedHtml) {
    final raw = cookedHtml.trim();
    if (raw.isEmpty) {
      return const [];
    }

    final fragment = html_parser.parseFragment(raw);
    final blocks = <TopicContentBlock>[];

    for (final node in fragment.nodes) {
      _parseNode(node, blocks);
    }

    return _mergeAdjacentImageBlocks(
      blocks.where(_isValidBlock).toList(),
    );
  }

  static List<String> extractImages(String cookedHtml) {
    final raw = cookedHtml.trim();
    if (raw.isEmpty) {
      return const [];
    }

    final fragment = html_parser.parseFragment(raw);
    final images = <String>[];
    for (final element in fragment.querySelectorAll('img')) {
      final src = _extractImageUrl(element);
      if (src != null && !images.contains(src)) {
        images.add(src);
      }
    }
    return images;
  }

  static void _parseNode(dom.Node node, List<TopicContentBlock> blocks) {
    if (node is dom.Text) {
      final text = _normalizeText(node.text);
      if (text.isNotEmpty) {
        blocks.add(TopicContentBlock.paragraph(text));
      }
      return;
    }

    if (node is! dom.Element) {
      return;
    }

    final tag = (node.localName ?? '').toLowerCase();
    switch (tag) {
      case 'h1':
      case 'h2':
      case 'h3':
      case 'h4':
      case 'h5':
      case 'h6':
        final text = _normalizeText(node.text);
        if (text.isNotEmpty) {
          final level = int.tryParse(tag.substring(1)) ?? 1;
          blocks.add(TopicContentBlock.heading(text, level));
        }
        break;
      case 'blockquote':
        final text = _normalizeText(node.text);
        if (text.isNotEmpty) {
          blocks.add(TopicContentBlock.quote(text));
        }
        break;
      case 'pre':
        final codeElement = node.querySelector('code');
        final code = (codeElement?.text ?? node.text).trimRight();
        if (code.trim().isNotEmpty) {
          blocks.add(TopicContentBlock.code(code));
        }
        break;
      case 'code':
        final code = node.text.trimRight();
        if (code.trim().isNotEmpty) {
          blocks.add(TopicContentBlock.code(code));
        }
        break;
      case 'ul':
      case 'ol':
        final listItems = node
            .children
            .where((element) => element.localName == 'li')
            .map((element) => _normalizeText(element.text))
            .where((item) => item.isNotEmpty)
            .toList();
        if (listItems.isNotEmpty) {
          blocks.add(
            TopicContentBlock.list(
              listItems,
              ordered: tag == 'ol',
            ),
          );
        }
        break;
      case 'img':
        final src = _extractImageUrl(node);
        if (src != null) {
          blocks.add(TopicContentBlock.image(src));
        }
        break;
      case 'a':
        final href = _normalizeUrl(node.attributes['href']);
        if (href != null) {
          final title = _normalizeText(node.text);
          blocks.add(
            TopicContentBlock.link(
              title: title.isEmpty ? href : title,
              href: href,
            ),
          );
        }
        break;
      case 'table':
        final block = _parseTable(node);
        if (block != null) {
          blocks.add(block);
        }
        break;
      case 'hr':
        break;
      default:
        _parseMixedNodes(node.nodes, blocks);
    }
  }

  static TopicContentBlock? _parseTable(dom.Element table) {
    final headers = <String>[];
    final rows = <List<String>>[];

    final headerCells = table.querySelectorAll('thead tr th');
    if (headerCells.isNotEmpty) {
      headers.addAll(
        headerCells
            .map((cell) => _normalizeText(cell.text))
            .where((text) => text.isNotEmpty),
      );
    } else {
      final allRows = table.querySelectorAll('tr');
      final firstRowHeaders =
          allRows.isNotEmpty ? allRows.first.querySelectorAll('th') : const <dom.Element>[];
      headers.addAll(
        firstRowHeaders
            .map((cell) => _normalizeText(cell.text))
            .where((text) => text.isNotEmpty),
      );
    }

    final bodyRows = table.querySelectorAll('tbody tr');
    final fallbackRows = bodyRows.isNotEmpty ? bodyRows : table.querySelectorAll('tr');

    for (final row in fallbackRows) {
      final cells = row.querySelectorAll('td,th');
      if (cells.isEmpty) {
        continue;
      }
      final rowValues = cells
          .map((cell) => _normalizeText(cell.text))
          .toList();

      if (rowValues.every((value) => value.isEmpty)) {
        continue;
      }
      rows.add(rowValues);
    }

    if (headers.isEmpty && rows.isEmpty) {
      return null;
    }
    return TopicContentBlock.table(headers: headers, rows: rows);
  }

  static void _parseMixedNodes(
    List<dom.Node> nodes,
    List<TopicContentBlock> blocks,
  ) {
    final textBuffer = StringBuffer();
    final pendingImages = <String>[];

    void flushText() {
      final text = _normalizeText(textBuffer.toString());
      if (text.isNotEmpty) {
        blocks.add(TopicContentBlock.paragraph(text));
      }
      textBuffer.clear();
    }

    void flushImages() {
      if (pendingImages.isEmpty) {
        return;
      }
      if (pendingImages.length == 1) {
        blocks.add(TopicContentBlock.image(pendingImages.first));
      } else {
        blocks.add(TopicContentBlock.imageGroup(List<String>.from(pendingImages)));
      }
      pendingImages.clear();
    }

    for (final node in nodes) {
      if (node is dom.Text) {
        final text = _normalizeText(node.text);
        if (text.isNotEmpty) {
          if (textBuffer.isNotEmpty &&
              !textBuffer.toString().endsWith(' ') &&
              !textBuffer.toString().endsWith('\n')) {
            textBuffer.write(' ');
          }
          textBuffer.write(text);
        }
        continue;
      }

      if (node is! dom.Element) {
        continue;
      }

      final tag = (node.localName ?? '').toLowerCase();
      if (tag == 'br') {
        if (textBuffer.isNotEmpty && !textBuffer.toString().endsWith('\n')) {
          textBuffer.write('\n');
        }
        continue;
      }

      if (_isImageElement(node)) {
        flushText();
        final urls = _extractImageUrlsFromElement(node);
        pendingImages.addAll(urls);
        continue;
      }

      if (_isBlockTag(tag)) {
        flushText();
        flushImages();
        _parseNode(node, blocks);
        continue;
      }

      if (tag == 'a') {
        final href = _normalizeUrl(node.attributes['href']);
        final title = _normalizeText(node.text);

        if (_isStandaloneLinkElement(node) && href != null) {
          flushText();
          flushImages();
          blocks.add(
            TopicContentBlock.link(
              title: title.isEmpty ? href : title,
              href: href,
            ),
          );
          continue;
        }

        if (title.isNotEmpty) {
          if (textBuffer.isNotEmpty && !textBuffer.toString().endsWith(' ')) {
            textBuffer.write(' ');
          }
          textBuffer.write(title);
        }
        if (href != null && href.isNotEmpty && !title.contains(href)) {
          textBuffer.write(' ($href)');
        }
        continue;
      }

      final inlineText = _normalizeText(node.text);
      if (inlineText.isNotEmpty) {
        if (textBuffer.isNotEmpty && !textBuffer.toString().endsWith(' ')) {
          textBuffer.write(' ');
        }
        textBuffer.write(inlineText);
      }
    }

    flushText();
    flushImages();
  }

  static bool _isStandaloneLinkElement(dom.Element element) {
    final href = element.attributes['href'];
    if (href == null || href.isEmpty) {
      return false;
    }
    if (element.children.any((child) => child.localName == 'img')) {
      return false;
    }
    return true;
  }

  static bool _isImageElement(dom.Element element) {
    final tag = (element.localName ?? '').toLowerCase();
    if (tag == 'img') {
      return true;
    }
    if (tag == 'a' && element.children.any((child) => child.localName == 'img')) {
      return true;
    }
    return false;
  }

  static List<String> _extractImageUrlsFromElement(dom.Element element) {
    final urls = <String>[];
    final tag = (element.localName ?? '').toLowerCase();

    if (tag == 'img') {
      final src = _extractImageUrl(element);
      if (src != null) {
        urls.add(src);
      }
      return urls;
    }

    for (final child in element.querySelectorAll('img')) {
      final src = _extractImageUrl(child);
      if (src != null && !urls.contains(src)) {
        urls.add(src);
      }
    }
    return urls;
  }

  static String? _extractImageUrl(dom.Element element) {
    return DiscourseImageUrlResolver.resolveFromAttributes(element.attributes);
  }

  static String? _normalizeUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    return DiscourseImageUrlResolver.normalizeUrl(value);
  }

  static String _normalizeText(String text) {
    return text.replaceAll('\u00A0', ' ').replaceAll(_multiSpaceRegex, ' ').trim();
  }

  static bool _isBlockTag(String tag) {
    const blockTags = {
      'h1',
      'h2',
      'h3',
      'h4',
      'h5',
      'h6',
      'p',
      'div',
      'section',
      'article',
      'figure',
      'blockquote',
      'pre',
      'ul',
      'ol',
      'li',
      'table',
    };
    return blockTags.contains(tag);
  }

  static bool _isValidBlock(TopicContentBlock block) {
    switch (block.type) {
      case TopicContentBlockType.paragraph:
      case TopicContentBlockType.heading:
      case TopicContentBlockType.quote:
      case TopicContentBlockType.code:
        return block.text.trim().isNotEmpty;
      case TopicContentBlockType.image:
      case TopicContentBlockType.imageGroup:
        return block.images.isNotEmpty;
      case TopicContentBlockType.list:
        return block.listItems.isNotEmpty;
      case TopicContentBlockType.link:
        return (block.href ?? '').isNotEmpty;
      case TopicContentBlockType.table:
        return block.tableHeaders.isNotEmpty || block.tableRows.isNotEmpty;
    }
  }

  static List<TopicContentBlock> _mergeAdjacentImageBlocks(
    List<TopicContentBlock> blocks,
  ) {
    final merged = <TopicContentBlock>[];
    final imageBuffer = <String>[];

    void flushBuffer() {
      if (imageBuffer.isEmpty) {
        return;
      }
      if (imageBuffer.length == 1) {
        merged.add(TopicContentBlock.image(imageBuffer.first));
      } else {
        merged.add(TopicContentBlock.imageGroup(List<String>.from(imageBuffer)));
      }
      imageBuffer.clear();
    }

    for (final block in blocks) {
      if (block.type == TopicContentBlockType.image ||
          block.type == TopicContentBlockType.imageGroup) {
        imageBuffer.addAll(block.images);
      } else {
        flushBuffer();
        merged.add(block);
      }
    }

    flushBuffer();
    return merged;
  }
}

class TopicMagazineRenderer extends StatelessWidget {
  final List<TopicContentBlock> blocks;
  final EdgeInsetsGeometry padding;
  final ValueChanged<String>? onLinkTap;

  /// 标题块的 GlobalKey 列表，用于目录导航定位
  /// 索引对应 blocks 中的位置，非标题块为 null
  final List<GlobalKey>? headingKeys;

  const TopicMagazineRenderer({
    super.key,
    required this.blocks,
    this.padding = const EdgeInsets.only(top: 12),
    this.onLinkTap,
    this.headingKeys,
  });

  @override
  Widget build(BuildContext context) {
    if (blocks.isEmpty) {
      return const SizedBox.shrink();
    }

    final firstParagraphIndex = blocks.indexWhere(
      (block) => block.type == TopicContentBlockType.paragraph,
    );
    final firstMediaIndex = blocks.indexWhere(
      (block) =>
          block.type == TopicContentBlockType.image ||
          block.type == TopicContentBlockType.imageGroup,
    );

    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int index = 0; index < blocks.length; index++) ...[
            _buildBlock(
              context,
              blocks[index],
              index: index,
              firstParagraphIndex: firstParagraphIndex,
              firstMediaIndex: firstMediaIndex,
            ),
            if (index != blocks.length - 1)
              SizedBox(height: _spacingForBlock(blocks[index])),
          ],
        ],
      ),
    );
  }

  double _spacingForBlock(TopicContentBlock block) {
    switch (block.type) {
      case TopicContentBlockType.heading:
        return 12;
      case TopicContentBlockType.image:
      case TopicContentBlockType.imageGroup:
        return 16;
      case TopicContentBlockType.quote:
      case TopicContentBlockType.code:
      case TopicContentBlockType.table:
        return 14;
      default:
        return 10;
    }
  }

  Widget _buildBlock(
    BuildContext context,
    TopicContentBlock block, {
    required int index,
    required int firstParagraphIndex,
    required int firstMediaIndex,
  }) {
    switch (block.type) {
      case TopicContentBlockType.paragraph:
        final isLead = index == firstParagraphIndex;
        return Text(
          block.text,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                height: 1.8,
                fontSize: isLead ? 18 : null,
                fontWeight: isLead ? FontWeight.w500 : null,
              ),
        );
      case TopicContentBlockType.heading:
        final headingStyle = _headingStyle(context, block.headingLevel);
        final key = headingKeys != null && index < headingKeys!.length
            ? headingKeys![index]
            : null;
        return Container(
          key: key,
          child: Text(block.text, style: headingStyle),
        );
      case TopicContentBlockType.quote:
        final colorScheme = Theme.of(context).colorScheme;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(12),
            border: Border(
              left: BorderSide(
                color: colorScheme.primary,
                width: 4,
              ),
            ),
          ),
          child: Text(
            block.text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.7),
          ),
        );
      case TopicContentBlockType.code:
        final colorScheme = Theme.of(context).colorScheme;
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: colorScheme.surfaceContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SelectableText(
              block.text,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontFamily: 'monospace',
                    height: 1.6,
                  ),
            ),
          ),
        );
      case TopicContentBlockType.list:
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (int i = 0; i < block.listItems.length; i++)
              Padding(
                padding: EdgeInsets.only(bottom: i == block.listItems.length - 1 ? 0 : 8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Text(
                        block.ordered ? '${i + 1}.' : '•',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        block.listItems[i],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.7),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      case TopicContentBlockType.link:
        final href = block.href;
        if (href == null || href.isEmpty) {
          return const SizedBox.shrink();
        }
        return _LinkBlock(
          title: block.text,
          url: href,
          onTap: () => _handleLinkTap(context, href),
        );
      case TopicContentBlockType.table:
        return _buildTable(context, block);
      case TopicContentBlockType.image:
      case TopicContentBlockType.imageGroup:
        return _MagazineImageGroup(
          images: block.images,
          isHero: index == firstMediaIndex,
        );
    }
  }

  TextStyle? _headingStyle(BuildContext context, int level) {
    final base = Theme.of(context).textTheme;
    switch (level) {
      case 1:
        return base.headlineSmall?.copyWith(fontWeight: FontWeight.w700, height: 1.35);
      case 2:
        return base.titleLarge?.copyWith(fontWeight: FontWeight.w700, height: 1.4);
      case 3:
        return base.titleMedium?.copyWith(fontWeight: FontWeight.w700, height: 1.4);
      default:
        return base.titleSmall?.copyWith(fontWeight: FontWeight.w700, height: 1.45);
    }
  }

  Future<void> _handleLinkTap(BuildContext context, String url) async {
    if (onLinkTap != null) {
      onLinkTap!(url);
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      return;
    }

    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!launched && context.mounted) {
      context.push(
        '${RoutePaths.webview}?url=${Uri.encodeComponent(url)}&title=${Uri.encodeComponent('外部链接')}',
      );
    }
  }

  Widget _buildTable(BuildContext context, TopicContentBlock block) {
    final colorScheme = Theme.of(context).colorScheme;
    final columns = <String>[
      ...block.tableHeaders,
    ];

    final rows = block.tableRows;
    if (columns.isEmpty && rows.isNotEmpty) {
      final maxColumns = rows.fold<int>(
        0,
        (max, row) => row.length > max ? row.length : max,
      );
      for (var i = 0; i < maxColumns; i++) {
        columns.add('列 ${i + 1}');
      }
    }

    if (columns.isEmpty) {
      return const SizedBox.shrink();
    }

    final normalizedRows = rows
        .map((row) {
          if (row.length >= columns.length) {
            return row.take(columns.length).toList();
          }
          return [...row, ...List.filled(columns.length - row.length, '')];
        })
        .toList();

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            headingRowColor: WidgetStatePropertyAll(
              colorScheme.surfaceContainerHighest.withValues(alpha: 0.7),
            ),
            dataRowMinHeight: 44,
            dataRowMaxHeight: 72,
            columns: [
              for (final column in columns)
                DataColumn(
                  label: Text(
                    column,
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
            ],
            rows: [
              for (final row in normalizedRows)
                DataRow(
                  cells: [
                    for (final cell in row)
                      DataCell(
                        Text(
                          cell,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(height: 1.5),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LinkBlock extends StatelessWidget {
  final String title;
  final String url;
  final VoidCallback onTap;

  const _LinkBlock({
    required this.title,
    required this.url,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: colorScheme.outline.withValues(alpha: 0.2)),
          color: colorScheme.surfaceContainerLow,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.link_rounded, color: colorScheme.primary),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    url,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                  ),
                ],
              ),
            ),
            Icon(Icons.open_in_new_rounded, size: 18, color: colorScheme.onSurfaceVariant),
          ],
        ),
      ),
    );
  }
}

class _MagazineImageGroup extends StatelessWidget {
  final List<String> images;
  final bool isHero;

  const _MagazineImageGroup({
    required this.images,
    required this.isHero,
  });

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }

    if (images.length == 1) {
      return _buildSingle(context);
    }

    if (images.length == 2) {
      return _buildTwo(context);
    }

    if (images.length <= 4) {
      return _buildThreeOrFour(context);
    }

    return _buildFivePlus(context);
  }

  Widget _buildSingle(BuildContext context) {
    final ratio = isHero ? 16 / 9 : 4 / 3;
    return AspectRatio(
      aspectRatio: ratio,
      child: _imageTile(context, 0, borderRadius: 16),
    );
  }

  Widget _buildTwo(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: isHero ? 3 : 1,
          child: AspectRatio(
            aspectRatio: isHero ? 1.0 : 1.15,
            child: _imageTile(context, 0, borderRadius: 14),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          flex: 2,
          child: AspectRatio(
            aspectRatio: 1.15,
            child: _imageTile(context, 1, borderRadius: 14),
          ),
        ),
      ],
    );
  }

  Widget _buildThreeOrFour(BuildContext context) {
    if (images.length == 3) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: AspectRatio(
              aspectRatio: 0.92,
              child: _imageTile(context, 0, borderRadius: 14),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                AspectRatio(
                  aspectRatio: 1.05,
                  child: _imageTile(context, 1, borderRadius: 14),
                ),
                const SizedBox(height: 8),
                AspectRatio(
                  aspectRatio: 1.05,
                  child: _imageTile(context, 2, borderRadius: 14),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: _imageTile(context, 0, borderRadius: 14),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.25,
                child: _imageTile(context, 1, borderRadius: 14),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.25,
                child: _imageTile(context, 2, borderRadius: 14),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: AspectRatio(
                aspectRatio: 1.25,
                child: _imageTile(context, 3, borderRadius: 14),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFivePlus(BuildContext context) {
    final maxPreview = images.take(5).toList();
    final extra = images.length - maxPreview.length;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9,
          child: _imageTile(context, 0, borderRadius: 14),
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.25,
          ),
          itemCount: maxPreview.length - 1,
          itemBuilder: (context, index) {
            final actualIndex = index + 1;
            final showOverlay = extra > 0 && actualIndex == maxPreview.length - 1;

            return Stack(
              fit: StackFit.expand,
              children: [
                _imageTile(context, actualIndex, borderRadius: 14),
                if (showOverlay)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.black.withValues(alpha: 0.45),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '+$extra',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _imageTile(
    BuildContext context,
    int index, {
    required double borderRadius,
  }) {
    return InkWell(
      borderRadius: BorderRadius.circular(borderRadius),
      onTap: () {
        final originalImages = images
            .map(DiscourseImageUrlResolver.toOriginalUrl)
            .whereType<String>()
            .toList();
        ImagePreviewPage.show(
          context,
          imageUrls: originalImages.isEmpty ? images : originalImages,
          initialIndex: index,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: CachedImage(
          imageUrl: images[index],
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
