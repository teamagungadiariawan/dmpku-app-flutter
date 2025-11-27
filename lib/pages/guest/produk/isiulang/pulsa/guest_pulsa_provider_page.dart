import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class GuestPulsaProviderPage extends StatefulWidget {
  static const routeName = '/guest/produk/isiulang/pulsa/provider';

  const GuestPulsaProviderPage({super.key});

  @override
  State<GuestPulsaProviderPage> createState() => _GuestPulsaProviderPageState();
}

class _GuestPulsaProviderPageState extends State<GuestPulsaProviderPage> {
  late bool _hasError = false;

  void toggleError() {
    setState(() {
      _hasError = !_hasError;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: Scaffold(
        appBar: CustomAppBar(title: "Pilih Provider Pulsa"),
        body: Padding(
          padding: EdgeInsetsGeometry.symmetric(
            horizontal: 16.0,
            vertical: 6.0,
          ),
          child: Column(
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "No. Tujuan",
                        style: context.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Gap(5),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: context.muted,
                          border: Border.all(color: context.border, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        padding: EdgeInsets.all(6),
                        child: Row(
                          children: [
                            Icon(
                              MdiIcons.clipboardAccount,
                              size: 18,
                              color: context.foreground,
                            ),
                            Gap(6),
                            Expanded(
                              child: TextField(
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                decoration: InputDecoration(
                                  isDense: true,
                                  border: InputBorder.none,
                                  focusedBorder: InputBorder.none,
                                  enabledBorder: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  disabledBorder: InputBorder.none,
                                  hintText: 'Masukkan No. Tujuan',
                                  contentPadding: EdgeInsets.zero,
                                  hoverColor: Colors.transparent,
                                  fillColor: Colors.transparent,
                                  focusColor: Colors.transparent,
                                ),
                              ),
                            ),
                            Gap(6),
                            SizedBox(
                              height: 18,
                              width: 12,
                              child: PopupMenuButton<String>(
                                icon: Icon(Icons.more_vert, size: 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                padding: EdgeInsets.zero,
                                menuPadding: EdgeInsets.zero,
                                itemBuilder: (BuildContext context) {
                                  return [
                                    PopupMenuItem<String>(
                                      value: 'option1',
                                      child: Text('Pilih dari Kontak'),
                                    ),
                                    PopupMenuItem<String>(
                                      value: 'option2',
                                      child: Text('Riwayat Transaksi'),
                                    ),
                                  ];
                                },
                                onSelected: (String value) {
                                  // Handle menu item selection
                                },
                              ),
                            ),
                          ],
                        ),
                      ).withErrorShake(
                        hasError: _hasError,
                        onShakeComplete: () {
                          setState(() {
                            _hasError = false;
                          });
                        },
                      ),
                      Gap(5),
                      CustomButton(
                        height: 25,
                        padding: EdgeInsets.zero,
                        text: "Test",
                        onPressed: () {
                          toggleError();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
