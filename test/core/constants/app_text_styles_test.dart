import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_colors.dart';
import 'package:quiz_app/core/constants/app_text_styles.dart';

void main() {
  group('AppTextStyles.sectionLabel', () {
    test('uses default textMuted color when no color provided', () {
      final style = AppTextStyles.sectionLabel();
      expect(style.color, equals(AppColors.textMuted));
    });

    test('uses provided color override', () {
      final style = AppTextStyles.sectionLabel(color: Colors.red);
      expect(style.color, equals(Colors.red));
    });

    test('has correct font size 11', () {
      expect(AppTextStyles.sectionLabel().fontSize, equals(11.0));
    });

    test('has correct font weight w600', () {
      expect(AppTextStyles.sectionLabel().fontWeight, equals(FontWeight.w600));
    });

    test('has correct letter spacing 1.8', () {
      expect(AppTextStyles.sectionLabel().letterSpacing, equals(1.8));
    });
  });

  group('AppTextStyles.miniLabel', () {
    test('uses default textMuted color when no color provided', () {
      final style = AppTextStyles.miniLabel();
      expect(style.color, equals(AppColors.textMuted));
    });

    test('uses provided color override', () {
      final style = AppTextStyles.miniLabel(color: Colors.blue);
      expect(style.color, equals(Colors.blue));
    });

    test('has correct font size 10', () {
      expect(AppTextStyles.miniLabel().fontSize, equals(10.0));
    });

    test('has correct font weight w700', () {
      expect(AppTextStyles.miniLabel().fontWeight, equals(FontWeight.w700));
    });

    test('has correct letter spacing 1.5', () {
      expect(AppTextStyles.miniLabel().letterSpacing, equals(1.5));
    });
  });

  group('AppTextStyles — static const styles', () {
    test('cardTitle has fontSize 17', () {
      expect(AppTextStyles.cardTitle.fontSize, equals(17.0));
    });

    test('cardTitle has fontWeight w700', () {
      expect(AppTextStyles.cardTitle.fontWeight, equals(FontWeight.w700));
    });

    test('cardTitle uses textDark color', () {
      expect(AppTextStyles.cardTitle.color, equals(AppColors.textDark));
    });

    test('pageTitleLarge has fontSize 32', () {
      expect(AppTextStyles.pageTitleLarge.fontSize, equals(32.0));
    });

    test('pageTitleLarge has fontWeight w800', () {
      expect(AppTextStyles.pageTitleLarge.fontWeight, equals(FontWeight.w800));
    });

    test('pageTitleLarge uses textDarkest color', () {
      expect(AppTextStyles.pageTitleLarge.color, equals(AppColors.textDarkest));
    });

    test('displayName has fontSize 22', () {
      expect(AppTextStyles.displayName.fontSize, equals(22.0));
    });

    test('displayName has fontWeight w700', () {
      expect(AppTextStyles.displayName.fontWeight, equals(FontWeight.w700));
    });

    test('displayName has letterSpacing -0.3', () {
      expect(AppTextStyles.displayName.letterSpacing, equals(-0.3));
    });

    test('subtitleMuted has fontSize 11', () {
      expect(AppTextStyles.subtitleMuted.fontSize, equals(11.0));
    });

    test('subtitleMuted has letterSpacing 1.5', () {
      expect(AppTextStyles.subtitleMuted.letterSpacing, equals(1.5));
    });

    test('statLabel has fontSize 10', () {
      expect(AppTextStyles.statLabel.fontSize, equals(10.0));
    });

    test('statLabel has letterSpacing 1.2', () {
      expect(AppTextStyles.statLabel.letterSpacing, equals(1.2));
    });

    test('statValue has fontSize 28', () {
      expect(AppTextStyles.statValue.fontSize, equals(28.0));
    });

    test('statValue uses primary color', () {
      expect(AppTextStyles.statValue.color, equals(AppColors.primary));
    });

    test('statSuffix has fontSize 16', () {
      expect(AppTextStyles.statSuffix.fontSize, equals(16.0));
    });

    test('statSuffix uses primary color', () {
      expect(AppTextStyles.statSuffix.color, equals(AppColors.primary));
    });

    test('settingsTitle has fontSize 15', () {
      expect(AppTextStyles.settingsTitle.fontSize, equals(15.0));
    });

    test('settingsSubtitle has fontSize 12', () {
      expect(AppTextStyles.settingsSubtitle.fontSize, equals(12.0));
    });

    test('tagLabel has fontSize 11 with letterSpacing 0.8', () {
      expect(AppTextStyles.tagLabel.fontSize, equals(11.0));
      expect(AppTextStyles.tagLabel.letterSpacing, equals(0.8));
    });

    test('attemptTitle has fontSize 16 and height 1.3', () {
      expect(AppTextStyles.attemptTitle.fontSize, equals(16.0));
      expect(AppTextStyles.attemptTitle.height, equals(1.3));
    });

    test('attemptTitle uses textDarkest color', () {
      expect(AppTextStyles.attemptTitle.color, equals(AppColors.textDarkest));
    });

    test('scoreValue has fontSize 24', () {
      expect(AppTextStyles.scoreValue.fontSize, equals(24.0));
    });

    test('scoreValue has fontWeight w800', () {
      expect(AppTextStyles.scoreValue.fontWeight, equals(FontWeight.w800));
    });

    test('scoreValue has height 1', () {
      expect(AppTextStyles.scoreValue.height, equals(1.0));
    });
  });

  group('AppTextStyles.bodySmall', () {
    test('has fontSize 13', () {
      expect(AppTextStyles.bodySmall().fontSize, equals(13.0));
    });

    test('uses textMuted as default color', () {
      expect(AppTextStyles.bodySmall().color, equals(AppColors.textMuted));
    });

    test('uses provided color override', () {
      expect(AppTextStyles.bodySmall(color: Colors.green).color, equals(Colors.green));
    });
  });

  group('AppTextStyles.heroNumber', () {
    test('has fontSize 48', () {
      expect(AppTextStyles.heroNumber().fontSize, equals(48.0));
    });

    test('has fontWeight w800', () {
      expect(AppTextStyles.heroNumber().fontWeight, equals(FontWeight.w800));
    });

    test('has height 1', () {
      expect(AppTextStyles.heroNumber().height, equals(1.0));
    });

    test('uses darkNavy as default color', () {
      expect(AppTextStyles.heroNumber().color, equals(AppColors.darkNavy));
    });

    test('uses provided color override', () {
      expect(AppTextStyles.heroNumber(color: Colors.purple).color, equals(Colors.purple));
    });
  });

  group('AppTextStyles.tinyBold', () {
    test('has fontSize 10', () {
      expect(AppTextStyles.tinyBold().fontSize, equals(10.0));
    });

    test('has fontWeight w800', () {
      expect(AppTextStyles.tinyBold().fontWeight, equals(FontWeight.w800));
    });

    test('has letterSpacing 0.5', () {
      expect(AppTextStyles.tinyBold().letterSpacing, equals(0.5));
    });

    test('uses darkNavy as default color', () {
      expect(AppTextStyles.tinyBold().color, equals(AppColors.darkNavy));
    });

    test('uses provided color override', () {
      expect(AppTextStyles.tinyBold(color: Colors.orange).color, equals(Colors.orange));
    });
  });
}