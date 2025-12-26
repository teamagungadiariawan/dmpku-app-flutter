import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:pinput/pinput.dart';

class GantiPinDialog extends StatefulWidget {
  const GantiPinDialog({super.key});

  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => const GantiPinDialog(),
    );
  }

  @override
  State<GantiPinDialog> createState() => _GantiPinDialogState();
}

class _GantiPinDialogState extends State<GantiPinDialog> {
  final pinLamaController = TextEditingController();
  final pinBaruController = TextEditingController();
  final konfirmasiPinBaruController = TextEditingController();

  final pinLamaFocus = FocusNode();
  final pinBaruFocus = FocusNode();
  final konfirmasiPinBaruFocus = FocusNode();

  String errMsgPinLama = '';
  String errMsgPinBaru = '';
  String errMsgKonfirmasiPinBaru = '';

  bool validatePinLama() {
    setState(() {
      errMsgPinLama = '';
    });
    var pin = pinLamaController.text.trim();

    if (pin.isEmpty) {
      setState(() {
        errMsgPinLama = 'PIN lama tidak boleh kosong';
      });
      return false;
    }

    if (pin.length < 6) {
      setState(() {
        errMsgPinLama = 'PIN lama harus terdiri dari 6 digit';
      });
      return false;
    }

    setState(() {
      errMsgPinLama = '';
    });
    return true;
  }

  bool validatePinBaru() {
    setState(() {
      errMsgPinBaru = '';
    });
    var pin = pinBaruController.text.trim();
    var pinLama = pinLamaController.text.trim();

    if (pin == pinLama) {
      setState(() {
        errMsgPinBaru = 'PIN baru tidak boleh sama dengan PIN lama';
      });
      return false;
    }

    if (pin.isEmpty) {
      setState(() {
        errMsgPinBaru = 'PIN baru tidak boleh kosong';
      });
      return false;
    }

    if (pin.length < 6) {
      setState(() {
        errMsgPinBaru = 'PIN baru harus terdiri dari 6 digit';
      });
      return false;
    }

    setState(() {
      errMsgPinBaru = '';
    });

    pinBaruFocus.requestFocus();

    return true;
  }

  bool validateKonfirmasiPinBaru() {
    setState(() {
      errMsgKonfirmasiPinBaru = '';
    });
    var pin = konfirmasiPinBaruController.text.trim();
    var pinLama = pinLamaController.text.trim();

    if (pin == pinLama) {
      setState(() {
        errMsgKonfirmasiPinBaru = 'PIN baru tidak boleh sama dengan PIN lama';
      });
      return false;
    }

    if (pin.isEmpty) {
      setState(() {
        errMsgKonfirmasiPinBaru = 'Konfirmasi PIN baru tidak boleh kosong';
      });
      return false;
    }

    if (pin.length < 6) {
      setState(() {
        errMsgKonfirmasiPinBaru =
            'Konfirmasi PIN baru harus terdiri dari 6 digit';
      });
      return false;
    }

    if (pin != pinBaruController.text.trim()) {
      setState(() {
        errMsgKonfirmasiPinBaru =
            'Konfirmasi PIN baru tidak sesuai dengan PIN baru';
      });
      return false;
    }
    konfirmasiPinBaruFocus.requestFocus();

    setState(() {
      errMsgKonfirmasiPinBaru = '';
    });
    return true;
  }

