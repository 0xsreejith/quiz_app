import 'package:flutter/material.dart';

/// Named spacing and padding constants shared across the app.
abstract final class AppSpacing {
  // ── Numeric values ──────────────────────────────────────────────────
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;
  static const double xxxl = 32;

  // ── Page padding ────────────────────────────────────────────────────
  static const EdgeInsets profilePagePadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 16);
  static const EdgeInsets historyPagePadding =
      EdgeInsets.symmetric(horizontal: 20, vertical: 24);

  // ── Card padding ────────────────────────────────────────────────────
  static const EdgeInsets cardPadding = EdgeInsets.all(18);
  static const EdgeInsets cardPaddingLarge = EdgeInsets.all(24);

  // ── Border radii ────────────────────────────────────────────────────
  static const double cardRadius = 16;
  static const double cardRadiusLarge = 20;
  static const double chipRadius = 20;
  static const double iconBoxRadius = 12;
  static const double buttonRadius = 14;
  static const double avatarRadius = 24;

  // ── Common gaps ─────────────────────────────────────────────────────
  static const SizedBox verticalSm = SizedBox(height: 8);
  static const SizedBox verticalMd = SizedBox(height: 12);
  static const SizedBox verticalLg = SizedBox(height: 16);
  static const SizedBox verticalXl = SizedBox(height: 20);
  static const SizedBox verticalXxl = SizedBox(height: 24);
  static const SizedBox verticalXxxl = SizedBox(height: 32);

  // ── Home Screen ────────────────────────────────────────────────────
  static const EdgeInsets homePagePadding =
      EdgeInsets.symmetric(horizontal: 20);
  static const double sectionGap = 28;
  static const double searchBarHeight = 52;
  static const double searchBarRadius = 28;
  static const double featuredCardHeight = 320;
  static const double featuredCardRadius = 24;
}
