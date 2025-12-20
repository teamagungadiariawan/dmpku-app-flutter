import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_1/member_cetak_struk_ppob_1_provider.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_2/member_cetak_struk_ppob_2_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AturHargaPpob2Dialog extends StatefulWidget {
  final int initialadmin;

  const AturHargaPpob2Dialog({Key? key, required this.initialadmin})
    : super(key: key);

  static Future<void> show(BuildContext context, {required int initialadmin}) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => AturHargaPpob2Dialog(initialadmin: initialadmin),
    );
  }

  @override
  _AturHargaPpob2DialogState createState() => _AturHargaPpob2DialogState();
}

class _AturHargaPpob2DialogState extends State<AturHargaPpob2Dialog> {
  late TextEditingController _adminController = TextEditingController(
    text: ToCurrency(widget.initialadmin.toString()),
  );

  late int admin = widget.initialadmin;

  @override
  void initState() {
    super.initState();
    _adminController = TextEditingController(
      text: widget.initialadmin.toString(),
    );
  }

  @override
  void dispose() {
    _adminController.dispose();
    super.dispose();
  }

  void onChangeadmin(String value) {
    var admin = FromCurrency(value);
    setState(() {
      this.admin = admin;
    });
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(bottom: bottomInset),
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
              margin: EdgeInsets.symmetric(horizontal: 10.0),
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
                      child: Icon(MdiIcons.cashEdit, size: 16),
                    ),
                    Gap(10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Atur Harga',
                            style: context.bodyMedium.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            'Atur biaya jasa untuk cetak struk.',
                            style: context.captionRegular.withColor(
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
            Gap(10),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child:
                  BlocBuilder<
                    MemberCetakStrukPpob2Provider,
                    MemberCetakStrukPpob2State
                  >(
                    builder: (context, state) {
                      return Card(
                        child: ListView(
                          shrinkWrap: true,
                          // Tambahin ini
                          physics: NeverScrollableScrollPhysics(),
                          // Biar gak bentrok scroll sama modal
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 6.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: context.border,
                                    width: 1,
                                  ),
                                ),
                              ),
                              child: Text(
                                "Detail Biaya",
                                style: context.bodyMedium.withWeight(
                                  FontWeight.w500,
                                ),
                              ),
                            ),
                            _buildItemRow(
                              KeyValue(
                                key: "Tagihan Awal",
                                value: ToCurrency(state.tagihanAwal.toString()),
                              ),
                            ),
                            _buildItemRow(
                              KeyValue(
                                key: "Denda",
                                value: ToCurrency(state.denda.toString()),
                              ),
                            ),
                            _buildItemRow(
                              KeyValue(
                                key: "Admin",
                                value: ToCurrency(state.admin.toString()),
                              ),
                            ),
                            _buildItemRow(
                              KeyValue(
                                key: "Total Tagihan",
                                value: ToCurrency(
                                  state.totalTagihan.toString(),
                                ),
                              ),
                            ),
                            _buildItemRow(
                              KeyValue(
                                key: "Fee",
                                value: ToCurrency(state.fee.toString()),
                              ),
                            ),
                            _buildItemRow(
                              KeyValue(
                                key: "Total Bayar",
                                value: ToCurrency(
                                  state.totalPotongStok.toString(),
                                ),
                              ),
                              isLast: true,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 14.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Admin",
                    style: context.bodyMedium.withWeight(FontWeight.w500),
                  ),
                  Spacer(),
                  BlocBuilder<
                    MemberCetakStrukPpob2Provider,
                    MemberCetakStrukPpob2State
                  >(
                    builder: (context, state) {
                      return CustomButton(
                        text: "Reset",
                        onPressed: () {
                          _updateController(
                            _adminController,
                            ToCurrency(state.admin.toString()),
                          );
                        },
                        height: 25,
                        size: ButtonSize.small,
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        variant: ButtonVariant.border,
                        backgroundColor: context.destructive.withOpacity(0.2),
                        borderColor: context.destructive,
                        textStyle: context.bodySmall
                            .withColor(context.destructive)
                            .withWeight(FontWeight.w500),
                      );
                    },
                  ),
                ],
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: _buildadminField(context),
            ),
            Gap(15),
            Divider(color: context.border, height: 0.5),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Total Bayar Konsumen:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child:
                  BlocBuilder<
                    MemberCetakStrukPpob2Provider,
                    MemberCetakStrukPpob2State
                  >(
                    builder: (context, state) {
                      return _buildTotalBayarField(context, state.tagihanAwal + state.denda);
                    },
                  ),
            ),
            Gap(15),
            Divider(color: context.border, height: 0.5),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                "Fee:",
                style: context.bodyMedium.withWeight(FontWeight.w500),
              ),
            ),
            Gap(10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0),
              child:
                  BlocBuilder<
                    MemberCetakStrukPpob2Provider,
                    MemberCetakStrukPpob2State
                  >(
                    builder: (context, state) {
                      return _buildFeeField(context, state);
                    },
                  ),
            ),
            Gap(15),
            BlocBuilder<
              MemberCetakStrukPpob2Provider,
              MemberCetakStrukPpob2State
            >(
              builder: (context, state) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: CustomButton(
                    height: 32,
                    padding: EdgeInsets.zero,
                    width: double.infinity,
                    iconPosition: IconPosition.end,
                    icon: LucideIcons.arrowRight,
                    text: "Terapkan Admin",
                    onPressed: () {
                      var totalTagihan = state.tagihanAwal +
                          state.denda +
                          admin;

                      List<KeyValue> dataBiaya = [
                        KeyValue(
                          key: "Tagihan Awal",
                          value: ToCurrency(state.tagihanAwal.toString()),
                        ),
                        KeyValue(
                          key: "Denda",
                          value: ToCurrency(state.denda.toString()),
                        ),
                        KeyValue(
                          key: "Admin",
                          value: ToCurrency(admin.toString()),
                        ),
                        KeyValue(
                          key: "Total Tagihan",
                          value: ToCurrency(totalTagihan.toString()),
                        ),
                      ];

                      getMemberCetakStrukPpob2Provider(context)
                        ..setAdmin(admin)
                        ..setDataBiaya(dataBiaya);

                      pop();
                    },
                  ),
                );
              },
            ),

            Gap(15),
          ],
        ),
      ),
    );
  }

  Widget _buildadminField(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(color: context.border, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Text("Rp.", style: context.bodyMedium),
          const Gap(6),
          Expanded(
            child: TextField(
              controller: _adminController,
              onChanged: (value) {
                _updateController(
                  _adminController,
                  ToCurrency(FromCurrency(value).toString()),
                );

                if (value.isEmpty) {
                  _updateController(_adminController, "0");
                  onChangeadmin("0");
                }

                onChangeadmin(_adminController.text);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Contoh : 5.000',
                suffixIcon: _adminController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          onChangeadmin("0");
                          _updateController(_adminController, "0");
                        },
                        child: Icon(
                          MdiIcons.close,
                          size: 18,
                          color: context.foreground,
                        ),
                      )
                    : null,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalBayarField(BuildContext context, int totalTagihan) {
    var ttlBayar = totalTagihan + admin;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(color: context.border, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Text("Rp.", style: context.bodyMedium),
          const Gap(6),
          Expanded(
            child: Text(
              ToCurrency(ttlBayar.toString()),
              style: context.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeeField(
    BuildContext context,
    MemberCetakStrukPpob2State state,
  ) {
    var ttlBayar = state.tagihanAwal + state.denda + admin;
    var fee = ttlBayar - state.totalBayar;

    debugPrint("buildFeeField: totalBayar=${state.totalBayar}");
    debugPrint("buildFeeField: tagihanAwal=${state.tagihanAwal}");
    debugPrint("buildFeeField: denda=${state.denda}");
    debugPrint("buildFeeField: admin=${admin}");
    debugPrint("buildFeeField: fee calculated=${fee}");

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.muted,
        border: Border.all(color: context.border, width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      padding: const EdgeInsets.all(6),
      child: Row(
        children: [
          Text("Rp.", style: context.bodyMedium),
          const Gap(6),
          Expanded(
            child: Text(ToCurrency(fee.toString()), style: context.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildItemRow(KeyValue item, {bool isLast = false}) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: isLast ? Colors.transparent : context.border,
            width: 1,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 150,
            child: Text(item.key ?? '', style: context.bodySmall),
          ),
          Expanded(
            child: Text(
              item.value ?? '',
              style: context.bodySmall.withWeight(FontWeight.w600),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  void _updateController(TextEditingController? controller, String value) {
    controller?.text = value;
    controller?.selection = TextSelection.fromPosition(
      TextPosition(offset: value.length),
    );
  }
}
