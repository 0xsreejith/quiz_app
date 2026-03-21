import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Reusable text style factories shared across the app.
abstract final class AppTextStyles {
  /// All-caps section label (e.g. "ACCOUNT ARCHITECTURE", "RECENT ATTEMPTS").
  static TextStyle sectionLabel({Color? color}) => TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textMuted,
        letterSpacing: 1.8,
      );

  /// Smaller all-caps label (e.g. "TOTAL ACCURACY", "ACTIVITY LOGS").
  static TextStyle miniLabel({Color? color}) => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
        color: color ?? AppColors.textMuted,
      );

  /// Card / section title — 17px bold.
  static const TextStyle cardTitle = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  /// Large page title — 32px extra-bold.
  static const TextStyle pageTitleLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    color: AppColors.textDarkest,
  );

  /// User display name — 22px bold.
  static const TextStyle displayName = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
    letterSpacing: -0.3,
  );

  /// Muted subtitle — 11px, letter-spaced.
  static const TextStyle subtitleMuted = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    color: AppColors.textMuted,
    letterSpacing: 1.5,
  );

  /// Small body text — 12–13px.
  static TextStyle bodySmall({Color? color}) => TextStyle(
        fontSize: 13,
        color: color ?? AppColors.textMuted,
      );

  /// Stat label — tiny all-caps above a number.
  static const TextStyle statLabel = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    color: AppColors.textMuted,
    letterSpacing: 1.2,
  );

  /// Large stat value.
  static const TextStyle statValue = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  /// Stat suffix (e.g. "%", "d").
  static const TextStyle statSuffix = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  /// Settings tile title — 15px semi-bold.
  static const TextStyle settingsTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  /// Settings tile subtitle — 12px muted.
  static const TextStyle settingsSubtitle = TextStyle(
    fontSize: 12,
    color: AppColors.textMuted,
  );

  /// Tag chip label.
  static const TextStyle tagLabel = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
    letterSpacing: 0.8,
  );

  /// History attempt card title.
  static const TextStyle attemptTitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textDarkest,
    height: 1.3,
  );

  /// Large hero number (48px).
  static TextStyle heroNumber({Color? color}) => TextStyle(
        fontSize: 48,
        fontWeight: FontWeight.w800,
        color: color ?? AppColors.darkNavy,
        height: 1,
      );

  /// Score value in attempt card.
  static const TextStyle scoreValue = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: AppColors.textDarkest,
    height: 1,
  );

  /// Tiny bold label for badges / status.
  static TextStyle tinyBold({Color? color}) => TextStyle(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        color: color ?? AppColors.darkNavy,
        letterSpacing: 0.5,
      );

  // ── Home Screen ────────────────────────────────────────────────────

  /// Bold section title (e.g. "Featured Quizzes").
  static const TextStyle homeSectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w800,
    color: AppColors.textDarkest,
    letterSpacing: -0.3,
  );

  /// Featured card large title.
  static const TextStyle featuredTitle = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.w800,
    color: Colors.white,
    height: 1.2,
    letterSpacing: -0.3,
  );

  /// Featured card description.
  static const TextStyle featuredDescription = TextStyle(
    fontSize: 13,
    color: Color(0xFFB0B8D0),
    height: 1.4,
  );

  /// CTA button text.
  static const TextStyle ctaButton = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textDarkest,
    letterSpacing: 0.2,
  );

  /// Performer name in leaderboard.
  static const TextStyle performerName = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  /// Performer subtitle / tag.
  static TextStyle performerSubtitle({Color? color}) => TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.textMuted,
        letterSpacing: 0.5,
      );

  /// Performer points value.
  static const TextStyle performerPoints = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.textDarkest,
  );

  /// Activity title.
  static const TextStyle activityTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    color: AppColors.textDark,
  );

  /// Activity meta text (date, status).
  static const TextStyle activityMeta = TextStyle(
    fontSize: 11,
    color: AppColors.textMuted,
    letterSpacing: 0.3,
  );

  /// Large accuracy percentage.
  static const TextStyle activityAccuracy = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    color: AppColors.textDarkest,
    height: 1,
  );

  /// Search bar placeholder.
  static const TextStyle searchPlaceholder = TextStyle(
    fontSize: 14,
    color: AppColors.textMuted,
  );

  /// Category panel title.
  static const TextStyle categoryTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w700,
    color: AppColors.textDark,
  );

  /// Category panel subtitle.
  static const TextStyle categorySubtitle = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
  );
}
