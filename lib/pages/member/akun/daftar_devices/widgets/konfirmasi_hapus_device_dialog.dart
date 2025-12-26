import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/device_response.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class KonfirmasiHapusDeviceDialog extends StatefulWidget {
  final DeviceModel device;

  const KonfirmasiHapusDeviceDialog({super.key, required this.device});

  static Future<bool?> show(
    BuildContext context, {
    required DeviceModel device,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      isDismissible: true,
      enableDrag: true,
      builder: (_) => KonfirmasiHapusDeviceDialog(device: device),
    );
  }

  @override
  State<KonfirmasiHapusDeviceDialog> createState() =>
      _KonfirmasiHapusDeviceDialogState();
}

class _KonfirmasiHapusDeviceDialogState
    extends State<KonfirmasiHapusDeviceDialog> {
  String _pinHapusDevice = '';
  String _errorMessage = '';
  final pinController = TextEditingController();
  final focusNode = FocusNode();

  bool validasiPinHapusDevice() {
    // Contoh validasi sederhana: PIN harus 6 digit angka
    final pinRegex = RegExp(r'^\d{6}$');

    if (!pinRegex.hasMatch(_pinHapusDevice)) {
      setState(() {
        _errorMessage = 'PIN harus terdiri dari 6 digit angka.';
      });
      return false;
    }

    return true;
  }

  void onChanged(String value) {
    if (_pinHapusDevice.length == 6 && value.length < 6) {
      // Jika sebelumnya sudah lengkap (6 digit) dan sekarang berkurang,
      // berarti user menghapus karakter, maka fokus dikembalikan ke input
      _clearPin();
    }

    setState(() => _pinHapusDevice = value);
  }

  void onComplete(String value) {
    setState(() => _pinHapusDevice = value);
  }

  /// Clear PIN input dan reset state
  void _clearPin() {
    pinController.clear();
    setState(() => _pinHapusDevice = "");
    focusNode.requestFocus();
  }

  void hapusDevice() async {
    if (validasiPinHapusDevice()) {
      var suc = await getMemberProvider(context).deleteDevice(
        perangkat: widget.device.perangkat,
        pintrx: _pinHapusDevice,
      );

      // var suc = true;

      if (suc) {
        pop();
        showSuccessMessage("Berhasil menghapus perangkat.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final defaultPinTheme = PinTheme(
      width: 48,
      height: 48,
      textStyle: context.pageTitle
          .withColor(context.primary)
          .withWeight(FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: context.primary),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.primary, width: 2),
      borderRadius: BorderRadius.circular(12),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomInset),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
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
              TopDividerSheet(),
              Gap(15),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: context.destructive, width: 1),
                ),
                color: context.destructive.withOpacity(0.3),
                child: Padding(
                  padding: paddingCard,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.isDarkMode
                                  ? stone[700]
                                  : stone[100],
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              MdiIcons.cellphoneRemove,
                              color: context.destructive,
                              size: 14,
                            ),
                          ),
                          Gap(10),

                          Text(
                            'Hapus Perangkat ?',
                            style: context.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Text(
                          'Anda akan menghapus akses untuk ',
                          style: context.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                        width: 400,
                      ),
                      Container(
                        child: Text(
                          '"${widget.device.device}"',
                          style: context.sectionTitle.withWeight(
                            FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        width: 400,
                      ),
                    ],
                  ),
                ),
              ),

              Gap(5),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: context.warning, width: 1),
                ),
                color: context.warning.withOpacity(0.1),
                child: Padding(
                  padding: paddingCard,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(MdiIcons.alert, color: context.warning),
                      Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tindakan ini tidak dapat dibatalkan.',
                              style: context.bodyMedium
                                  .withColor(context.foreground)
                                  .withWeight(FontWeight.w600),
                            ),
                            Gap(3),
                            Text(
                              'Akun Anda akan logout otomatis dari perangkat ini. Anda harus login ulang untuk menggunakannya kembali.',
                              style: context.bodySmall.withColor(
                                context.foreground,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              BlocBuilder<MemberProvider, MemberState>(
                buildWhen: (previous, current) =>
                    previous.apiDeleteMemberDeviceStatus !=
                    current.apiDeleteMemberDeviceStatus,
                builder: (context, state) {
                  var errMsg = state.apiDeleteMemberDeviceMessage;
                  if (_errorMessage.isNotEmpty) {
                    if (errMsg.isNotEmpty) {
                      errMsg = "$errMsg\n$_errorMessage";
                    } else {
                      errMsg = "$_errorMessage";
                    }
                  }

                  if (errMsg.isEmpty) return SizedBox.shrink();

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
                              errMsg,
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
              Gap(10),
              Container(
                child: Text(
                  'Masukkan 6-digit PIN untuk konfirmasi',
                  style: context.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                width: 400,
              ),
              Gap(10),
              Align(
                alignment: Alignment.center,
                child: Pinput(
                  controller: pinController,
                  focusNode: focusNode,
                  obscureText: true,
                  length: 6,
                  autofocus: true,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.disabled,
                  showCursor: true,
                  onCompleted: onComplete,
                  onChanged: onChanged,
                  closeKeyboardWhenCompleted: false,
                  enableSuggestions: false,
                  keyboardType: TextInputType.number,
                ),
              ),
              Gap(15),
              BlocBuilder<MemberProvider, MemberState>(
                buildWhen: (previous, current) =>
                    previous.apiDeleteMemberDeviceStatus !=
                    current.apiDeleteMemberDeviceStatus,
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
                            if (!state.apiLogoutStatus.isLoading) pop();
                          },
                        ),
                      ),
                      Gap(15),
                      Expanded(
                        child: CustomButton(
                          height: 30,
                          padding: EdgeInsets.zero,
                          variant: ButtonVariant.destructive,
                          text: "Hapus Perangkat",
                          isLoading:
                              state.apiDeleteMemberDeviceStatus.isLoading,
                          onPressed: () {
                            hapusDevice();
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
}
