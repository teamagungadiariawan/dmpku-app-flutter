import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';

enum _OptionAction { chat, refund, sukseskan }

class OptionHistoryKasir extends StatelessWidget {
  final VoidCallback? onChat;
  final VoidCallback? onRefund;
  final VoidCallback? onSukseskan;

  const OptionHistoryKasir({
    super.key,
    this.onChat,
    this.onRefund,
    this.onSukseskan,
  });

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
        constraints: const BoxConstraints(minWidth: 150, maxWidth: 180),
        onSelected: (action) {
          if (action == _OptionAction.chat) {
            onChat?.call();
          } else if (action == _OptionAction.refund) {
            onRefund?.call();
          } else if (action == _OptionAction.sukseskan) {
            onSukseskan?.call();
          }
        },
        itemBuilder: (context) {
          final List<PopupMenuItem<_OptionAction>> items = [];

          if (onChat != null) {
            items.add(_buildMenuItem(context, _OptionAction.chat));
          }
          if (onRefund != null) {
            items.add(_buildMenuItem(context, _OptionAction.refund));
          }
          if (onSukseskan != null) {
            items.add(_buildMenuItem(context, _OptionAction.sukseskan));
          }

          return items;
        },
      ),
    );
  }

  PopupMenuItem<_OptionAction> _buildMenuItem(
    BuildContext context,
    _OptionAction action,
  ) {
    final isChat = action == _OptionAction.chat;
    final isRefund = action == _OptionAction.refund;

    String label;
    IconData icon;
    Color? color;

    if (isChat) {
      label = 'Chat Pelanggan';
      icon = MdiIcons.chatOutline;
      color = Colors.blue;
    } else if (isRefund) {
      label = 'Refund Dana';
      icon = MdiIcons.cashRefund;
      color = Colors.red;
    } else {
      label = 'Sukseskan';
      icon = MdiIcons.checkCircleOutline;
      color = Colors.green;
    }

    return PopupMenuItem<_OptionAction>(
      value: action,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 36,
      child: Row(
        children: [
          Icon(icon, size: 16, color: color),
          const SizedBox(width: 8),
          Text(label, style: context.bodySmall),
        ],
      ),
    );
  }
}
