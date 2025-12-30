import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/kasir/widgets/option_history_kasir.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CardHistoryKasir extends StatelessWidget {
  final String title;
  final String subtitle;
  final String amount;
  final String time;
  final String status;
  final Color statusColor;
  final IconData statusIcon;
  final String invCode;
  final int itemCount;
  final VoidCallback? onChat;
  final VoidCallback? onRefund;
  final VoidCallback? onSukseskan;

  const CardHistoryKasir({
    super.key,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.statusIcon,
    required this.invCode,
    required this.itemCount,
    this.onChat,
    this.onRefund,
    this.onSukseskan,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "$invCode • $subtitle",
                            style: context.bodySmall.copyWith(
                              color: AppColors.lightMutedForeground,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (onChat != null ||
                        onRefund != null ||
                        onSukseskan != null)
                      OptionHistoryKasir(
                        onChat: onChat,
                        onRefund: onRefund,
                        onSukseskan: onSukseskan,
                      ),
                  ],
                ),
                Gap(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "$itemCount Barang",
                              style: context.bodyMedium.copyWith(
                                color: context.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              "Rp $amount",
                              style: context.bodyMedium.copyWith(
                                color: context.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.lightMuted,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            "$time WIB",
                            style: context.bodyExtraSmall.copyWith(
                              color: AppColors.lightMutedForeground,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Row(
                          children: [
                            Icon(statusIcon, size: 14, color: statusColor),
                            const SizedBox(width: 4),
                            Text(
                              status,
                              style: context.bodyExtraSmall.copyWith(
                                color: statusColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
