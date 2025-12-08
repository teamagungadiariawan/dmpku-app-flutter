import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class MenuItem {
  final AssetGenImage icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const MenuItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

class MemberMenuSection extends StatelessWidget {
  final String title;
  final List<MenuItem> items;

  const MemberMenuSection({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: context.bodySmall.withColor(context.mutedForeground),
        ),
        const Gap(2),
        Card(
          child: ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) => _MemberMenuCard(
              item: items[index],
              isFirst: index == 0,
              isLast: index == items.length - 1,
            ),
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ],
    );
  }
}

class _MemberMenuCard extends StatelessWidget {
  final MenuItem item;
  final bool isFirst;
  final bool isLast;

  const _MemberMenuCard({
    required this.item,
    this.isFirst = false,
    this.isLast = false,
  });

  BorderRadius get _borderRadius {
    if (isFirst && isLast) return BorderRadius.circular(8);
    if (isFirst) {
      return const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      );
    }
    if (isLast) {
      return const BorderRadius.only(
        bottomLeft: Radius.circular(8),
        bottomRight: Radius.circular(8),
      );
    }
    return BorderRadius.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : context.border,
          ),
        ),
      ),
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: _borderRadius,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              item.icon.image(height: 30, width: 30),
              const Gap(8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      item.title,
                      style: context.bodySmall
                          .withColor(context.foreground)
                          .withWeight(FontWeight.w800),
                    ),
                    Text(
                      item.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.captionMedium
                          .withColor(context.mutedForeground)
                          .withWeight(FontWeight.w800),
                    ),
                  ],
                ),
              ),
              const Gap(10),
              Icon(
                LucideIcons.chevronRight,
                color: context.mutedForeground,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}