import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/widgets/circle_pattern.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BuatTiketAlfamartPage extends StatefulWidget {
  static const routeName = '/member/isistok/alfamart/buat_tiket';

  const BuatTiketAlfamartPage({super.key});

  @override
  State<BuatTiketAlfamartPage> createState() => _BuatTiketAlfamartPageState();
}

class _BuatTiketAlfamartPageState extends State<BuatTiketAlfamartPage> {
  final TextEditingController _amountController = TextEditingController();

  final List<String> _quickAmounts = const [
    '20.000',
    '50.000',
    '100.000',
    '200.000',
    '500.000',
    '1.000.000',
  ];

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _setAmount(String value) {
    String rawValue = value == '1 Juta' ? '1.000.000' : value;
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
                text: "Buat Tiket Alfamart",
                onPressed: () async {
                  var nominal = FromCurrency(_amountController.text);
                  if (nominal < 20000) {
                    showWarningMessage(
                      "Nominal minimal isi stok adalah Rp 20.000",
                    );
                    return;
                  }

                  final success = await getMemberIsiStokProvider(
                    context,
                  ).buatTiketAlfamart(nominal: nominal);
                  
                  if (success && mounted) {
                     pop();
                  }
                },
                isLoading: state.apiBuatAlfamartStatus.isLoading,
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
                                    "Informasi Alfamart",
                                    style: context.bodyMedium
                                        .withWeight(FontWeight.w600)
                                        .withColor(blue[600]!),
                                  ),
                                  Gap(4),
                                  Text(
                                    "Metode pembayaran Alfamart akan dikenakan biaya admin sebesar Rp 3.000.",
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
                title: 'Buat Tiket Alfamart',
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
                  "Minimal Deposit Rp 20.000",
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
        final label = (index == 5) ? "1 Juta" : amount;

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
