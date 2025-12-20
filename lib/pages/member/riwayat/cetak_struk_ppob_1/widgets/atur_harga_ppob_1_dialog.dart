import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/key_value_response.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_1/member_cetak_struk_ppob_1_provider.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/dialog/top_divider_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AturHargaPpob1Dialog extends StatefulWidget {
  final int initialBiayaJasa;

  const AturHargaPpob1Dialog({Key? key, required this.initialBiayaJasa})
    : super(key: key);

  static Future<void> show(
    BuildContext context, {
    required int initialBiayaJasa,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => AturHargaPpob1Dialog(initialBiayaJasa: initialBiayaJasa),
    );
  }

  @override
  _AturHargaPpob1DialogState createState() => _AturHargaPpob1DialogState();
}

class _AturHargaPpob1DialogState extends State<AturHargaPpob1Dialog> {
  late TextEditingController _biayaJasaController = TextEditingController(
    text: ToCurrency(widget.initialBiayaJasa.toString()),
  );

  late int biayaJasa = widget.initialBiayaJasa;

  @override
  void initState() {
    super.initState();
    _biayaJasaController = TextEditingController(
      text: widget.initialBiayaJasa.toString(),
    );
  }

  @override
  void dispose() {
    _biayaJasaController.dispose();
    super.dispose();
  }

  void onChangeBiayaJasa(String value) {
    var biayaJasa = FromCurrency(value);
    setState(() {
      this.biayaJasa = biayaJasa;
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
                    MemberCetakStrukPpob1Provider,
                    MemberCetakStrukPpob1State
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
                    "Biaya Jasa",
                    style: context.bodyMedium.withWeight(FontWeight.w500),
                  ),
                  Spacer(),
                  BlocBuilder<
                    MemberCetakStrukPpob1Provider,
                    MemberCetakStrukPpob1State
                  >(
                    builder: (context, state) {
                      return CustomButton(
                        text: "Reset",
                        onPressed: () {
                          _updateController(
                            _biayaJasaController,
                            ToCurrency(state.biayaJasa.toString()),
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
              child: _buildBiayaJasaField(context),
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
                    MemberCetakStrukPpob1Provider,
                    MemberCetakStrukPpob1State
                  >(
                    builder: (context, state) {
                      return _buildTotalBayarField(context, state.totalTagihan);
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
                    MemberCetakStrukPpob1Provider,
                    MemberCetakStrukPpob1State
                  >(
                    builder: (context, state) {
                      return _buildFeeField(
                        context,
                        state.totalTagihan,
                        state.totalPotongStok,
                      );
                    },
                  ),
            ),
            Gap(15),
            BlocBuilder<
              MemberCetakStrukPpob1Provider,
              MemberCetakStrukPpob1State
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
                    text: "Terapkan Biaya Jasa",
                    onPressed: () {
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
                          value: ToCurrency(state.admin.toString()),
                        ),
                        KeyValue(
                          key: "Total Tagihan",
                          value: ToCurrency(state.totalTagihan.toString()),
                        ),
                        KeyValue(
                          key: "Biaya Jasa",
                          value: ToCurrency(biayaJasa.toString()),
                        ),
                      ];

                      getMemberCetakStrukPpob1Provider(context)
                        ..setBiayaJasa(ToCurrency(biayaJasa.toString()))
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

  Widget _buildBiayaJasaField(BuildContext context) {
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
              controller: _biayaJasaController,
              onChanged: (value) {
                _updateController(
                  _biayaJasaController,
                  ToCurrency(FromCurrency(value).toString()),
                );

                if (value.isEmpty) {
                  _updateController(_biayaJasaController, "0");
                  onChangeBiayaJasa("0");
                }

                onChangeBiayaJasa(_biayaJasaController.text);
              },
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Contoh : 5.000',
                suffixIcon: _biayaJasaController.text.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          onChangeBiayaJasa("0");
                          _updateController(_biayaJasaController, "0");
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
    var ttlBayar = totalTagihan + biayaJasa;

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
    int totalTagihan,
    int totalBayar,
  ) {
    var ttlBayar = totalTagihan + biayaJasa;
    var fee = ttlBayar - totalBayar;

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