  void validateAll() async {
    bool isPinLamaValid = validatePinLama();
    bool isPinBaruValid = validatePinBaru();
    bool isKonfirmasiPinBaruValid = validateKonfirmasiPinBaru();

    if (isPinLamaValid && isPinBaruValid && isKonfirmasiPinBaruValid) {
      var suc = await getMemberProvider(context).gantiPin(
        pinLama: pinLamaController.text.trim(),
        pinBaru: pinBaruController.text.trim(),
      );

      if (suc) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final defaultPinTheme = PinTheme(
      width: 24,
      height: 24,
      textStyle: context.bodyMedium
          .withColor(context.primary)
          .withWeight(FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: context.primary),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.primary, width: 2),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.destructive, width: 2),
      borderRadius: BorderRadius.circular(8),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 6.0,
          ).copyWith(bottom: bottomInset + 10),
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
                          color: context.isDarkMode ? stone[700] : stone[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          MdiIcons.scriptTextKey,
                          color: context.primary,
                        ),
                      ),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ganti PIN',
                              style: context.bodyLarge.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Untuk keamanan akun Anda, silakan ganti PIN secara berkala.',
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
                buildWhen: (previous, current) =>
                    previous.apiGantiPinStatus != current.apiGantiPinStatus,
                builder: (context, state) {
                  if (state.apiGantiPinMessage.isEmpty)
                    return SizedBox.shrink();

                  return Card(
                    margin: EdgeInsets.only(top: 10),
                    color: context.destructive.withOpacity(0.3),
                    child: Padding(
                      padding: paddingCard,
                      child: Row(
                        children: [
                          Icon(
                            MdiIcons.alertCircleOutline,
                            color: context.destructive,
                          ),
                          Gap(10),
                          Expanded(
                            child: Text(
                              state.apiGantiPinMessage,
                              style: context.bodyMedium.withColor(
                                context.destructive,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),

              Text(
                "Pin Lama:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
              Gap(10),
              Align(
                alignment: Alignment.center,
                child: Pinput(
                  controller: pinLamaController,
                  obscureText: true,
                  length: 6,
                  autofocus: true,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  errorPinTheme: errorPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                  showCursor: true,
                  onCompleted: (_) {
                    validatePinLama();
                  },
                  closeKeyboardWhenCompleted: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                  forceErrorState: errMsgPinLama.isNotEmpty,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (errMsgPinLama.isNotEmpty) ...[
                    Gap(8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        errMsgPinLama,
                        style: context.bodySmall
                            .withColor(context.destructive)
                            .withWeight(FontWeight.w500),
                      ),
                    ),
                  ],
                ],
              ),

              Gap(15),
              Divider(color: context.border, height: 0.5),
              Gap(10),
              Text(
                "Pin Baru:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
              Gap(10),
              Align(
                alignment: Alignment.center,
                child: Pinput(
                  focusNode: pinBaruFocus,
                  controller: pinBaruController,
                  obscureText: true,
                  length: 6,
                  autofocus: true,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  errorPinTheme: errorPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                  showCursor: true,
                  onCompleted: (_) {
                    validatePinBaru();
                  },
                  closeKeyboardWhenCompleted: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                  forceErrorState: errMsgPinBaru.isNotEmpty,
                  textInputAction: TextInputAction.next,
                ),
              ),
              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (errMsgPinBaru.isNotEmpty) ...[
                    Gap(8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        errMsgPinBaru,
                        style: context.bodySmall
                            .withColor(context.destructive)
                            .withWeight(FontWeight.w500),
                      ),
                    ),
                  ],
                ],
              ),
              Gap(15),
              Divider(color: context.border, height: 0.5),
              Gap(10),
              Text(
                "Konfirmasi Pin Baru:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
              Gap(10),
              Align(
                alignment: Alignment.center,
                child: Pinput(
                  focusNode: konfirmasiPinBaruFocus,
                  controller: konfirmasiPinBaruController,
                  obscureText: true,
                  length: 6,
                  autofocus: true,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  errorPinTheme: errorPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                  showCursor: true,
                  onCompleted: (_) {
                    validateKonfirmasiPinBaru();
                  },
                  closeKeyboardWhenCompleted: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                  forceErrorState: errMsgKonfirmasiPinBaru.isNotEmpty,
                  textInputAction: TextInputAction.done,
                ),
              ),

              Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (errMsgKonfirmasiPinBaru.isNotEmpty) ...[
                    Gap(8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        errMsgKonfirmasiPinBaru,
                        style: context.bodySmall
                            .withColor(context.destructive)
                            .withWeight(FontWeight.w500),
                      ),
                    ),
                  ],
                ],
              ),
              Gap(15),
              BlocBuilder<MemberProvider, MemberState>(
                buildWhen: (previous, current) =>
                    previous.apiGantiPinStatus != current.apiGantiPinStatus,
                builder: (context, state) {
                  return CustomButton(
                    height: 32,
                    padding: EdgeInsets.zero,
                    width: double.infinity,
                    iconPosition: IconPosition.end,
                    icon: LucideIcons.arrowRight,
                    isLoading: state.apiGantiPinStatus.isLoading,
                    text: "Ganti Pin",
                    onPressed: () {
                      validateAll();
                    },
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
}
