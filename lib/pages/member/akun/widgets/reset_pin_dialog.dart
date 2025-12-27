import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class ResetPinDialog extends StatefulWidget {
  const ResetPinDialog({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const ResetPinDialog(),
    );
  }

  @override
  State<ResetPinDialog> createState() => _ResetPinDialogState();
}

class _ResetPinDialogState extends State<ResetPinDialog> {
  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6.0,
          ).copyWith(bottom: bottomInset),
          decoration: BoxDecoration(
            color: context.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            border: Border.all(color: context.border, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(10),
              TopDividerSheet(),
              Gap(15),
              Card(
                child: Padding(
                  padding: paddingCard,
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: context.destructive.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          MdiIcons.lockReset,
                          color: context.destructive,
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reset PIN Transaksi?',
                              style: context.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Akses transaksi Anda akan dibatasi sementara hingga PIN baru dibuat.',
                              style: context.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Gap(10),
              BlocBuilder<MemberProvider, MemberState>(
                builder: (context, state) {
                  return buildOtpWarning(
                    context,
                    phoneNumber: state.profileDetail.nohp,
                  );
                },
              ),
              Gap(15),
              BlocBuilder<MemberProvider, MemberState>(
                buildWhen: (previous, current) =>
                    previous.apiResetPinStatus != current.apiResetPinStatus,
                builder: (context, state) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomButton(
                          height: 30,
                          padding: EdgeInsets.zero,
                          variant: ButtonVariant.border,
                          borderColor: context.primary,
                          foregroundColor: context.primary,
                          text: "Batal",
                          onPressed: () {
                            if (!state.apiResetPinStatus.isLoading) pop();
                          },
                        ),
                      ),
                      Gap(15),
                      Expanded(
                        child: CustomButton(
                          height: 30,
                          padding: EdgeInsets.zero,
                          variant: ButtonVariant.destructive,
                          text: "Reset Pin",
                          isLoading: state.apiResetPinStatus.isLoading,
                          onPressed: () async {
                            var suc = await getMemberProvider(
                              context,
                            ).resetPin();

                            if (suc) {
                              pop();
                            }
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
              Gap(15),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildOtpWarning(
    BuildContext context, {
    String phoneNumber = '088****6178',
  }) {
    // Kita ambil palette warna langsung dari AppColors biar konsisten
    final colorPalette = orange;
    final greenPalette = green;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorPalette[50], // Background orange muda
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: colorPalette[200]!, // Border orange halus
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Info
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Icon(
              Icons.info_outline_rounded,
              color: colorPalette[600],
              size: 24,
            ),
          ),
          const SizedBox(width: 12),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Penting:',
                  style: context.bodyLarge
                      .withColor(colorPalette[800]!)
                      .withWeight(FontWeight.w600),
                ),

                // RichText buat text campur badge
                RichText(
                  text: TextSpan(
                    style: context.captionMedium,
                    children: [
                      const TextSpan(text: 'Pastikan nomor '),

                      // WidgetSpan buat kotak putih nomor HP
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            // Badge tetep putih biar kontras sama orange muda
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: colorPalette[200]!.withValues(alpha: 0.5),
                            ),
                          ),
                          child: Text(
                            phoneNumber,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                              fontSize: 13,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ),

                      const TextSpan(
                        text:
                            ' benar dan aktif.\nKami akan mengirim Pin baru ke No HP Anda via ',
                      ),

                      // Text WhatsApp Hijau
                      TextSpan(
                        text: 'WhatsApp',
                        style: TextStyle(
                          color: greenPalette[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: ' Jika Anda tidak menerima pesan '),
                      TextSpan(
                        text: 'WhatsApp',
                        style: TextStyle(
                          color: greenPalette[600],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const TextSpan(text: ' pergantian silahkan hubungi CS Kami. '),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
