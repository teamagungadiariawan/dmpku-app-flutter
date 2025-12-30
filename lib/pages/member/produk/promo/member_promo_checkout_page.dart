import 'package:dmpku/core/enums/tipe_input.dart';
import 'package:dmpku/core/enums/tipe_produk.dart';
import 'package:dmpku/core/themes/app_spacing.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/core/themes/theme_extension.dart';

import 'package:dmpku/core/enums/api_status.dart'; // Added for IsSuccess extension
import 'package:dmpku/pages/member/produk/promo/member_promo_konfirmasi_transaksi_page.dart';
import 'package:dmpku/widgets/custom_button.dart';
import 'package:dmpku/widgets/produk/card_product.dart';

import 'package:dmpku/pages/member/produk/promo/member_promo_provider.dart';
import 'package:dmpku/widgets/card_input_tujuan.dart';
import 'package:dmpku/widgets/custom_app_bar.dart';

import 'package:dmpku/widgets/produk/custom_popup_input_tujuan.dart';
import 'package:dmpku/widgets/shake_widget.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:gap/gap.dart';

class MemberPromoCheckoutPage extends StatefulWidget {
  static const routeName = '/member/produk/promo/checkout';

  const MemberPromoCheckoutPage({super.key});

  @override
  State<MemberPromoCheckoutPage> createState() =>
      _MemberPromoCheckoutPageState();
}

class _MemberPromoCheckoutPageState extends State<MemberPromoCheckoutPage> {
  final shakeKey = GlobalKey<ShakeErrorWidgetState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: context.select<MemberPromoProvider, String>(
          (s) => s.state.selectedProduct.namaproduk,
        ),
        backgroundColor: context.primary,
      ),
      backgroundColor: context.secondary,
      body: BlocListener<MemberPromoProvider, MemberPromoState>(
        listenWhen: (previous, current) =>
            previous.apiCekAkunStatus != current.apiCekAkunStatus,
        listener: (context, state) {
          if (state.apiCekAkunStatus.isSuccess && state.cekAkunData != null) {
            Navigator.pushNamed(
              context,
              MemberPromoKonfirmasiTransaksiPage.routeName,
              arguments: context.read<MemberPromoProvider>(),
            );
          }
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: paddinPageh,
            vertical: paddinPageh,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInputTujuan(context),
              const Gap(16),
              _buildInfo(context),
              const Gap(16),
              _buildProductSummary(context),
              const Gap(16),
              _buildCheckoutButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputTujuan(BuildContext context) {
    return BlocBuilder<MemberPromoProvider, MemberPromoState>(
      buildWhen: (previous, current) =>
          previous.tujuan != current.tujuan ||
          previous.tujuanHasError != current.tujuanHasError,
      builder: (context, state) {
        return CardInputTujuan(
          tujuan: state.tujuan,
          label: 'No Tujuan',
          hasError: state.tujuanHasError,
          errorMessage: state.tujuanErrorMessage,
          isEditable: true,
          hintText: 'Contoh: 08123456789',
          controller: state.tujuanController,
          focusNode: state.tujuanFocusNode,
          onChanged: (value) {
            context.read<MemberPromoProvider>().setTujuan(value);
          },
          onClear: () {
            context.read<MemberPromoProvider>().setTujuan(
              '',
              updateController: true,
            );
          },
          shakeKey: shakeKey,
          showFavoritButton: false,
          isGuest: false,
          tipeProduk:
              TipeProduk.pulsa, // Fallback to pulsa instead of undefined
          tipeInput: TipeInput.numericOnly,
          icon: MdiIcons.cardAccountDetailsOutline,
          suffixWidget: CustomPopupInputTujuan(
            onResult: (val) {
              context.read<MemberPromoProvider>().setTujuan(
                val,
                updateController: true,
              );
            },
            isTempel: true,
            isScan: true,
            isContact: true,
          ),
        );
      },
    );
  }

  Widget _buildInfo(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE0F2F1), // Light teal color
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(MdiIcons.information, size: 16, color: context.primary),
              const Gap(8),
              Text(
                'Keterangan',
                style: context.bodyMedium.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Gap(4),
          Text(
            'Pastikan Nomor tujuan dan Produk yang Anda pilih sudah sesuai jika terdapat kendala silakan hubungi Customer Service 24 Jam kami.',
            style: context.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildProductSummary(BuildContext context) {
    return BlocBuilder<MemberPromoProvider, MemberPromoState>(
      builder: (context, state) {
        final product = state.selectedProduct;
        return CardProduct(
          title: product.namaproduk,
          subtitle: product.deskripsiproduk,
          harga: product.hargaproduk.toString(),
          selected: true,
          isGangguan: product.statusproduk == 0,
          onPress: () {},
        );
      },
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return BlocBuilder<MemberPromoProvider, MemberPromoState>(
      builder: (context, state) {
        final isDisabled =
            state.selectedProduct.idproduk == 0 ||
            (state.selectedProduct.kodeprodukcek.isNotEmpty &&
                state.tujuan.isEmpty);

        return CustomButton(
          text: 'Lanjut Ke Pembelian',
          width: double.infinity,
          state: isDisabled ? ButtonState.disabled : ButtonState.enabled,
          isLoading: state.apiCekAkunStatus.isLoading,
          onPressed: () {
            if (state.selectedProduct.kodeprodukcek.isNotEmpty) {
              context.read<MemberPromoProvider>().cekAkun();
            } else {
              context.read<MemberPromoProvider>().konfirmasiTrx(context);
            }
          },
        );
      },
    );
  }
}
