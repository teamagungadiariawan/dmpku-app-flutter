import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

enum _OptionAction { edit, delete }

class OptionProduk extends StatelessWidget {
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const OptionProduk({super.key, required this.onEdit, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 18,
      width: 18,
      child: PopupMenuButton<_OptionAction>(
        icon: Icon(MdiIcons.dotsVertical, size: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.zero,
        menuPadding: EdgeInsets.zero,
        constraints: const BoxConstraints(minWidth: 120, maxWidth: 150),
        onSelected: (action) {
          if (action == _OptionAction.edit) {
            onEdit();
          } else if (action == _OptionAction.delete) {
            onDelete();
          }
        },
        itemBuilder: (context) => [
          _buildMenuItem(context, _OptionAction.edit),
          _buildMenuItem(context, _OptionAction.delete),
        ],
      ),
    );
  }

  PopupMenuItem<_OptionAction> _buildMenuItem(
    BuildContext context,
    _OptionAction action,
  ) {
    final isEdit = action == _OptionAction.edit;

    final String label = isEdit ? 'Ubah' : 'Hapus';
    final IconData icon = isEdit
        ? MdiIcons.pencilOutline
        : MdiIcons.trashCanOutline;
    final Color? color = isEdit ? null : Colors.red;

    return PopupMenuItem<_OptionAction>(
      value: action,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 30,
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 8),
          Text(label, style: context.bodySmall),
        ],
      ),
    );
  }
}
