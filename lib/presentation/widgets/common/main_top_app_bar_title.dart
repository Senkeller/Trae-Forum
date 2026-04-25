import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/constants.dart';
import '../../providers/auth_provider.dart';

/// 主页面顶部标题区域（头像 + 搜索）。
class MainTopAppBarTitle extends ConsumerWidget {
  const MainTopAppBarTitle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final authState = ref.watch(authNotifierProvider);
    final currentUser = authState.valueOrNull;

    return SizedBox(
      height: 40,
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              if (currentUser != null) {
                context.push('/profile/${currentUser.uid}');
              } else {
                context.push(RoutePaths.login);
              }
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.primaryContainer,
              ),
              child: ClipOval(
                child:
                    currentUser?.avatar != null &&
                        currentUser!.avatar!.isNotEmpty
                    ? Image.network(
                        currentUser.avatar!,
                        width: 36,
                        height: 36,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person,
                            size: 20,
                            color: colorScheme.onPrimaryContainer,
                          );
                        },
                      )
                    : Icon(
                        Icons.person,
                        size: 20,
                        color: colorScheme.onPrimaryContainer,
                      ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: () {
                context.push(RoutePaths.search);
              },
              child: Container(
                height: 36,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      size: 18,
                      color: colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '搜索话题、用户...',
                      style: TextStyle(
                        fontSize: 14,
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
