import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

void main() {
  group('AppTextStyles.sectionLabel', () {
    test('returns default color (textMuted) when no color provided', () {
      final style = AppTextStyles.sectionLabel();
      expect(style.color, equals(AppColors.textMuted));
    });

    test('uses provided color override', () {
      final style = AppTextStyles.sectionLabel(color: Colors.red);
      expect(style.color, equals(Colors.red));
    });

    test('has correct font size', () {
      expect(AppTextStyles.sectionLabel().fontSize, equals(11.0));
    });

    test('has correct font weight', () {
      expect(AppTextStyles.sectionLabel().fontWeight, equals(FontWeight.w600));
    });

    test('has correct letter spacing', () {
      expect(AppTextStyles.sectionLabel().letterSpacing, equals(1.8));
    });
  });

  group('AppTextStyles.miniLabel', () {
    test('returns default color (textMuted) when no color provided', () {
      final style = AppTextStyles.miniLabel();
      expect(style.color, equals(AppColors.textMuted));
    });

    test('uses provided color override', () {
      final style = AppTextStyles.miniLabel(color: Colors.blue);
      expect(style.color, equals(Colors.blue));
    });

    test('has correct font size', () {
      expect(AppTextStyles.miniLabel().fontSize, equals(10.0));
    });

    test('has correct font weight', () {
      expect(AppTextStyles.miniLabel().fontWeight, equals(FontWeight.w700));
    });

    test('has correct letter spacing', () {
      expect(AppTextStyles.miniLabel().letterSpacing, equals(1.5));
    });

    test('is smaller than sectionLabel', () {
      expect(
        AppTextStyles.miniLabel().fontSize,
        lessThan(AppTextStyles.sectionLabel().fontSize!),
      );
    });
  });

  group('AppTextStyles — const card and page styles', () {
    test('cardTitle has correct font size', () {
      expect(AppTextStyles.cardTitle.fontSize, equals(17.0));
    });

    test('cardTitle has correct font weight', () {
      expect(AppTextStyles.cardTitle.fontWeight, equals(FontWeight.w700));
    });

    test('cardTitle has correct color', () {
      expect(AppTextStyles.cardTitle.color, equals(AppColors.textDark));
    });

    test('pageTitleLarge has correct font size', () {
      expect(AppTextStyles.pageTitleLarge.fontSize, equals(32.0));
    });

    test('pageTitleLarge has correct font weight', () {
      expect(AppTextStyles.pageTitleLarge.fontWeight, equals(FontWeight.w800));
    });

    test('pageTitleLarge has correct color', () {
      expect(AppTextStyles.pageTitleLarge.color, equals(AppColors.textDarkest));
    });

    test('pageTitleLarge is larger than cardTitle', () {
      expect(
        AppTextStyles.pageTitleLarge.fontSize,
        greaterThan(AppTextStyles.cardTitle.fontSize!),
      );
    });
  });

  group('AppTextStyles — display and subtitle', () {
    test('displayName has correct font size', () {
      expect(AppTextStyles.displayName.fontSize, equals(22.0));
    });

    test('displayName has correct font weight', () {
      expect(AppTextStyles.displayName.fontWeight, equals(FontWeight.w700));
    });

    test('displayName has negative letter spacing', () {
      expect(AppTextStyles.displayName.letterSpacing, equals(-0.3));
    });

    test('subtitleMuted has correct font size', () {
      expect(AppTextStyles.subtitleMuted.fontSize, equals(11.0));
    });

    test('subtitleMuted has correct color', () {
      expect(AppTextStyles.subtitleMuted.color, equals(AppColors.textMuted));
    });

    test('subtitleMuted has letter spacing', () {
      expect(AppTextStyles.subtitleMuted.letterSpacing, equals(1.5));
    });
  });

  group('AppTextStyles.bodySmall', () {
    test('returns default color (textMuted) when no color provided', () {
      final style = AppTextStyles.bodySmall();
      expect(style.color, equals(AppColors.textMuted));
    });

    test('uses provided color override', () {
      final style = AppTextStyles.bodySmall(color: Colors.green);
      expect(style.color, equals(Colors.green));
    });

    test('has correct font size', () {
      expect(AppTextStyles.bodySmall().fontSize, equals(13.0));
    });
  });

  group('AppTextStyles — stat styles', () {
    test('statLabel has correct font size', () {
      expect(AppTextStyles.statLabel.fontSize, equals(10.0));
    });

    test('statLabel has correct color', () {
      expect(AppTextStyles.statLabel.color, equals(AppColors.textMuted));
    });

    test('statValue has correct font size', () {
      expect(AppTextStyles.statValue.fontSize, equals(28.0));
    });

    test('statValue has correct color', () {
      expect(AppTextStyles.statValue.color, equals(AppColors.primary));
    });

    test('statSuffix has correct font size', () {
      expect(AppTextStyles.statSuffix.fontSize, equals(16.0));
    });

    test('statSuffix has correct color', () {
      expect(AppTextStyles.statSuffix.color, equals(AppColors.primary));
    });

    test('statValue is larger than statSuffix', () {
      expect(
        AppTextStyles.statValue.fontSize,
        greaterThan(AppTextStyles.statSuffix.fontSize!),
      );
    });
  });

  group('AppTextStyles — settings styles', () {
    test('settingsTitle has correct font size', () {
      expect(AppTextStyles.settingsTitle.fontSize, equals(15.0));
    });

    test('settingsTitle has correct font weight', () {
      expect(AppTextStyles.settingsTitle.fontWeight, equals(FontWeight.w600));
    });

    test('settingsTitle has correct color', () {
      expect(AppTextStyles.settingsTitle.color, equals(AppColors.textDark));
    });

    test('settingsSubtitle has correct font size', () {
      expect(AppTextStyles.settingsSubtitle.fontSize, equals(12.0));
    });

    test('settingsSubtitle has correct color', () {
      expect(AppTextStyles.settingsSubtitle.color, equals(AppColors.textMuted));
    });

    test('settingsTitle is larger than settingsSubtitle', () {
      expect(
        AppTextStyles.settingsTitle.fontSize,
        greaterThan(AppTextStyles.settingsSubtitle.fontSize!),
      );
    });
  });

  group('AppTextStyles — attempt card styles', () {
    test('attemptTitle has correct font size', () {
      expect(AppTextStyles.attemptTitle.fontSize, equals(16.0));
    });

    test('attemptTitle has correct color', () {
      expect(AppTextStyles.attemptTitle.color, equals(AppColors.textDarkest));
    });

    test('attemptTitle has line height', () {
      expect(AppTextStyles.attemptTitle.height, equals(1.3));
    });

    test('scoreValue has correct font size', () {
      expect(AppTextStyles.scoreValue.fontSize, equals(24.0));
    });

    test('scoreValue has correct font weight', () {
      expect(AppTextStyles.scoreValue.fontWeight, equals(FontWeight.w800));
    });

    test('scoreValue has line height of 1', () {
      expect(AppTextStyles.scoreValue.height, equals(1.0));
    });
  });

  group('AppTextStyles.heroNumber', () {
    test('returns default color (darkNavy) when no color provided', () {
      final style = AppTextStyles.heroNumber();
      expect(style.color, equals(AppColors.darkNavy));
    });

    test('uses provided color override', () {
      final style = AppTextStyles.heroNumber(color: Colors.orange);
      expect(style.color, equals(Colors.orange));
    });

    test('has correct font size', () {
      expect(AppTextStyles.heroNumber().fontSize, equals(48.0));
    });

    test('has correct font weight', () {
      expect(AppTextStyles.heroNumber().fontWeight, equals(FontWeight.w800));
    });

    test('has line height of 1', () {
      expect(AppTextStyles.heroNumber().height, equals(1.0));
    });

    test('is larger than scoreValue', () {
      expect(
        AppTextStyles.heroNumber().fontSize,
        greaterThan(AppTextStyles.scoreValue.fontSize!),
      );
    });
  });

  group('AppTextStyles.tinyBold', () {
    test('returns default color (darkNavy) when no color provided', () {
      final style = AppTextStyles.tinyBold();
      expect(style.color, equals(AppColors.darkNavy));
    });

    test('uses provided color override', () {
      final style = AppTextStyles.tinyBold(color: Colors.purple);
      expect(style.color, equals(Colors.purple));
    });

    test('has correct font size', () {
      expect(AppTextStyles.tinyBold().fontSize, equals(10.0));
    });

    test('has correct font weight', () {
      expect(AppTextStyles.tinyBold().fontWeight, equals(FontWeight.w800));
    });

    test('has correct letter spacing', () {
      expect(AppTextStyles.tinyBold().letterSpacing, equals(0.5));
    });
  });

  group('AppTextStyles — tagLabel', () {
    test('tagLabel has correct font size', () {
      expect(AppTextStyles.tagLabel.fontSize, equals(11.0));
    });

    test('tagLabel has correct font weight', () {
      expect(AppTextStyles.tagLabel.fontWeight, equals(FontWeight.w600));
    });

    test('tagLabel has correct letter spacing', () {
      expect(AppTextStyles.tagLabel.letterSpacing, equals(0.8));
    });

    test('tagLabel has correct color', () {
      expect(AppTextStyles.tagLabel.color, equals(AppColors.textDark));
    });
  });
}