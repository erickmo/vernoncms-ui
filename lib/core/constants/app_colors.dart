import 'package:flutter/material.dart';

/// Warna standar aplikasi.
/// Selalu gunakan konstanta ini, jangan hardcode hex color.
class AppColors {
  AppColors._();

  // Primary
  static const Color primary = Color(0xFF1565C0);
  static const Color primaryLight = Color(0xFF5E92F3);
  static const Color primaryDark = Color(0xFF003C8F);

  // Secondary
  static const Color secondary = Color(0xFF00897B);
  static const Color secondaryLight = Color(0xFF4EBAAA);
  static const Color secondaryDark = Color(0xFF005B4F);

  // Neutral
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE0E0E0);

  // Text
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textHint = Color(0xFFBDBDBD);

  // Status
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF57F17);
  static const Color error = Color(0xFFB71C1C);
  static const Color info = Color(0xFF0277BD);

  // Sidebar
  static const Color sidebarBackground = Color(0xFF1E293B);
  static const Color sidebarItemActive = Color(0xFF334155);
  static const Color sidebarItemHover = Color(0xFF2D3A4D);
  static const Color sidebarText = Color(0xFFE2E8F0);
  static const Color sidebarTextActive = Color(0xFFFFFFFF);
  static const Color sidebarSectionTitle = Color(0xFF94A3B8);

  // Chart
  static const Color chartLine = Color(0xFF1565C0);
  static const Color chartFill = Color(0x331565C0);
  static const Color chartGrid = Color(0xFFE0E0E0);
}
