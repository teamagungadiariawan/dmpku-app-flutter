import 'package:flutter/material.dart';

/// Color scheme inspired by shadcn/ui
/// Using HSL-based approach for better theming
class AppColors {
  // Light Theme Colors
  static const lightBackground = Color(0xFFFFFFFF);
  static const lightForeground = Color(0xFF020817);

  static const lightCard = Color(0xFFFFFFFF);
  static const lightCardForeground = Color(0xFF020817);

  static const lightPopover = Color(0xFFFFFFFF);
  static const lightPopoverForeground = Color(0xFF020817);

  static const lightPrimary = Color(0xFF359D9E);
  static const lightPrimaryForeground = Color(0xFFFAFAFA);

  static const lightSecondary = Color(0xFFF4F4F5);
  static const lightSecondaryForeground = Color(0xFF18181B);

  static const lightSuccess = Color(0xFF059669);
  static const lightSuccessForeground = Color(0xFFFAFAFA);

  static const lightWarning = Color(0xFFEAB308);
  static const lightWarningForeground = Color(0xFF422006);

  static const lightMuted = Color(0xFFF4F4F5);
  static const lightMutedForeground = Color(0xFF71717A);

  static const lightAccent = Color(0xFFF4F4F5);
  static const lightAccentForeground = Color(0xFF18181B);

  static const lightDestructive = Color(0xFFEF4444);
  static const lightDestructiveForeground = Color(0xFFFAFAFA);

  static const lightBorder = Color(0xFFE4E4E7);
  static const lightInput = Color(0xFFE4E4E7);
  static const lightRing = Color(0xFF18181B);

  // Dark Theme Colors
  static const darkBackground = Color(0xFF09090B);
  static const darkForeground = Color(0xFFFAFAFA);

  static const darkCard = Color(0xFF09090B);
  static const darkCardForeground = Color(0xFFFAFAFA);

  static const darkPopover = Color(0xFF09090B);
  static const darkPopoverForeground = Color(0xFFFAFAFA);

  static const darkPrimary = Color(0xFF359D9E);
  static const darkPrimaryForeground = Color(0xFFFFFFFF);

  static const darkSecondary = Color(0xFF27272A);
  static const darkSecondaryForeground = Color(0xFFFAFAFA);

  static const darkSuccess = Color(0xFF059669);
  static const darkSuccessForeground = Color(0xFFFAFAFA);

  static const darkWarning = Color(0xFFFACC15);
  static const darkWarningForeground = Color(0xFF422006);

  static const darkMuted = Color(0xFF27272A);
  static const darkMutedForeground = Color(0xFFA1A1AA);

  static const darkAccent = Color(0xFF27272A);
  static const darkAccentForeground = Color(0xFFFAFAFA);

  static const darkDestructive = Color(0xFF7F1D1D);
  static const darkDestructiveForeground = Color(0xFFFAFAFA);

  static const darkBorder = Color(0xFF27272A);
  static const darkInput = Color(0xFF27272A);
  static const darkRing = Color(0xFFD4D4D8);
}

const neutral = {
  50: Color(0xFFFAFAFA),
  100: Color(0xFFF5F5F5),
  200: Color(0xFFe5e5e5),
  300: Color(0xFFd4d4d4),
  400: Color(0xFFa3a3a3),
  500: Color(0xFF737373),
  600: Color(0xFF525252),
  700: Color(0xFF404040),
  800: Color(0xFF262626),
  900: Color(0xFF171717),
  950: Color(0xFF0A0A0A),
};

const stone = {
  50: Color(0xFFFAFAF9),
  100: Color(0xFFF5F5F4),
  200: Color(0xFFE7E5E4),
  300: Color(0xFFD6D3D1),
  400: Color(0xFFA8A29E),
  500: Color(0xFF78716C),
  600: Color(0xFF57534E),
  700: Color(0xFF44403C),
  800: Color(0xFF292524),
  900: Color(0xFF1C1917),
  950: Color(0xFF0C0A09),
};

