import 'package:dmpku/core/helpers/strings_helper.dart';
import 'package:dmpku/core/helpers/toast_helper.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';
import 'package:dmpku/model/kasir_response.dart';
import 'package:dmpku/pages/member/kasir/kasir_provider.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/pages/member/kasir/penjualan/widgets/pilih_pelanggan_kasir_dialog.dart';
import 'package:dmpku/pages/member/kasir/penjualan/widgets/pilih_produk_kasir_dialog.dart';
import 'package:dmpku/pages/member/kasir/penjualan/widgets/tambah_produk_manual_dialog.dart';
import 'package:dmpku/pages/member/kasir/penjualan/widgets/ambil_riwayat_dialog.dart';
import 'package:dmpku/pages/member/kasir/penjualan/widgets/pembayaran_kasir_dialog.dart';
import 'package:dmpku/model/riwayat_response.dart';
import 'package:dmpku/core/enums/api_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class InputPenjualanPage extends StatefulWidget {
  static const routeName = '/member/kasir/input-penjualan';

  const InputPenjualanPage({super.key});

  @override
  State<InputPenjualanPage> createState() => _InputPenjualanPageState();
}

class _InputPenjualanPageState extends State<InputPenjualanPage> {
  String _trxCode = '';

  @override
  void initState() {
    super.initState();
    _generateTrxCode();
    // Fetch data from provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<KasirProvider>().fetchListProduk();
      context.read<KasirProvider>().fetchListPelanggan();
    });
  }

  void _generateTrxCode() {
    final now = DateTime.now();
    _trxCode =
        '#TRX-${now.year}-${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}';
  }

  Future<bool> _showExitConfirmation() async {
    final cartItems = context.read<KasirProvider>().state.cartItems;

    // If cart is empty, allow exit without confirmation
    if (cartItems.isEmpty) {
      return true;
    }

    final result = await showModalBottomSheet<bool>(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) => SafeArea(
        child: Container(
          padding: paddingPage,
          decoration: BoxDecoration(
            color: context.background,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            border: Border.all(color: context.border, width: 1),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Gap(10),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: context.muted,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Gap(15),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side: BorderSide(color: context.warning, width: 1),
                ),
                color: context.warning.withValues(alpha: 0.2),
                child: Padding(
                  padding: paddingCard,
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: context.isDarkMode ? stone[700] : stone[100],
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          MdiIcons.alertCircle,
                          size: 16,
                          color: context.warning,
                        ),
                      ),
                      const Gap(10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Keluar Halaman?',
                              style: context.bodyMedium
                                  .copyWith(fontWeight: FontWeight.w600)
                                  .withColor(context.warning),
                            ),
                            Text(
                              'Keranjang berisi ${cartItems.length} produk. Data akan hilang.',
                              style: context.captionMedium.withColor(
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
              const Gap(10),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      height: 30,
                      padding: EdgeInsets.zero,
                      variant: ButtonVariant.border,
                      borderColor: context.primary,
                      foregroundColor: context.primary,
                      text: "Batal",
                      onPressed: () => Navigator.of(sheetContext).pop(false),
                    ),
                  ),
                  const Gap(15),
                  Expanded(
                    child: CustomButton(
                      height: 30,
                      padding: EdgeInsets.zero,
                      variant: ButtonVariant.destructive,
                      text: "Keluar",
                      onPressed: () {
                        context.read<KasirProvider>().clearCart();
                        Navigator.of(sheetContext).pop(true);
                      },
                    ),
                  ),
                ],
              ),
              const Gap(10),
            ],
          ),
        ),
      ),
    );

    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _showExitConfirmation,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          backgroundColor: context.isDarkMode ? stone[700] : stone[100],
          appBar: CustomAppBar(title: 'INPUT PENJUALAN', showBackButton: true),
          body: BlocListener<KasirProvider, KasirState>(
            listenWhen: (prev, curr) =>
                prev.apiInputPenjualanStatus != curr.apiInputPenjualanStatus,
            listener: (context, state) {
              if (state.apiInputPenjualanStatus == ApiStatus.success) {
                Navigator.of(context).pop(); // Exit InputPenjualanPage
              }
            },
            child: BlocBuilder<KasirProvider, KasirState>(
              builder: (context, state) {
                // Calculate totals locally from state.cartItems
                int totalItems = state.cartItems.fold(
                  0,
                  (sum, item) => sum + item.quantity,
                );
                int totalModal = state.cartItems.fold(
                  0,
                  (sum, item) => sum + (item.produk.hargamodal * item.quantity),
                );
                int totalJual = state.cartItems.fold(
                  0,
                  (sum, item) => sum + (item.produk.hargajual * item.quantity),
                );
                int estimasiLaba = totalJual - totalModal;

                return Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 16,
                      ),
                      color: context.primary,
                      width: double.infinity,
                      child: Text(
                        _trxCode,
                        style: context.bodyExtraSmall.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        padding: paddingPage,
                        children: [
                          _buildPelangganCard(context, state.selectedPelanggan),
                          const Gap(12),
                          if (state.cartItems.isEmpty)
                            Padding(
                              padding: const EdgeInsets.all(32.0),
                              child: Center(
                                child: Text(
                                  "Keranjang Kosong",
                                  style: context.bodyMedium.copyWith(
                                    color: context.mutedForeground,
                                  ),
                                ),
                              ),
                            )
                          else
                            ...state.cartItems.asMap().entries.map((entry) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: _buildProductCard(
                                  context,
                                  entry.value,
                                  entry.key,
                                ),
                              );
                            }),
                          const Gap(80), // Space for bottom section
                        ],
                      ),
                    ),
                    _buildActionButtons(context),
                    _buildBottomSection(
                      context,
                      totalItems,
                      totalModal,
                      estimasiLaba,
                      totalJual,
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPelangganCard(
    BuildContext context,
    PelangganModel? selectedPelanggan,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: _selectPelanggan,
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: paddingCard,
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: context.primary.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    MdiIcons.account,
                    color: context.primary,
                    size: 20,
                  ),
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pelanggan',
                        style: context.bodyExtraSmall.copyWith(
                          color: context.mutedForeground,
                        ),
                      ),
                      Text(
                        selectedPelanggan?.namapelanggan ?? 'Pilih Pelanggan',
                        style: context.bodyMedium.copyWith(
                          color: context.foreground,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.keyboard_arrow_down, color: context.mutedForeground),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, CartItem item, int index) {
    return Container(
      decoration: BoxDecoration(
        color: context.card,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: context.border),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.produk.namaproduk,
                        style: context.bodyMedium.copyWith(
                          color: context.foreground,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(4),
                      Row(
                        children: [
                          Text(
                            'Modal ',
                            style: context.bodyExtraSmall.copyWith(
                              color: context.mutedForeground,
                            ),
                          ),
                          Text(
                            'Rp ${ToCurrency(item.produk.hargamodal.toString())}',
                            style: context.bodyExtraSmall.copyWith(
                              color: context.destructive,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            'Jual: ',
                            style: context.bodyExtraSmall.copyWith(
                              color: context.mutedForeground,
                            ),
                          ),
                          Text(
                            'Rp ${ToCurrency(item.produk.hargajual.toString())}',
                            style: context.bodyExtraSmall.copyWith(
                              color: context.success,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Quantity Controls
                _buildQuantityControls(context, item),
                Gap(5),
                GestureDetector(
                  onTap: () =>
                      context.read<KasirProvider>().removeFromCart(item.produk),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: context.destructive,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: context.border),
                    ),
                    child: Icon(
                      MdiIcons.trashCan,
                      color: context.destructiveForeground,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityControls(BuildContext context, CartItem item) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: context.background,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: context.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildQuantityButton(
            context,
            icon: Icons.remove,
            onTap: () => context.read<KasirProvider>().updateCartQuantity(
              item.produk,
              item.quantity - 1,
            ),
          ),
          Container(
            constraints: const BoxConstraints(minWidth: 40),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              item.quantity.toString(),
              textAlign: TextAlign.center,
              style: context.bodyMedium.copyWith(
                color: context.foreground,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          _buildQuantityButton(
            context,
            icon: Icons.add,
            onTap: () => context.read<KasirProvider>().addToCart(
              item.produk,
              isTemporary: item.isTemporary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 32,
          height: 32,
          alignment: Alignment.center,
          child: Icon(icon, color: context.foreground, size: 18),
        ),
      ),
    );
  }

  Widget _buildBottomSection(
    BuildContext context,
    int totalItems,
    int totalModal,
    int estimasiLaba,
    int totalJual,
  ) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors
            .transparent, // Let parent background show or use card? User said light mode. Bottom sheet usually white.
        // Actually, if scaffold is background (light gray?), bottom sheet should be white (card).
      ),
      child: Container(
        decoration: BoxDecoration(
          color: context.card,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Summary Row
              Row(
                children: [
                  _buildSummaryItem(
                    context,
                    label: 'Total Item',
                    value: '$totalItems pcs',
                    isHighlighted: false,
                  ),
                  _buildSummaryItem(
                    context,
                    label: 'Total Modal',
                    value: 'Rp ${ToCurrency(totalModal.toString())}',
                    valueColor: context.destructive,
                    isHighlighted: false,
                  ),
                  _buildSummaryItem(
                    context,
                    label: 'Est. Laba',
                    value: '+Rp ${ToCurrency(estimasiLaba.toString())}',
                    valueColor: context.success,
                    isHighlighted: false,
                  ),
                ],
              ),
              const Gap(16),
              // Total & Process Button
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Tagihan',
                          style: context.bodySmall.copyWith(
                            color: context.mutedForeground,
                          ),
                        ),
                        Text(
                          'Rp ${ToCurrency(totalJual.toString())}',
                          style: context.headingLarge.copyWith(
                            color: context.foreground,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: CustomButton(
                      text: 'Proses',
                      onPressed: () => _processTransaction(totalJual),
                      icon: Icons.arrow_forward,
                      iconPosition: IconPosition.end,
                      variant: ButtonVariant.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryItem(
    BuildContext context, {
    required String label,
    required String value,
    Color? valueColor,
    required bool isHighlighted,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.bodyExtraSmall.copyWith(
              color: context.mutedForeground,
            ),
          ),
          Text(
            value,
            style: context.bodySmall.copyWith(
              color: valueColor ?? context.foreground,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // Actions
  void _selectPelanggan() {
    PilihPelangganKasirDialog.show(context);
  }

  void _addProduct() {
    PilihProdukKasirDialog.show(context);
  }

  void _processTransaction(int totalTagihan) {
    if (totalTagihan == 0) {
      showWarningMessage("Tagihan 0, tidak bisa memproses pembayaran");
      return;
    }

    final state = context.read<KasirProvider>().state;

    if (state.cartItems.isEmpty) {
      showWarningMessage("Keranjang belanja masih kosong");
      return;
    }

    if (state.selectedPelanggan == null) {
      showWarningMessage("Silakan pilih pelanggan terlebih dahulu");
      return;
    }

    PembayaranKasirDialog.show(context, totalTagihan: totalTagihan);
  }

  Widget _buildActionButtons(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _buildActionButtonItem(
              context,
              icon: MdiIcons.viewList,
              label: "Pilih Produk",
              onTap: _addProduct,
            ),
          ),
          const Gap(8),
          Expanded(
            child: _buildActionButtonItem(
              context,
              icon: MdiIcons.plusBox,
              label: "Manual",
              onTap: () {
                TambahProdukManualDialog.show(context);
              },
            ),
          ),
          const Gap(8),
          Expanded(
            child: _buildActionButtonItem(
              context,
              icon: MdiIcons.history,
              label: "Riwayat Hari Ini",
              onTap: () async {
                final RiwayatModel? riwayat = await AmbilRiwayatDialog.show(
                  context,
                );

                if (riwayat != null) {
                  if (!context.mounted) return;
                  // final provider = context.read<KasirProvider>(); // Unused

                  // Open Manual Dialog with prefilled data
                  TambahProdukManualDialog.show(
                    context,
                    initialNama: "${riwayat.namaproduk} ${riwayat.tujuan}",
                    initialHargaModal: riwayat.totalharga,
                    // User said "harga modal ambil dari total harga", usually for PPOB check/re-sell
                    // this implies cost is the prev price.
                    initialHargaJual: 0,
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtonItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(color: context.primary),
          borderRadius: BorderRadius.circular(8),
          color: context.primary.withValues(alpha: 0.1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 20, color: context.primary),
            const Gap(4),
            Text(
              label,
              style: context.captionMedium
                  .withColor(context.primary)
                  .copyWith(fontWeight: FontWeight.w600, fontSize: 10),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
