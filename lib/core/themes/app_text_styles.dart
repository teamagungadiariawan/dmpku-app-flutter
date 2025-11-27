import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_colors.dart';

// ==================== FONT FAMILY ====================

class FontFamily {
  static const String poppins = 'Poppins';
  static const String roboto = 'Roboto';
  static const String inter = 'Inter';
  static const String lato = 'Lato';
}

// ==================== TEXT SCALE ====================

class TextScaleFactor {
  static const double extraSmall = 0.8;
  static const double small = 0.9;
  static const double normal = 1.0;
  static const double large = 1.15;
  static const double extraLarge = 1.3;
  static const double huge = 1.5;
}

enum TextScaleOption {
  extraSmall(0.8, 'Extra Small'),
  small(0.9, 'Small'),
  normal(1.0, 'Normal'),
  large(1.15, 'Large'),
  extraLarge(1.3, 'Extra Large'),
  huge(1.5, 'Huge');

  final double factor;
  final String label;

  const TextScaleOption(this.factor, this.label);

  static TextScaleOption fromFactor(double factor) {
    for (final option in TextScaleOption.values) {
      if ((option.factor - factor).abs() < 0.05) {
        return option;
      }
    }
    return TextScaleOption.normal;
  }

  static TextScaleOption fromString(String? value) {
    if (value == null) return TextScaleOption.normal;
    return TextScaleOption.values.firstWhere(
          (e) => e.name == value,
      orElse: () => TextScaleOption.normal,
    );
  }
}

// ==================== TEXT SCALE PROVIDER ====================

class TextScaleProvider extends ChangeNotifier {
  static const String _prefKey = 'text_scale_option';

  late SharedPreferences _prefs;
  double _scaleFactor = TextScaleFactor.normal;
  TextScaleOption _scaleOption = TextScaleOption.normal;
  bool _isInitialized = false;

  double get scaleFactor => _scaleFactor;
  TextScaleOption get scaleOption => _scaleOption;
  bool get isInitialized => _isInitialized;

  // ========== Initialize dari SharedPreferences ==========
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    final savedOption = _prefs.getString(_prefKey);
    _scaleOption = TextScaleOption.fromString(savedOption);
    _scaleFactor = _scaleOption.factor;
    _isInitialized = true;
    notifyListeners();
  }

  // ========== Set Scale Option ==========
  Future<void> setScaleOption(TextScaleOption option) async {
    if (_scaleOption == option) return;

    _scaleOption = option;
    _scaleFactor = option.factor;
    await _prefs.setString(_prefKey, option.name);
    notifyListeners();
  }

  // ========== Set Custom Scale Factor ==========
  Future<void> setScaleFactor(double factor) async {
    final clampedFactor = factor.clamp(0.5, 2.0);
    _scaleFactor = clampedFactor;
    _scaleOption = TextScaleOption.fromFactor(clampedFactor);
    await _prefs.setString(_prefKey, _scaleOption.name);
    notifyListeners();
  }

  // ========== Increase Scale ==========
  Future<void> increaseScale() async {
    final currentIndex = TextScaleOption.values.indexOf(_scaleOption);
    if (currentIndex < TextScaleOption.values.length - 1) {
      await setScaleOption(TextScaleOption.values[currentIndex + 1]);
    }
  }

  // ========== Decrease Scale ==========
  Future<void> decreaseScale() async {
    final currentIndex = TextScaleOption.values.indexOf(_scaleOption);
    if (currentIndex > 0) {
      await setScaleOption(TextScaleOption.values[currentIndex - 1]);
    }
  }

  // ========== Reset Scale ==========
  Future<void> resetScale() async {
    await setScaleOption(TextScaleOption.normal);
  }
}

// ==================== TEXT STYLES - COLORS (Light Theme) ====================

class LightColorTextStyles {
  static const TextStyle foregroundTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    color: AppColors.lightForeground,
  );

  static const TextStyle primaryTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    color: AppColors.lightPrimary,
  );

  static const TextStyle secondaryTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    color: AppColors.lightSecondary,
  );

  static const TextStyle mutedTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    color: AppColors.lightMutedForeground,
  );

  static const TextStyle destructiveTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    color: AppColors.lightDestructive,
  );

  static const TextStyle cardForegroundTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    color: AppColors.lightCardForeground,
  );
}

// ==================== TEXT STYLES - COLORS (Dark Theme) ====================

class DarkColorTextStyles {
  static const TextStyle foregroundTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    color: AppColors.darkForeground,
  );

  static const TextStyle primaryTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    color: AppColors.darkPrimary,
  );

  static const TextStyle secondaryTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    color: AppColors.darkSecondary,
  );

  static const TextStyle mutedTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    color: AppColors.darkMutedForeground,
  );

  static const TextStyle destructiveTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    color: AppColors.darkDestructive,
  );

  static const TextStyle cardForegroundTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    color: AppColors.darkCardForeground,
  );
}