const zinc = {
  50: Color(0xFFFAFAFA),
  100: Color(0xFFF4F4F5),
  200: Color(0xFFE4E4E7),
  300: Color(0xFFD4D4D8),
  400: Color(0xFFA1A1AA),
  500: Color(0xFF71717A),
  600: Color(0xFF52525B),
  700: Color(0xFF3F3F46),
  800: Color(0xFF27272A),
  900: Color(0xFF18181B),
  950: Color(0xFF09090B),
};

const slate = {
  50: Color(0xFFF8FAFC),
  100: Color(0xFFF1F5F9),
  200: Color(0xFFE2E8F0),
  300: Color(0xFFCBD5E1),
  400: Color(0xFF94A3B8),
  500: Color(0xFF64748B),
  600: Color(0xFF475569),
  700: Color(0xFF334155),
  800: Color(0xFF1E293B),
  900: Color(0xFF0F172A),
  950: Color(0xFF020617),
};

const gray = {
  50: Color(0xFFF9FAFB),
  100: Color(0xFFF3F4F6),
  200: Color(0xFFE5E7EB),
  300: Color(0xFFD1D5DB),
  400: Color(0xFF9CA3AF),
  500: Color(0xFF6B7280),
  600: Color(0xFF4B5563),
  700: Color(0xFF374151),
  800: Color(0xFF1F2937),
  900: Color(0xFF111827),
  950: Color(0xFF030712),
};

const rose = {
  50: Color(0xFFFFF1F2),
  100: Color(0xFFFFE4E6),
  200: Color(0xFFFECDD3),
  300: Color(0xFFFDA4AF),
  400: Color(0xFFFB7185),
  500: Color(0xFFF43F5E),
  600: Color(0xFFE11D48),
  700: Color(0xFFBE123C),
  800: Color(0xFF9F1239),
  900: Color(0xFF881337),
  950: Color(0xFF4C0519),
};

const blue = {
  50: Color(0xFFEFF6FF),
  100: Color(0xFFDBEAFE),
  200: Color(0xFFBFDBFE),
  300: Color(0xFF93C5FD),
  400: Color(0xFF60A5FA),
  500: Color(0xFF3B82F6),
  600: Color(0xFF2563EB),
  700: Color(0xFF1D4ED8),
  800: Color(0xFF1E40AF),
  900: Color(0xFF1E3A8A),
  950: Color(0xFF172554),
};

const green = {
  50: Color(0xFFF0FDF4),
  100: Color(0xFFDCFCE7),
  200: Color(0xFFBBF7D0),
  300: Color(0xFF86EFAC),
  400: Color(0xFF4ADE80),
  500: Color(0xFF22C55E),
  600: Color(0xFF16A34A),
  700: Color(0xFF15803D),
  800: Color(0xFF166534),
  900: Color(0xFF14532D),
  950: Color(0xFF052E16),
};

const yellow = {
  50: Color(0xFFFFFCE7),
  100: Color(0xFFFEF9C3),
  200: Color(0xFFFEF08A),
  300: Color(0xFFFDE047),
  400: Color(0xFFFACC15),
  500: Color(0xFFEAB308),
  600: Color(0xFFCA8A04),
  700: Color(0xFFA16207),
  800: Color(0xFF854D0E),
  900: Color(0xFF713F12),
  950: Color(0xFF422006),
};

const orange = {
  50: Color(0xFFFFF7ED),
  100: Color(0xFFFFEDD5),
  200: Color(0xFFFED7AA),
  300: Color(0xFFFDBA74),
  400: Color(0xFFFB923C),
  500: Color(0xFFF97316),
  600: Color(0xFFEA580C),
  700: Color(0xFFC2410C),
  800: Color(0xFF9A3412),
  900: Color(0xFF7C2D12),
  950: Color(0xFF431407),
};

const bgScreen = Color(0xFFf9fafb);
const bgCard = Color(0xFFFFFFFF);
const borderColor = Color(0xFFe5e7eb);

final bgSuccess = green[500];
final bgWarning = yellow[500];
final bgError = rose[500];

class AppColorStatus {
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFEAB308);
  static const Color error = Color(0xFFF43F5E);
}