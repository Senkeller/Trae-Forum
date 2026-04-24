class DiscourseImageUrlResolver {
  static String? resolveFromAttributes(Map<dynamic, String> attributes) {
    final srcsetBest = _bestFromSrcset(attributes['srcset']);
    final candidates = <String?>[
      attributes['data-orig-src'],
      attributes['data-original'],
      attributes['data-src'],
      srcsetBest,
      attributes['src'],
    ];
    return _firstValidUrl(candidates);
  }

  static String? resolveOriginalFromAttributes(Map<dynamic, String> attributes) {
    final explicitOriginal = _firstValidUrl([
      attributes['data-orig-src'],
      attributes['data-original'],
      attributes['data-full-src'],
    ]);
    if (explicitOriginal != null) {
      return explicitOriginal;
    }

    final srcsetBest = _bestFromSrcset(attributes['srcset']);
    final preferred = _firstValidUrl([
      srcsetBest,
      attributes['data-src'],
      attributes['src'],
    ]);
    return toOriginalUrl(preferred);
  }

  static String? normalizeUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final raw = value.trim();
    if (raw.startsWith('http://') || raw.startsWith('https://')) {
      return raw;
    }
    if (raw.startsWith('//')) {
      return 'https:$raw';
    }
    if (raw.startsWith('/')) {
      return 'https://forum.trae.cn$raw';
    }
    return 'https://forum.trae.cn/$raw';
  }

  static String? toOriginalUrl(String? value) {
    final normalized = normalizeUrl(value);
    if (normalized == null) {
      return null;
    }

    final uri = Uri.tryParse(normalized);
    if (uri == null) {
      return normalized;
    }

    var path = uri.path;
    if (!path.contains('/optimized/')) {
      return normalized;
    }

    path = path.replaceFirst('/optimized/', '/original/');
    final segments = List<String>.from(Uri.parse('https://x$path').pathSegments);
    if (segments.isNotEmpty) {
      final last = segments.last;
      final restored = last.replaceFirst(
        RegExp(r'_(\d+)_\d+x\d+(?=\.[A-Za-z0-9]+$)'),
        '',
      );
      segments[segments.length - 1] = restored;
      path = '/${segments.join('/')}';
    }

    return uri.replace(path: path).toString();
  }

  static String? _firstValidUrl(Iterable<String?> candidates) {
    for (final candidate in candidates) {
      final normalized = normalizeUrl(candidate);
      if (normalized != null && normalized.isNotEmpty) {
        return normalized;
      }
    }
    return null;
  }

  static String? _bestFromSrcset(String? srcset) {
    if (srcset == null || srcset.trim().isEmpty) {
      return null;
    }

    String? bestUrl;
    int bestScore = -1;

    final entries = srcset.split(',');
    for (final entry in entries) {
      final part = entry.trim();
      if (part.isEmpty) {
        continue;
      }

      final pieces = part.split(RegExp(r'\s+'));
      final url = pieces.isNotEmpty ? pieces.first : '';
      if (url.isEmpty) {
        continue;
      }

      int score = 1;
      if (pieces.length > 1) {
        final descriptor = pieces[1].toLowerCase();
        if (descriptor.endsWith('w')) {
          score = int.tryParse(descriptor.substring(0, descriptor.length - 1)) ?? 1;
        } else if (descriptor.endsWith('x')) {
          final xValue = double.tryParse(descriptor.substring(0, descriptor.length - 1));
          if (xValue != null) {
            score = (xValue * 1000).round();
          }
        }
      }

      if (score > bestScore) {
        bestScore = score;
        bestUrl = url;
      }
    }

    return bestUrl;
  }
}
