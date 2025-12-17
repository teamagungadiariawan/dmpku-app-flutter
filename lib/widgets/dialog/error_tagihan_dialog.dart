import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class ErrorTagihanDialog extends StatefulWidget {
  final String title;
  final KeyValueResponse result;

  const ErrorTagihanDialog({
    super.key,
    required this.title,
    required this.result,
  });

  static void show(
    BuildContext context, {
    required String title,
    required KeyValueResponse result,
  }) {
    debugPrint("ErrorTagihanDialog: show");

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => ErrorTagihanDialog(title: title, result: result),
    );
  }

  @override
  State<ErrorTagihanDialog> createState() => _ErrorTagihanDialogState();
}

class _ErrorTagihanDialogState extends State<ErrorTagihanDialog> {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        decoration: BoxDecoration(
          color: context.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
          border: Border.all(color: context.border, width: 1),
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: bottomInset),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TopDividerSheet(),
              Gap(15),
              Card(
                color: context.destructive.withOpacity(0.2),
                child: Padding(
                  padding: paddingCard,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: context.isDarkMode ? stone[700] : stone[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(MdiIcons.alert, color: context.destructive),
                      ),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: context.bodyLarge
                                  .copyWith(fontWeight: FontWeight.w600)
                                  .withColor(context.destructive),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding: paddingCard,
                  child: ListView.builder(
                    itemCount: widget.result.items.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = widget.result.items[index];
                      return _buildDetailItem(context, item);
                    },
                  ),
                ),
              ),
              const Gap(10),
              CustomButton(
                height: 30,
                width: double.infinity,
                padding: EdgeInsets.zero,
                variant: ButtonVariant.destructive,
                text: "TUTUP",
                onPressed: () => pop(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(BuildContext context, dynamic item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: context.border, width: 1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                item.key,
                style: context.bodyMedium.withWeight(FontWeight.w600),
              ),
            ),
          ),

          Container(
            constraints: BoxConstraints(maxWidth: 150),
            child: Text(
              item.value,
              textAlign: TextAlign.end,
              style: context.bodyMedium.withWeight(FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }
}
