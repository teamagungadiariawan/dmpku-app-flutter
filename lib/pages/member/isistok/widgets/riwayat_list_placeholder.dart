import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class RiwayatListPlaceholder extends StatelessWidget {
  final String categoryName;

  const RiwayatListPlaceholder({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: context.primary.withValues(alpha: 0.1),
              child: Icon(MdiIcons.history, color: context.primary, size: 20),
            ),
            title: Text(
              "Riwayat $categoryName", // Dinamis sesuai tab
              style: context.bodyMedium.withWeight(FontWeight.w600),
            ),
            subtitle: Text(
              "Rp ${(index + 1) * 50}.000 • Sukses",
              style: context.captionRegular,
            ),
            trailing: Icon(
              LucideIcons.chevronRight,
              size: 16,
              color: context.mutedForeground,
            ),
          ),
        );
      },
    );
  }
}
