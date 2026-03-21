import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

void main() {
  group('AppTextStyles.sectionLabel', () {
    test('has correct font size', () {
      expect(AppTextStyles.sectionLabel().fontSize, 11.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.sectionLabel().fontWeight, FontWeight.w600);
    });

    test('has correct letter spacing', () {
      expect(AppTextStyles.sectionLabel().letterSpacing, 1.8);
    });

    test('defaults to AppColors.textMuted when no color provided', () {
      expect(AppTextStyles.sectionLabel().color, AppColors.textMuted);
    });

    test('uses custom color when provided', () {
      final style = AppTextStyles.sectionLabel(color: Colors.red);
      expect(style.color, Colors.red);
    });
  });

  group('AppTextStyles.miniLabel', () {
    test('has correct font size', () {
      expect(AppTextStyles.miniLabel().fontSize, 10.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.miniLabel().fontWeight, FontWeight.w700);
    });

    test('has correct letter spacing', () {
      expect(AppTextStyles.miniLabel().letterSpacing, 1.5);
    });

    test('defaults to AppColors.textMuted', () {
      expect(AppTextStyles.miniLabel().color, AppColors.textMuted);
    });

    test('uses custom color when provided', () {
      final style = AppTextStyles.miniLabel(color: Colors.blue);
      expect(style.color, Colors.blue);
    });
  });

  group('AppTextStyles.cardTitle', () {
    test('has correct font size', () {
      expect(AppTextStyles.cardTitle.fontSize, 17.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.cardTitle.fontWeight, FontWeight.w700);
    });

    test('has correct color', () {
      expect(AppTextStyles.cardTitle.color, AppColors.textDark);
    });
  });

  group('AppTextStyles.pageTitleLarge', () {
    test('has correct font size', () {
      expect(AppTextStyles.pageTitleLarge.fontSize, 32.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.pageTitleLarge.fontWeight, FontWeight.w800);
    });

    test('has correct color', () {
      expect(AppTextStyles.pageTitleLarge.color, AppColors.textDarkest);
    });
  });

  group('AppTextStyles.displayName', () {
    test('has correct font size', () {
      expect(AppTextStyles.displayName.fontSize, 22.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.displayName.fontWeight, FontWeight.w700);
    });

    test('has negative letter spacing', () {
      expect(AppTextStyles.displayName.letterSpacing, -0.3);
    });

    test('has correct color', () {
      expect(AppTextStyles.displayName.color, AppColors.textDark);
    });
  });

  group('AppTextStyles.subtitleMuted', () {
    test('has correct font size', () {
      expect(AppTextStyles.subtitleMuted.fontSize, 11.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.subtitleMuted.fontWeight, FontWeight.w500);
    });

    test('has correct letter spacing', () {
      expect(AppTextStyles.subtitleMuted.letterSpacing, 1.5);
    });

    test('has correct color', () {
      expect(AppTextStyles.subtitleMuted.color, AppColors.textMuted);
    });
  });

  group('AppTextStyles.bodySmall', () {
    test('has correct font size', () {
      expect(AppTextStyles.bodySmall().fontSize, 13.0);
    });

    test('defaults to AppColors.textMuted', () {
      expect(AppTextStyles.bodySmall().color, AppColors.textMuted);
    });

    test('uses custom color when provided', () {
      final style = AppTextStyles.bodySmall(color: Colors.green);
      expect(style.color, Colors.green);
    });
  });

  group('AppTextStyles.statLabel', () {
    test('has correct font size', () {
      expect(AppTextStyles.statLabel.fontSize, 10.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.statLabel.fontWeight, FontWeight.w600);
    });

    test('has correct letter spacing', () {
      expect(AppTextStyles.statLabel.letterSpacing, 1.2);
    });
  });

  group('AppTextStyles.statValue', () {
    test('has correct font size', () {
      expect(AppTextStyles.statValue.fontSize, 28.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.statValue.fontWeight, FontWeight.w700);
    });

    test('has primary color', () {
      expect(AppTextStyles.statValue.color, AppColors.primary);
    });
  });

  group('AppTextStyles.statSuffix', () {
    test('has correct font size', () {
      expect(AppTextStyles.statSuffix.fontSize, 16.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.statSuffix.fontWeight, FontWeight.w600);
    });

    test('has primary color', () {
      expect(AppTextStyles.statSuffix.color, AppColors.primary);
    });
  });

  group('AppTextStyles.settingsTitle', () {
    test('has correct font size', () {
      expect(AppTextStyles.settingsTitle.fontSize, 15.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.settingsTitle.fontWeight, FontWeight.w600);
    });

    test('has textDark color', () {
      expect(AppTextStyles.settingsTitle.color, AppColors.textDark);
    });
  });

  group('AppTextStyles.settingsSubtitle', () {
    test('has correct font size', () {
      expect(AppTextStyles.settingsSubtitle.fontSize, 12.0);
    });

    test('has textMuted color', () {
      expect(AppTextStyles.settingsSubtitle.color, AppColors.textMuted);
    });
  });

  group('AppTextStyles.tagLabel', () {
    test('has correct font size', () {
      expect(AppTextStyles.tagLabel.fontSize, 11.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.tagLabel.fontWeight, FontWeight.w600);
    });

    test('has correct letter spacing', () {
      expect(AppTextStyles.tagLabel.letterSpacing, 0.8);
    });
  });

  group('AppTextStyles.attemptTitle', () {
    test('has correct font size', () {
      expect(AppTextStyles.attemptTitle.fontSize, 16.0);
    });

    test('has bold font weight', () {
      expect(AppTextStyles.attemptTitle.fontWeight, FontWeight.bold);
    });

    test('has correct line height', () {
      expect(AppTextStyles.attemptTitle.height, 1.3);
    });

    test('has textDarkest color', () {
      expect(AppTextStyles.attemptTitle.color, AppColors.textDarkest);
    });
  });

  group('AppTextStyles.heroNumber', () {
    test('has correct font size', () {
      expect(AppTextStyles.heroNumber().fontSize, 48.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.heroNumber().fontWeight, FontWeight.w800);
    });

    test('has line height 1', () {
      expect(AppTextStyles.heroNumber().height, 1.0);
    });

    test('defaults to AppColors.darkNavy', () {
      expect(AppTextStyles.heroNumber().color, AppColors.darkNavy);
    });

    test('uses custom color when provided', () {
      final style = AppTextStyles.heroNumber(color: Colors.orange);
      expect(style.color, Colors.orange);
    });
  });

  group('AppTextStyles.scoreValue', () {
    test('has correct font size', () {
      expect(AppTextStyles.scoreValue.fontSize, 24.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.scoreValue.fontWeight, FontWeight.w800);
    });

    test('has line height 1', () {
      expect(AppTextStyles.scoreValue.height, 1.0);
    });

    test('has textDarkest color', () {
      expect(AppTextStyles.scoreValue.color, AppColors.textDarkest);
    });
  });

  group('AppTextStyles.tinyBold', () {
    test('has correct font size', () {
      expect(AppTextStyles.tinyBold().fontSize, 10.0);
    });

    test('has correct font weight', () {
      expect(AppTextStyles.tinyBold().fontWeight, FontWeight.w800);
    });

    test('has correct letter spacing', () {
      expect(AppTextStyles.tinyBold().letterSpacing, 0.5);
    });

    test('defaults to AppColors.darkNavy', () {
      expect(AppTextStyles.tinyBold().color, AppColors.darkNavy);
    });

    test('uses custom color when provided', () {
      final style = AppTextStyles.tinyBold(color: Colors.purple);
      expect(style.color, Colors.purple);
    });
  });

  group('AppTextStyles - font size hierarchy', () {
    // Regression: ensure heading sizes are in correct order
    test('pageTitleLarge is larger than cardTitle', () {
      expect(
        AppTextStyles.pageTitleLarge.fontSize,
        greaterThan(AppTextStyles.cardTitle.fontSize!),
      );
    });

    test('heroNumber is larger than scoreValue', () {
      expect(
        AppTextStyles.heroNumber().fontSize,
        greaterThan(AppTextStyles.scoreValue.fontSize!),
      );
    });

    test('statValue is larger than statSuffix', () {
      expect(
        AppTextStyles.statValue.fontSize,
        greaterThan(AppTextStyles.statSuffix.fontSize!),
      );
    });
  });
}