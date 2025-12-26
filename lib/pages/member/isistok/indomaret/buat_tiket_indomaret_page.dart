import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/gen/assets.gen.dart' show Assets;
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/widgets/circle_pattern.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/custom_local_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BuatTiketIndomaretPage extends StatefulWidget {
  static const routeName = '/member/isistok/indomaret/buat_tiket';

  const BuatTiketIndomaretPage({super.key});

  @override
  State<BuatTiketIndomaretPage> createState() => _BuatTiketIndomaretPageState();
}

class _BuatTiketIndomaretPageState extends State<BuatTiketIndomaretPage> {
  final TextEditingController _amountController = TextEditingController();

  final List<String> _quickAmounts = const [
    '50.000',
    '100.000',
    '200.000',
    '500.000',
    '1.000.000',
    '2.000.000',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _setAmount(String value) {
    String rawValue = value == '1 Juta' ? '1.000.000' : value;
    rawValue = value == '2 Juta' ? '2.000.000' : value;
    _amountController.value = TextEditingValue(
      text: rawValue,
      selection: TextSelection.collapsed(offset: rawValue.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: Padding(
          padding: paddingPage.copyWith(bottom: paddingPage.bottom + 10),
          child: BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
            builder: (context, state) {
              return CustomButton(
                text: "Buat Tiket Indomaret",
                onPressed: () async {
                  var nominal = FromCurrency(_amountController.text);
                  if (nominal < 50000) {
                    showWarningMessage(
                      "Nominal minimal isi stok adalah Rp 50.000",
                    );
                    return;
                  }

                  final success = await getMemberIsiStokProvider(
                    context,
                  ).buatTiketIndomaret(nominal: nominal);
                },
                isLoading: state.apiBuatIndomaretStatus.isLoading,
              );
            },
          ),
        ),
        body: Column(
          children: [
            _buildHeaderSection(context),
            Gap(5),
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(5),
                    Padding(
                      padding: paddingPage,
                      child: Container(
                        padding: paddingCard,
                        decoration: BoxDecoration(
                          color: blue[300]!.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: blue[500]!),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              MdiIcons.informationSlabCircle,
                              color: blue[600]!,
                              size: 20,
                            ),
                            Gap(5),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Informasi Indomaret",
                                    style: context.bodyMedium
                                        .withWeight(FontWeight.w600)
                                        .withColor(blue[600]!),
                                  ),
                                  Gap(4),
                                  Text(
                                    "Metode pembayaran Indomaret akan dikenakan biaya admin sebesar Rp 3.500.",
                                    style: context.captionRegular.withColor(
                                      blue[600]!,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      margin: paddingPage,
                      color: context.card,

                      child: Padding(
                        padding: paddingCard,
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: context.border),
                                color: context.primary.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: CustomLocalImage(
                                size: 25,
                                imagePath:
                                    Assets.img.bank.icMethodIndomaret.path,
                              ),
                            ),
                            Gap(12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Indomaret",
                                    style: context.bodyMedium.withWeight(
                                      FontWeight.w600,
                                    ),
                                  ),
                                  Gap(4),
                                  Text(
                                    "Metode pembayaran Indomaret akan dikenakan biaya admin sebesar Rp 3.500.",
                                    style: context.bodySmall.withColor(
                                      context.mutedForeground,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      color: context.primary,
      child: Stack(
        children: [
          Positioned.fill(
            child: RhombusPattern(
              color: Colors.black.withValues(alpha: 0.05),
              radius: 4,
              spacing: 30,
              isStaggered: false,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppBar(
                backgroundColor: Colors.transparent,
                title: 'Buat Tiket Indomaret',
                onBackButtonPressed: pop,
              ),
              Padding(
                padding: paddingPage,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nominal Tiket",
                      style: context.bodyMedium
                          .withColor(Colors.white)
                          .withWeight(FontWeight.w600),
                    ),
                    Gap(8),
                    _buildInputCard(context),
                    Gap(20),
                    _buildQuickAmountGrid(context),
                    Gap(10),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInputCard(BuildContext context) {
    return BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          padding: paddingCard,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.white54),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Rp ",
                    style: context.sectionTitle
                        .withColor(Colors.white)
                        .withWeight(FontWeight.w600),
                  ),
                  Expanded(
                    child: Theme(
                      data: Theme.of(context).copyWith(
                        textSelectionTheme: TextSelectionThemeData(
                          selectionColor: Colors.white.withValues(alpha: 0.3),
                          selectionHandleColor: Colors.white,
                          cursorColor: Colors.white,
                        ),
                      ),
                      child: TextField(
                        focusNode: state.focusNodeNominal,
                        autofocus: true,
                        textAlign: TextAlign.right,
                        controller: _amountController,
                        style: GoogleFonts.inconsolata(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.zero,
                          isDense: true,
                          hintText: '0',
                          hintStyle: TextStyle(color: Colors.white60),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Gap(8),
              const Divider(color: Colors.white54, height: 1, thickness: 0.6),
              Gap(8),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Minimal Deposit Rp 50.000",
                  textAlign: TextAlign.right,
                  style: context.bodyMedium.withColor(Colors.white),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildQuickAmountGrid(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 16 / 5,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: _quickAmounts.length,
      itemBuilder: (context, index) {
        final amount = _quickAmounts[index];
        String label = amount;
        if (amount == '1.000.000') label = "1 Juta";
        if (amount == '2.000.000') label = "2 Juta";

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () => _setAmount(amount),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              decoration: BoxDecoration(
                color: context.card,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: context.border, width: 1),
              ),
              alignment: Alignment.center,
              child: Text(
                label,
                style: context.bodyLarge.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        );
      },
    );
  }
}

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.selection.baseOffset == 0) return newValue;
    String newText = newValue.text.replaceAll('.', '');
    if (newText.isEmpty) return newValue;
    final intValue = int.tryParse(newText) ?? 0;
    final formatter = NumberFormat('#,###', 'id_ID');
    String newString = formatter.format(intValue).replaceAll(',', '.');
    return newValue.copyWith(
      text: newString,
      selection: TextSelection.collapsed(offset: newString.length),
    );
  }
}
