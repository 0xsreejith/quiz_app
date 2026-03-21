import 'package:flutter/material.dart';

/// Centralized color palette shared across the app.
abstract final class AppColors {
  // ── Primary Palette ─────────────────────────────────────────────────
  static const Color primary = Color(0xFF3F51B5);
  static const Color primaryLight = Color(0xFFE8EAF6);
  static const Color primaryAccent = Color(0xFF5C6BC0);

  // ── Text ────────────────────────────────────────────────────────────
  static const Color textDark = Color(0xFF1A1D2E);
  static const Color textDarkest = Color(0xFF111827);
  static const Color textMuted = Color(0xFF7C8495);

  // ── Surfaces ────────────────────────────────────────────────────────
  static const Color cardBg = Color(0xFFF7F8FC);
  static const Color historyBg = Color(0xFFF4F6F9);
  static const Color darkCard = Color(0xFF282828);
  static const Color divider = Color(0xFFE8ECF2);
  static const Color avatarBg = Color(0xFFE0E4EB);
  static const Color avatarIcon = Color(0xFFB0B8C9);

  // ── Semantic ────────────────────────────────────────────────────────
  static const Color accentGreen = Color(0xFF4CAF50);
  static const Color emerald = Color(0xFF047857);
  static const Color starColor = Color(0xFFD4B96A);
  static const Color darkNavy = Color(0xFF1E3A8A);
  static const Color deepNavy = Color(0xFF2E4094);
  static const Color indigo = Color(0xFF312E81);
  static const Color indigoMid = Color(0xFF4338CA);
  static const Color blueBright = Color(0xFF2563EB);

  // ── Status / Action ─────────────────────────────────────────────────
  static const Color logoutRed = Color(0xFFE53935);
  static const Color logoutBorder = Color(0xFFFFCDD2);

  // ── Chip / Badge Bg ─────────────────────────────────────────────────
  static const Color chipBgBlue = Color(0xFFE0E7FF);
  static const Color chipBgSlate = Color(0xFFE2E8F0);
  static const Color chipBgGreen = Color(0xFFD1FAE5);
  static const Color chipBgLightBlue = Color(0xFFDBEAFE);
}
