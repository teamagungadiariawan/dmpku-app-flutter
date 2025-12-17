import 'package:dmpku/core/constants/app_info.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/router/app_router.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/pages/auth/loading_splash_page.dart';
import 'package:dmpku/pages/auth/login/login_provider.dart';
import 'package:dmpku/pages/guest/main_page.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_perdana/aktivasi_perdana_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/aktivasi_voucher/aktivasi_voucher_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/cek_status_voucher/cek_status_voucher_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/info_kartu/info_kartu_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/masa_aktif/masa_aktif_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_data/paket_data_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_nelpon/paket_nelpon_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_streaming/paket_streaming_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/paket_tv/paket_tv_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/pulsa/pulsa_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/token_pln/token_pln_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/topup_game/topup_game_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/voucher_data/voucher_data_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/voucher_digital/voucher_digital_provider.dart';
import 'package:dmpku/pages/guest/produk/isiulang/wifi_id/wifi_id_provider.dart';
import 'package:dmpku/pages/guest/produk/paketcuan/paket_cuan_provider.dart';
import 'package:dmpku/pages/member/member_main_page.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_perdana/member_aktivasi_perdana_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/aktivasi_voucher/member_aktivasi_voucher_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/cek_status_voucher/member_cek_status_voucher_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/info_kartu/member_info_kartu_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/masa_aktif/member_masa_aktif_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_data/member_paket_data_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_nelpon/member_paket_nelpon_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_streaming/member_paket_streaming_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/paket_tv/member_paket_tv_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/pulsa/member_pulsa_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/token_pln/member_token_pln_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/topup_game/member_topup_game_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_data/member_voucher_data_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/voucher_digital/member_voucher_digital_provider.dart';
import 'package:dmpku/pages/member/produk/isiulang/wifi_id/member_wifi_id_provider.dart';
import 'package:dmpku/pages/member/produk/paketcuan/paket_cuan_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_kesehatan/member_bpjs_kesehatan_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/bpjs_tkn/member_bpjs_tkn_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/dompet_digital/member_dompet_digital_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/e_commerce/member_e_commerce_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/e_samsat/member_e_samsat_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/hp_pasca/member_hp_pasca_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/internet_tv/member_internet_tv_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/pbb/member_pbb_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/pdam/member_pdam_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/pln_tagihan/member_pln_tagihan_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/tagihan_gas/member_tagihan_gas_provider.dart';
import 'package:dmpku/pages/member/produk/ppob/uang_elektronik/member_uang_elektronik_provider.dart';
import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_provider.dart';
import 'package:dmpku/pages/member/riwayat/member_riwayat_provider.dart';
import 'package:dmpku/provider/member_provider.dart';
import 'package:dmpku/service/guest/informasi_service.dart';
import 'package:dmpku/service_init.dart';
import 'package:dmpku/widgets/dialog/offline_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'core/helpers/connection_helper.dart';
import 'core/helpers/keyboard_helper.dart';
import 'core/helpers/navigator_helper.dart';
import 'core/themes/app_theme.dart';
import 'core/themes/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MaterialApp(home: LoadingSplashPage()));

  // Initialize services and providers concurrently
  final servicesFuture = ServiceInitializer.init();
  final textScaleProvider = TextScaleProvider();
  final textScaleFuture = textScaleProvider.init();
  final informasiFuture = InformasiService().getInformasi();
  final tokenFuture = SecureStorageHelper.instance.getToken();

  Future.wait([
    servicesFuture,
    textScaleFuture,
    informasiFuture,
    tokenFuture,
  ]).then((results) {
    final token = (results[3] as String?) ?? '';
    runApp(
      MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => AktivasiPerdanaProvider()),
          BlocProvider(create: (_) => AktivasiVoucherProvider()),
          BlocProvider(create: (_) => CekStatusVoucherProvider()),
          BlocProvider(create: (_) => InfoKartuProvider()),
          BlocProvider(create: (_) => LoginProvider()),
          BlocProvider(create: (_) => MasaAktifProvider()),
          BlocProvider(create: (_) => PaketCuanProvider()),
          BlocProvider(create: (_) => PaketDataProvider()),
          BlocProvider(create: (_) => PaketNelponProvider()),
          BlocProvider(create: (_) => PaketStreamingProvider()),
          BlocProvider(create: (_) => PaketTvProvider()),
          BlocProvider(create: (_) => PulsaProvider()),
          BlocProvider(create: (_) => TokenPlnProvider()),
          BlocProvider(create: (_) => TopupGameProvider()),
          BlocProvider(create: (_) => VoucherDataProvider()),
          BlocProvider(create: (_) => VoucherDigitalProvider()),
          BlocProvider(create: (_) => WifiIdProvider()),

          BlocProvider(create: (_) => MemberProvider()),
          BlocProvider(create: (_) => TransaksiProsesProvider()),
          BlocProvider(create: (_) => MemberRiwayatProvider()),

          BlocProvider(create: (_) => MemberAktivasiPerdanaProvider()),
          BlocProvider(create: (_) => MemberAktivasiVoucherProvider()),
          BlocProvider(create: (_) => MemberBpjsKesehatanProvider()),
          BlocProvider(create: (_) => MemberBpjsTknProvider()),
          BlocProvider(create: (_) => MemberCekStatusVoucherProvider()),
          BlocProvider(create: (_) => MemberDompetDigitalProvider()),
          BlocProvider(create: (_) => MemberECommerceProvider()),
          BlocProvider(create: (_) => MemberESamsatProvider()),
          BlocProvider(create: (_) => MemberHpPascaProvider()),
          BlocProvider(create: (_) => MemberInfoKartuProvider()),
          BlocProvider(create: (_) => MemberInternetTvProvider()),
          BlocProvider(create: (_) => MemberMasaAktifProvider()),
          BlocProvider(create: (_) => MemberPaketCuanProvider()),
          BlocProvider(create: (_) => MemberPaketDataProvider()),
          BlocProvider(create: (_) => MemberPaketNelponProvider()),
          BlocProvider(create: (_) => MemberPaketStreamingProvider()),
          BlocProvider(create: (_) => MemberPaketTvProvider()),
          BlocProvider(create: (_) => MemberPbbProvider()),
          BlocProvider(create: (_) => MemberPdamProvider()),
          BlocProvider(create: (_) => MemberPlnTagihanProvider()),
          BlocProvider(create: (_) => MemberPulsaProvider()),
          BlocProvider(create: (_) => MemberTagihanGasProvider()),
          BlocProvider(create: (_) => MemberTokenPlnProvider()),
          BlocProvider(create: (_) => MemberTopupGameProvider()),
          BlocProvider(create: (_) => MemberUangElektronikProvider()),
          BlocProvider(create: (_) => MemberVoucherDataProvider()),
          BlocProvider(create: (_) => MemberVoucherDigitalProvider()),
          BlocProvider(create: (_) => MemberWifiIdProvider()),
        ],
        child: MyApp(textScaleProvider: textScaleProvider, token: token),
      ),
    );
  });
}

