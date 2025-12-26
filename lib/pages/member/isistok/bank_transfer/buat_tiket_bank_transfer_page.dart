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

// import 'package:dmpku/widgets/produk/refreshable_list.dart'; // Gak dipake lagi
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class BuatTiketBankTransferPage extends StatefulWidget {
  static const routeName = '/member/isistok/bank_transfer/buat_tiket';

  const BuatTiketBankTransferPage({super.key});

  @override
  State<BuatTiketBankTransferPage> createState() =>
      _BuatTiketBankTransferPageState();
}

class _BuatTiketBankTransferPageState extends State<BuatTiketBankTransferPage> {
  final TextEditingController _amountController = TextEditingController();
  BankTransferModel selectedBankTransfer = DEFAULT_BANK_TRANSFER_MODEL;

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

  void _selectBankTransfer(BankTransferModel bank) {
    if (selectedBankTransfer == bank) return;
    setState(() {
      selectedBankTransfer = bank;
    });
  }

  Future<void> _handleRefresh() async {
    // Panggil fungsi refresh provider di sini
    getMemberIsiStokProvider(context).fetchListBankTransfer();
  }

  void closePage() {
    getMemberIsiStokProvider(context).resetBankTransfer();
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
                  text: "Buat Tiket",
                  onPressed: () {
                    var nominal = FromCurrency(_amountController.text);
                    if (nominal < 20000) {
                      showWarningMessage(
                        "Nominal minimal isi stok adalah Rp 20.000",
                      );
                      return;
                    }

                    var idbank = selectedBankTransfer.idbank;
                    if (idbank == 0) {
                      showWarningMessage(
                        "Pilih metode isi stok terlebih dahulu.",
                      );
                      return;
                    }

                    getMemberIsiStokProvider(
                      context,
                    ).buatTiketBankTransfer(idbank: idbank, nominal: nominal);
                  },
                  isLoading: state.apiBuatTiketBankStatus.isLoading,
                );
              },
            ),
          ),
          // BODY UTAMA: Pake RefreshIndicator biar tetep bisa tarik layarnya buat refresh
          body: Column(
            children: [
              // 1. Header (Ikut Scroll)
              _buildHeaderSection(context),
              Gap(5),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: _handleRefresh,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    // Pastiin selalu bisa discroll
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Penting",
                                        style: context.bodyMedium
                                            .withWeight(FontWeight.w600)
                                            .withColor(blue[600]!),
                                      ),
                                      Gap(4),
                                      RichText(
                                        text: TextSpan(
                                          style: context.captionRegular
                                              .withColor(blue[600]!),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "\u2022 Isi stok via Transfer Bank ",
                                            ),
                                            TextSpan(
                                              text: "Bebas Biaya Admin.",
                                              style: context.captionRegular
                                                  .withWeight(FontWeight.w600)
                                                  .withColor(blue[600]!),
                                            ),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: context.captionRegular
                                              .withColor(blue[600]!),
                                          children: [
                                            TextSpan(
                                              text:
                                                  "\u2022 Sistem akan memberikan ",
                                            ),
                                            TextSpan(
                                              text: "Kode Unik",
                                              style: context.captionRegular
                                                  .withWeight(FontWeight.w600)
                                                  .withColor(blue[600]!),
                                            ),
                                            TextSpan(
                                              text:
                                                  " Sistem akan memberikan (misal: Rp 20.",
                                            ),
                                            TextSpan(
                                              text: "123",
                                              style: context.captionRegular
                                                  .withWeight(FontWeight.w600)
                                                  .withColor(blue[600]!),
                                            ),
                                            TextSpan(text: ")."),
                                          ],
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          style: context.captionRegular
                                              .withColor(blue[600]!),
                                          children: [
                                            TextSpan(
                                              text: "\u2022 Wajib transfer ",
                                            ),
                                            TextSpan(
                                              text:
                                                  "sesuai nominal tiket hingga 3 digit",
                                              style: context.captionRegular
                                                  .withWeight(FontWeight.w600)
                                                  .withColor(blue[600]!),
                                            ),
                                            TextSpan(
                                              text:
                                                  " terakhir agar saldo masuk otomatis.",
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // 2. Judul Section List
                        Padding(
                          padding: paddingPage.copyWith(bottom: 0, top: 5),
                          child: Text(
                            "Pilih Metode Isi Stok",
                            style: context.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        Gap(5),

                        // 3. List Bank (Standard ListView)
                        // Kita bungkus Padding biar rapi kiri-kanannya
                        Padding(
                          padding: paddingPage.copyWith(top: 0),
                          child:
                              BlocBuilder<
                                MemberIsiStokProvider,
                                MemberIsiStokState
                              >(
                                buildWhen: (previous, current) =>
                                    previous.listBankTransfer !=
                                        current.listBankTransfer ||
                                    previous.apiGetListProviderStatus !=
                                        current.apiGetListProviderStatus,
                                builder: (context, state) {
                                  // Kalo Loading
                                  if (state
                                      .apiGetListProviderStatus
                                      .isLoading) {
                                    return const CardProviderListShimmer(
                                      itemCount: 6,
                                    );
                                  }

                                  // Kalo Kosong/Error
                                  if (state.listBankTransfer.isEmpty) {
                                    return Center(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Text(
                                          "Metode pembayaran tidak tersedia.",
                                          style: context.bodyMedium,
                                        ),
                                      ),
                                    );
                                  }

                                  // Kalo Ada Data -> ListView Builder Biasa
                                  return ListView.separated(
                                    // PENTING: shrinkWrap & physics ini kuncinya
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    padding: EdgeInsets.zero,
                                    itemCount: state.listBankTransfer.length,
                                    separatorBuilder: (c, i) => const Gap(10),
                                    itemBuilder: (context, index) {
                                      final bank =
                                          state.listBankTransfer[index];
                                      final isSelected =
                                          selectedBankTransfer.value ==
                                          bank.value;
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

  // --- WIDGET COMPONENTS (Dipisah biar bersih) ---

  Widget _buildBankItem(
    BuildContext context,
    BankTransferModel bank,
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
          _selectBankTransfer(bank);
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
                      bank.deskripsi,
                      style: context.bodySmall.withColor(
                        context.mutedForeground,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Gap(8),

              // Radio Button Visual
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
                title: 'Buat Tiket Bank Transfer',
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

// Helper Formatter
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
