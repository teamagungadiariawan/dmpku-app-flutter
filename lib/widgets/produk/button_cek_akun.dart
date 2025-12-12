import 'package:dmpku/core/helpers/keyboard_helper.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ButtonCekAkun extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  final bool isLoading;
  final KeyValueResponse dataAkun;
  final String tujuan;

  const ButtonCekAkun({
    super.key,
    required this.onPressed,
    this.label = 'Cek Akun',
    this.isLoading = false,
    required this.dataAkun,
    required this.tujuan,
  });

  @override
  Widget build(BuildContext context) {
    final isTujuanMatchResult = checkTujuanMatchResult(dataAkun, tujuan);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomButton(
          text: 'Cek Akun',
          onPressed: () {
            closeKeyBoard();
            onPressed();
          },
          isLoading: isLoading,
          height: 30,
          width: double.infinity,
          padding: EdgeInsets.zero,
        ),

        Gap(4),
        if (dataAkun.items.isNotEmpty && isTujuanMatchResult) ...[
          Card(
            child: Padding(
              padding: paddingCard,
              child: ListView.builder(
                itemCount: dataAkun.items.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final item = dataAkun.items[index];
                  return Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.key,
                          style: context.bodyMedium.withWeight(FontWeight.w600),
                        ),
                      ),
                      Text(
                        item.value,
                        style: context.bodyMedium.withWeight(FontWeight.w400),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}
