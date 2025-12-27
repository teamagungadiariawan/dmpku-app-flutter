import 'package:dmpku/core/enums/api_status.dart';
import 'package:dmpku/core/helpers/navigator_helper.dart';
import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/system_ui_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/bank_transfer_response.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/widgets/circle_pattern.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/custom_network_image.dart';
import 'package:dmpku/widgets/produk/card_provider_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BuatTiketVaPage extends StatefulWidget {
  static const routeName = '/member/isistok/va/buat_tiket';

  const BuatTiketVaPage({super.key});

  @override
  State<BuatTiketVaPage> createState() => _BuatTiketVaPageState();
}

class _BuatTiketVaPageState extends State<BuatTiketVaPage> {
  final TextEditingController _amountController = TextEditingController();
  VaBankModel? selectedVaBank;

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

  void _selectVaBank(VaBankModel bank) {
    if (selectedVaBank == bank) return;
    setState(() {
      selectedVaBank = bank;
    });
  }

  Future<void> _handleRefresh() async {
    getMemberIsiStokProvider(context).fetchListBankVa();
  }

  @override
  void initState() {
    super.initState();
    // Fetch list VA when page opens if not already loaded
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMemberIsiStokProvider(context).fetchListBankVa();
    });
  }

  void closePage() {
    getMemberIsiStokProvider(context).resetVa();
    pop();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: getTransparentSystemUiOverlayStyle(),
      child: WillPopScope(
        onWillPop: () async {
          debugPrint("WillPopScope: onWillPop");
          closePage();
          return true; // true = izinkan pop
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          bottomNavigationBar: Padding(
            padding: paddingPage.copyWith(bottom: paddingPage.bottom + 10),
            child: BlocBuilder<MemberIsiStokProvider, MemberIsiStokState>(
              builder: (context, state) {
                return CustomButton(
                  text: "Buat Tiket VA",
                  onPressed: () async {
                    var nominal = FromCurrency(_amountController.text);
                    if (nominal < 50000) {
                      showWarningMessage(
                        "Nominal minimal isi stok adalah Rp 50.000",
                      );
                      return;
                    }

                    if (selectedVaBank == null) {
                      showWarningMessage("Pilih bank VA terlebih dahulu.");
                      return;
                    }

                    final success = await getMemberIsiStokProvider(context)
                        .buatTiketVa(
                          idbank: selectedVaBank!.idbank,
                          nominal: nominal,
                        );
                  },
                  isLoading: state.apiBuatVaStatus.isLoading,
                );
              },
            ),
          ),
          body: Column(
            children: [
              _buildHeaderSection(context),
              Gap(5),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Gap(5),
                        // Info Section
                        Padding(
                          padding: paddingPage,
                          child: Container(
                            padding: paddingCard,
                            decoration: BoxDecoration(
                              color: blue[300]!.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: blue[500]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Informasi Virtual Account",
                                  style: context.bodyMedium
                                      .withWeight(FontWeight.w600)
                                      .withColor(blue[600]!),
                                ),
                                Gap(4),
                                Text(
                                  "Metode pembayaran Virtual Account akan dikenakan biaya admin sesuai dengan ketentuan masing-masing bank.",
                                  style: context.captionRegular.withColor(
                                    blue[600]!,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Padding(
                          padding: paddingPage.copyWith(bottom: 0, top: 5),
                          child: Text(
                            "Pilih Bank VA",
                            style: context.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Gap(5),

                        Padding(
                          padding: paddingPage.copyWith(top: 0),
                          child:
                              BlocBuilder<
                                MemberIsiStokProvider,
                                MemberIsiStokState
                              >(
                                buildWhen: (previous, current) =>
                                    previous.listVaBank != current.listVaBank ||
                                    previous.apiGetListVaStatus !=
                                        current.apiGetListVaStatus,
                                builder: (context, state) {
                                  if (state.apiGetListVaStatus.isLoading) {
                                    return const CardProviderListShimmer(
                                      itemCount: 4,
                                    );
                                  }

                                  if (state.listVaBank.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          "Metode pembayaran VA tidak tersedia.",
                                          style: context.bodyMedium,
                                        ),
                                      ),
                                    );
                                  }

                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: state.listVaBank.length,
                                    separatorBuilder: (c, i) => const Gap(10),
                                    itemBuilder: (context, index) {
                                      final bank = state.listVaBank[index];
                                      final isSelected =
                                          selectedVaBank?.idbank == bank.idbank;
                                      return _buildBankItem(
                                        context,
                                        bank,
                                        isSelected,
                                      );
                                    },
                                  );
                                },
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBankItem(
    BuildContext context,
    VaBankModel bank,
    bool isSelected,
  ) {
    return Card(
      margin: EdgeInsets.zero,
      color: bank.status == 1
          ? context.card
          : context.isDarkMode
          ? stone[800]
          : stone[200],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: isSelected
            ? BorderSide(color: context.primary, width: 1.5)
            : BorderSide(color: context.border, width: 1),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          if (bank.status != 1) return;
          _selectVaBank(bank);
        },
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
                child: CustomNetworkImage(size: 25, url: bank.icon),
              ),
              Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bank.value,
                      style: context.bodyMedium.withWeight(FontWeight.w600),
                    ),
                    Gap(4),
                    Text(
                      "Biaya Admin: ${ToCurrency(bank.admin.toString())}",
                      style: context.bodySmall.withColor(
                        context.mutedForeground,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(8),
              if (bank.status != 1)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: context.destructive.withValues(alpha: 0.1),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  child: Text(
                    "Gangguan",
                    style: context.captionRegular.withColor(
                      context.destructive,
                    ),
                  ),
                )
              else
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? context.primary : context.border,
                      width: 2,
                    ),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: isSelected
                      ? Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: context.primary,
                          ),
                        )
                      : null,
                ),
            ],
          ),
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
                title: 'Buat Tiket VA',
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
