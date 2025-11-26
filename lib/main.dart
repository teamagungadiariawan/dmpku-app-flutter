import 'package:dmpku/core/constants/app_info.dart';
import 'package:dmpku/core/themes/app_colors.dart';
import 'package:dmpku/core/themes/app_text_styles.dart';
import 'package:dmpku/pages/auth/splash_page.dart';
import 'package:dmpku/pages/guest/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toastification/toastification.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'core/helpers/connection_helper.dart';
import 'core/helpers/keyboard_helper.dart';
import 'core/helpers/navigator_helper.dart';
import 'core/themes/app_theme.dart';
import 'core/themes/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enable Edge-to-Edge on Android 10+
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.yellow,
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  // Initialize TextScaleProvider
  final textScaleProvider = TextScaleProvider();
  await textScaleProvider.init();
  runApp(MyApp(textScaleProvider: textScaleProvider));
}

class MyApp extends StatefulWidget {
  final TextScaleProvider textScaleProvider;

  const MyApp({super.key, required this.textScaleProvider});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = _navigatorKey.currentContext;
      if (context != null) {
        ConnectivityService().init(context);
      }
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
                    initialRoute: SplashPage.routeName,
                    supportedLocales: const [
                      Locale('en'),
                      Locale('id'),
                    ],
                    // Tambahkan ini untuk disable system text scale
                    builder: (context, child) {
                      debugPrint('=== SCALE: ${MediaQuery.textScalerOf(context).scale(0.8)}');

                      return MediaQuery(
                        data: MediaQueryData.fromView(View.of(context)).copyWith(
                          textScaler: const TextScaler.linear(0.8),
                        ),
                        child: child ?? const SizedBox.shrink(),
                      );
                    },
                    onGenerateRoute: (settings) {
                      switch (settings.name) {
                        case SplashPage.routeName:
                          return _customTransitionBottomToTop(
                            child: const SplashPage(),
                          );
                        case MainPage.routeName:
                          return _customTransitionBottomToTop(
                            child: const MainPage(),
                          );
                        default:
                          return null;
                      }
                    },
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

PageTransition _customTransition({required Widget child}) {
  return PageTransition(
    child: child,
    type: PageTransitionType.rightToLeft,
    duration: const Duration(milliseconds: 225),
    reverseDuration: const Duration(milliseconds: 225),
  );
}

PageTransition _customTransitionBottomToTop({required Widget child}) {
  return PageTransition(
    child: child,
    type: PageTransitionType.bottomToTop,
    duration: const Duration(milliseconds: 300),
    reverseDuration: const Duration(milliseconds: 300),
  );
}