// ==================== TEXT STYLES - FONT SIZES ====================

class FontSizeTextStyles {
  // ========== Extra Small (10-12px) ==========
  static const TextStyle extraSmallRegular = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 10,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle extraSmallMedium = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 10,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle extraSmallSemiBold = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 10,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle captionTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 12,
    fontWeight: FontWeight.w400,
  );

  // ========== Small (14px) ==========
  static const TextStyle smallRegular = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle smallMedium = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle smallSemiBold = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  // ========== Medium (16px) ==========
  static const TextStyle mediumRegular = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle mediumMedium = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle mediumSemiBold = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  // ========== Large (18px) ==========
  static const TextStyle largeRegular = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 18,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle largeMedium = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle largeSemiBold = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle subheadingTextStyle = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // ========== Extra Large (20px) ==========
  static const TextStyle extraLargeRegular = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 20,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle extraLargeMedium = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle extraLargeSemiBold = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  // ========== Heading ==========
  static const TextStyle heading1 = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 24,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle heading2 = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle heading3 = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  // ========== Display ==========
  static const TextStyle display1 = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 28,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle display2 = TextStyle(
    fontFamily: FontFamily.poppins,
    fontSize: 32,
    fontWeight: FontWeight.w700,
  );
}

// ==================== HELPER EXTENSION WITH SCALING ====================

class AppTextHeightBehavior {
  // Menghilangkan padding atas dan bawah dari font
  static const TextHeightBehavior noPadding = TextHeightBehavior(
    applyHeightToFirstAscent: false,
    applyHeightToLastDescent: false,
    leadingDistribution: TextLeadingDistribution.even,
  );
}

extension TextStyleHelperExtension on BuildContext {
  // ========== Private Helper ==========
  bool get _isDark => Theme.of(this).brightness == Brightness.dark;

  double get _scale {
    try {
      final provider = TextScaleProviderScope.of(this);
      return provider?.scaleFactor ?? 1.0;
    } catch (_) {
      return 1.0;
    }
  }

  TextStyle _scaled(TextStyle style) {
    return style.copyWith(fontSize: (style.fontSize ?? 14) * _scale);
  }

  // ==================== DISPLAY STYLES ====================