class MyApp extends StatefulWidget {
  final TextScaleProvider textScaleProvider;
  final String token;

  const MyApp({
    super.key,
    required this.textScaleProvider,
    required this.token,
  });

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ConnectivityService().init(
        navigatorKey: navigatorKey, // Gunakan yang dari navigator_helper.dart
        onOffline: () => OfflineDialog.show(
          navigatorKey.currentContext!,
          onRetry: () => ConnectivityService().retryConnection(),
        ),
      );
    });
  }

  @override
  void dispose() {
    ConnectivityService().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider.value(value: widget.textScaleProvider),
      ],
      child: TextScaleProviderScope(
        provider: widget.textScaleProvider,
        child: Consumer2<ThemeProvider, TextScaleProvider>(
          builder: (context, themeProvider, textScale, child) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                final currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                  closeKeyBoard();
                }
              },
              child: RefreshConfiguration(
                headerBuilder: () => const ClassicHeader(),
                footerBuilder: () => const ClassicFooter(
                  loadingText: "Sedang memuat...",
                  idleText: "Muat lebih banyak",
                  noDataText: "Tidak ada data",
                  failedText: "Gagal memuat data",
                  canLoadingText: "Lepaskan untuk memuat data",
                ),
                child: ToastificationWrapper(
                  child: MaterialApp(
                    title: APPNAME,
                    localizationsDelegates: const [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    debugShowCheckedModeBanner: false,
                    theme: AppTheme.lightTheme,
                    darkTheme: AppTheme.darkTheme,
                    themeMode: themeProvider.themeMode,
                    navigatorKey: navigatorKey,
                    initialRoute: widget.token.isNotEmpty
                        ? MemberMainPage.routeName
                        : MainPage.routeName,
                    supportedLocales: const [Locale('en'), Locale('id')],
                    builder: (context, child) {
                      debugPrint(
                        '=== SCALE: ${MediaQuery.textScalerOf(context).scale(0.8)}',
                      );

                      // Ambil MediaQueryData yang sudah ada (termasuk viewInsets)
                      final existingMediaQuery = MediaQuery.of(context);

                      return MediaQuery(
                        data: existingMediaQuery.copyWith(
                          textScaler: const TextScaler.linear(0.8),
                        ),
                        child: child ?? const SizedBox.shrink(),
                      );
                    },
                    onGenerateRoute: AppRouter.onGenerateRoute,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
