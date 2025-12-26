import 'package:dmpku/core/constants/app_info.dart';
import 'package:dmpku/core/helpers/storage_helper.dart';
import 'package:dmpku/core/router/app_router.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/pages/auth/loading_splash_page.dart';
import 'package:dmpku/pages/auth/login/login_provider.dart';
import 'package:dmpku/pages/guest/main_page.dart';

import 'package:dmpku/pages/member/akun/favorit/member_favorit_provider.dart';
import 'package:dmpku/pages/member/isistok/member_isi_stok_provider.dart';
import 'package:dmpku/pages/member/member_main_page.dart';

import 'package:dmpku/pages/member/produk/transaksi_proses/transaksi_proses_provider.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_elektrik/member_cetak_struk_elektrik_provider.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_nominal/member_cetak_struk_nominal_bebas_provider.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_1/member_cetak_struk_ppob_1_provider.dart';
import 'package:dmpku/pages/member/riwayat/cetak_struk_ppob_2/member_cetak_struk_ppob_2_provider.dart';
import 'package:dmpku/pages/member/riwayat/detail_riwayat/member_detail_riwayat_provider.dart';
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
          BlocProvider(create: (_) => LoginProvider()),

          BlocProvider(create: (_) => MemberProvider()),
          BlocProvider(create: (_) => MemberFavoritProvider()),
          BlocProvider(create: (_) => TransaksiProsesProvider()),
          BlocProvider(create: (_) => MemberCetakStrukElektrikProvider()),
          BlocProvider(create: (_) => MemberCetakStrukNominalBebasProvider()),
          BlocProvider(create: (_) => MemberCetakStrukPpob1Provider()),
          BlocProvider(create: (_) => MemberCetakStrukPpob2Provider()),
          BlocProvider(create: (_) => MemberDetailRiwayatProvider()),
          BlocProvider(create: (_) => MemberRiwayatProvider()),

          BlocProvider(create: (_) => MemberIsiStokProvider()),
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