  TextStyle get displayLarge => _scaled(FontSizeTextStyles.display2.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  TextStyle get displayMedium => _scaled(FontSizeTextStyles.display1.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  // ==================== HEADING STYLES ====================

  TextStyle get headingLarge => _scaled(FontSizeTextStyles.heading1.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  TextStyle get headingMedium => _scaled(FontSizeTextStyles.heading2.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  TextStyle get headingSmall => _scaled(FontSizeTextStyles.heading3.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  TextStyle get pageTitle => headingLarge;
  TextStyle get sectionTitle => headingMedium;
  TextStyle get subSectionTitle => headingSmall;

  // ==================== BODY STYLES ====================

  TextStyle get bodyLarge => _scaled(FontSizeTextStyles.largeRegular.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  TextStyle get bodyMedium => _scaled(FontSizeTextStyles.mediumRegular.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  TextStyle get bodySmall => _scaled(FontSizeTextStyles.smallRegular.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  TextStyle get bodyExtraSmall => _scaled(FontSizeTextStyles.captionTextStyle.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  // ==================== LABEL STYLES ====================

  TextStyle get labelLarge => _scaled(FontSizeTextStyles.smallSemiBold.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  TextStyle get labelMedium => _scaled(FontSizeTextStyles.smallMedium.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  TextStyle get labelSmall => _scaled(FontSizeTextStyles.extraSmallMedium.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  // ==================== MUTED / HINT STYLES ====================

  TextStyle get mutedLarge => _scaled(FontSizeTextStyles.largeRegular.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  TextStyle get mutedMedium => _scaled(FontSizeTextStyles.mediumRegular.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  TextStyle get mutedSmall => _scaled(FontSizeTextStyles.smallRegular.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  TextStyle get hintStyle => mutedSmall;

  // ==================== CAPTION STYLES ====================

  TextStyle get captionRegular => _scaled(FontSizeTextStyles.captionTextStyle.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  TextStyle get captionMedium => _scaled(FontSizeTextStyles.captionTextStyle.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
    fontWeight: FontWeight.w500,
  ));

  // ==================== BUTTON STYLES ====================

  TextStyle get buttonLarge => _scaled(FontSizeTextStyles.mediumSemiBold.copyWith(
    color: _isDark ? AppColors.darkPrimaryForeground : AppColors.lightPrimaryForeground,
  ));

  TextStyle get buttonMedium => _scaled(FontSizeTextStyles.smallSemiBold.copyWith(
    color: _isDark ? AppColors.darkPrimaryForeground : AppColors.lightPrimaryForeground,
  ));

  TextStyle get buttonSmall => _scaled(FontSizeTextStyles.extraSmallSemiBold.copyWith(
    color: _isDark ? AppColors.darkPrimaryForeground : AppColors.lightPrimaryForeground,
  ));

  // ==================== LINK STYLES ====================

  TextStyle get linkLarge => _scaled(FontSizeTextStyles.largeRegular.copyWith(
    color: _isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
    decoration: TextDecoration.underline,
  ));

  TextStyle get linkMedium => _scaled(FontSizeTextStyles.mediumRegular.copyWith(
    color: _isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
    decoration: TextDecoration.underline,
  ));

  TextStyle get linkSmall => _scaled(FontSizeTextStyles.smallRegular.copyWith(
    color: _isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
    decoration: TextDecoration.underline,
  ));

  // ==================== ERROR STYLES ====================

  TextStyle get errorLarge => _scaled(FontSizeTextStyles.smallRegular.copyWith(
    color: _isDark ? AppColors.darkDestructive : AppColors.lightDestructive,
  ));

  TextStyle get errorMedium => _scaled(FontSizeTextStyles.captionTextStyle.copyWith(
    color: _isDark ? AppColors.darkDestructive : AppColors.lightDestructive,
  ));

  TextStyle get errorSmall => _scaled(FontSizeTextStyles.extraSmallRegular.copyWith(
    color: _isDark ? AppColors.darkDestructive : AppColors.lightDestructive,
  ));

  TextStyle get errorMessage => errorMedium;

  // ==================== SUCCESS STYLES ====================

  TextStyle get successLarge => _scaled(FontSizeTextStyles.smallRegular.copyWith(
    color: _isDark ? AppColors.darkSuccess : AppColors.lightSuccess,
  ));

  TextStyle get successMedium => _scaled(FontSizeTextStyles.captionTextStyle.copyWith(
    color: _isDark ? AppColors.darkSuccess : AppColors.lightSuccess,
  ));

  TextStyle get successSmall => _scaled(FontSizeTextStyles.extraSmallRegular.copyWith(
    color: _isDark ? AppColors.darkSuccess : AppColors.lightSuccess,
  ));

  // ==================== WARNING STYLES ====================

  TextStyle get warningLarge => _scaled(FontSizeTextStyles.smallRegular.copyWith(
    color: _isDark ? AppColors.darkWarning : AppColors.lightWarning,
  ));

  TextStyle get warningMedium => _scaled(FontSizeTextStyles.captionTextStyle.copyWith(
    color: _isDark ? AppColors.darkWarning : AppColors.lightWarning,
  ));

  TextStyle get warningSmall => _scaled(FontSizeTextStyles.extraSmallRegular.copyWith(
    color: _isDark ? AppColors.darkWarning : AppColors.lightWarning,
  ));

  // ==================== PRIMARY COLOR STYLES ====================

  TextStyle get primaryLarge => _scaled(FontSizeTextStyles.largeRegular.copyWith(
    color: _isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
  ));

  TextStyle get primaryMedium => _scaled(FontSizeTextStyles.mediumRegular.copyWith(
    color: _isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
  ));

  TextStyle get primarySmall => _scaled(FontSizeTextStyles.smallRegular.copyWith(
    color: _isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
  ));

  // ==================== SECONDARY COLOR STYLES ====================

  TextStyle get secondaryLarge => _scaled(FontSizeTextStyles.largeRegular.copyWith(
    color: _isDark ? AppColors.darkSecondary : AppColors.lightSecondary,
  ));

  TextStyle get secondaryMedium => _scaled(FontSizeTextStyles.mediumRegular.copyWith(
    color: _isDark ? AppColors.darkSecondary : AppColors.lightSecondary,
  ));

  TextStyle get secondarySmall => _scaled(FontSizeTextStyles.smallRegular.copyWith(
    color: _isDark ? AppColors.darkSecondary : AppColors.lightSecondary,
  ));

  // ==================== INPUT STYLES ====================

  TextStyle get inputText => _scaled(FontSizeTextStyles.mediumRegular.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  TextStyle get inputHint => _scaled(FontSizeTextStyles.mediumRegular.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  TextStyle get inputLabel => _scaled(FontSizeTextStyles.smallMedium.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  TextStyle get inputError => errorMedium;

  // ==================== CARD STYLES ====================

  TextStyle get cardTitle => _scaled(FontSizeTextStyles.mediumSemiBold.copyWith(
    color: _isDark ? AppColors.darkCardForeground : AppColors.lightCardForeground,
  ));

  TextStyle get cardSubtitle => _scaled(FontSizeTextStyles.smallRegular.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  TextStyle get cardBody => _scaled(FontSizeTextStyles.smallRegular.copyWith(
    color: _isDark ? AppColors.darkCardForeground : AppColors.lightCardForeground,
  ));

  // ==================== LIST TILE STYLES ====================

  TextStyle get listTitle => _scaled(FontSizeTextStyles.mediumMedium.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  TextStyle get listSubtitle => _scaled(FontSizeTextStyles.smallRegular.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  TextStyle get listTrailing => _scaled(FontSizeTextStyles.smallMedium.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  // ==================== DIALOG STYLES ====================

  TextStyle get dialogTitle => _scaled(FontSizeTextStyles.largeSemiBold.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  TextStyle get dialogContent => _scaled(FontSizeTextStyles.mediumRegular.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  TextStyle get dialogAction => _scaled(FontSizeTextStyles.smallSemiBold.copyWith(
    color: _isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
  ));

  // ==================== BADGE / CHIP STYLES ====================

  TextStyle get badgeText => _scaled(FontSizeTextStyles.extraSmallSemiBold.copyWith(
    color: _isDark ? AppColors.darkPrimaryForeground : AppColors.lightPrimaryForeground,
  ));

  TextStyle get chipText => _scaled(FontSizeTextStyles.smallMedium.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  // ==================== TAB / NAV STYLES ====================

  TextStyle get tabLabel => _scaled(FontSizeTextStyles.smallMedium.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  TextStyle get tabLabelActive => _scaled(FontSizeTextStyles.smallSemiBold.copyWith(
    color: _isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
  ));

  TextStyle get navLabel => _scaled(FontSizeTextStyles.extraSmallMedium.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  TextStyle get navLabelActive => _scaled(FontSizeTextStyles.extraSmallSemiBold.copyWith(
    color: _isDark ? AppColors.darkPrimary : AppColors.lightPrimary,
  ));

  // ==================== TIMESTAMP / META STYLES ====================

  TextStyle get timestamp => _scaled(FontSizeTextStyles.extraSmallRegular.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  TextStyle get metaInfo => _scaled(FontSizeTextStyles.captionTextStyle.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  // ==================== TOOLTIP / OVERLAY STYLES ====================

  TextStyle get tooltipText => _scaled(FontSizeTextStyles.smallRegular.copyWith(
    color: _isDark ? AppColors.darkForeground : AppColors.lightForeground,
  ));

  // ==================== EMPTY STATE STYLES ====================

  TextStyle get emptyStateTitle => _scaled(FontSizeTextStyles.largeSemiBold.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));

  TextStyle get emptyStateMessage => _scaled(FontSizeTextStyles.mediumRegular.copyWith(
    color: _isDark ? AppColors.darkMutedForeground : AppColors.lightMutedForeground,
  ));
}

// ==================== TEXT SCALE PROVIDER SCOPE ====================

class TextScaleProviderScope extends InheritedNotifier<TextScaleProvider> {
  const TextScaleProviderScope({
    super.key,
    required TextScaleProvider provider,
    required super.child,
  }) : super(notifier: provider);

  static TextScaleProvider? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TextScaleProviderScope>()
        ?.notifier;
  }
}

// ==================== TEXT STYLE EXTENSION ====================

extension TextStyleExtension on TextStyle {
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle withSize(double fontSize) => copyWith(fontSize: fontSize);
  TextStyle withWeight(FontWeight weight) => copyWith(fontWeight: weight);
  TextStyle withLetterSpacing(double spacing) => copyWith(letterSpacing: spacing);
  TextStyle withLineHeight(double height) => copyWith(height: height);
  TextStyle bold() => copyWith(fontWeight: FontWeight.bold);
  TextStyle semiBold() => copyWith(fontWeight: FontWeight.w600);
  TextStyle medium() => copyWith(fontWeight: FontWeight.w500);
  TextStyle regular() => copyWith(fontWeight: FontWeight.w400);
  TextStyle italic() => copyWith(fontStyle: FontStyle.italic);
  TextStyle underlined() => copyWith(decoration: TextDecoration.underline);
  TextStyle strikethrough() => copyWith(decoration: TextDecoration.lineThrough);
  TextStyle scaled(double factor) => copyWith(fontSize: (fontSize ?? 14) * factor);
  TextStyle scaledBy(TextScaleOption option) => copyWith(fontSize: (fontSize ?? 14) * option.factor);
}