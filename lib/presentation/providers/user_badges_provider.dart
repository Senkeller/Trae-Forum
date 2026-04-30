import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/discourse_api_service.dart';
import '../../data/models/discourse/discourse_user.dart';

/// 用户徽章数据模型
class UserBadgeInfo {
  final int id;
  final String name;
  final String? description;
  final String? icon;
  final String? imageUrl;
  final String slug;

  const UserBadgeInfo({
    required this.id,
    required this.name,
    this.description,
    this.icon,
    this.imageUrl,
    required this.slug,
  });

  factory UserBadgeInfo.fromDiscourseBadge(DiscourseBadge badge) {
    return UserBadgeInfo(
      id: badge.id,
      name: badge.name,
      description: badge.description,
      icon: badge.icon,
      imageUrl: badge.imageUrl,
      slug: badge.slug,
    );
  }
}

/// 用户徽章列表 Provider
final userBadgesProvider = FutureProvider.family<List<UserBadgeInfo>, String>(
  (ref, username) async {
    if (username.isEmpty) return [];

    try {
      final discourseApi = ref.read(discourseApiServiceProvider);
      final response = await discourseApi.getUserBadges(username);

      final data = response.data as Map<String, dynamic>?;
      if (data == null) return [];

      final badgesJson = data['badges'] as List<dynamic>? ?? [];
      final userBadgesJson = data['user_badges'] as List<dynamic>? ?? [];

      // 解析徽章定义
      final badgeMap = <int, DiscourseBadge>{};
      for (final badgeData in badgesJson) {
        if (badgeData is Map<String, dynamic>) {
          try {
            final badge = DiscourseBadge.fromJson(badgeData);
            badgeMap[badge.id] = badge;
          } catch (_) {}
        }
      }

      // 获取用户拥有的徽章ID列表
      final userBadgeIds = <int>{};
      for (final userBadgeData in userBadgesJson) {
        if (userBadgeData is Map<String, dynamic>) {
          final badgeId = userBadgeData['badge_id'] as int?;
          if (badgeId != null) {
            userBadgeIds.add(badgeId);
          }
        }
      }

      // 构建用户徽章列表
      final userBadges = <UserBadgeInfo>[];
      for (final badgeId in userBadgeIds) {
        final badge = badgeMap[badgeId];
        if (badge != null) {
          userBadges.add(UserBadgeInfo.fromDiscourseBadge(badge));
        }
      }

      return userBadges;
    } catch (e) {
      debugPrint('🔍 [userBadgesProvider] 获取用户徽章失败: $e');
      return [];
    }
  },
);
