import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';

void main() {
  group('AppSpacing — numeric spacing values', () {
    test('xs equals 4', () {
      expect(AppSpacing.xs, equals(4.0));
    });

    test('sm equals 8', () {
      expect(AppSpacing.sm, equals(8.0));
    });

    test('md equals 12', () {
      expect(AppSpacing.md, equals(12.0));
    });

    test('lg equals 16', () {
      expect(AppSpacing.lg, equals(16.0));
    });

    test('xl equals 20', () {
      expect(AppSpacing.xl, equals(20.0));
    });

    test('xxl equals 24', () {
      expect(AppSpacing.xxl, equals(24.0));
    });

    test('xxxl equals 32', () {
      expect(AppSpacing.xxxl, equals(32.0));
    });

    test('spacing values are in ascending order', () {
      expect(AppSpacing.xs, lessThan(AppSpacing.sm));
      expect(AppSpacing.sm, lessThan(AppSpacing.md));
      expect(AppSpacing.md, lessThan(AppSpacing.lg));
      expect(AppSpacing.lg, lessThan(AppSpacing.xl));
      expect(AppSpacing.xl, lessThan(AppSpacing.xxl));
      expect(AppSpacing.xxl, lessThan(AppSpacing.xxxl));
    });
  });

  group('AppSpacing — page padding', () {
    test('profilePagePadding has correct horizontal value', () {
      expect(AppSpacing.profilePagePadding.left, equals(20.0));
      expect(AppSpacing.profilePagePadding.right, equals(20.0));
    });

    test('profilePagePadding has correct vertical value', () {
      expect(AppSpacing.profilePagePadding.top, equals(16.0));
      expect(AppSpacing.profilePagePadding.bottom, equals(16.0));
    });

    test('historyPagePadding has correct horizontal value', () {
      expect(AppSpacing.historyPagePadding.left, equals(20.0));
      expect(AppSpacing.historyPagePadding.right, equals(20.0));
    });

    test('historyPagePadding has correct vertical value', () {
      expect(AppSpacing.historyPagePadding.top, equals(24.0));
      expect(AppSpacing.historyPagePadding.bottom, equals(24.0));
    });

    test('historyPagePadding has more vertical space than profilePagePadding', () {
      expect(
        AppSpacing.historyPagePadding.top,
        greaterThan(AppSpacing.profilePagePadding.top),
      );
    });
  });

  group('AppSpacing — card padding', () {
    test('cardPadding is uniform 18 on all sides', () {
      expect(AppSpacing.cardPadding, equals(const EdgeInsets.all(18)));
    });

    test('cardPaddingLarge is uniform 24 on all sides', () {
      expect(AppSpacing.cardPaddingLarge, equals(const EdgeInsets.all(24)));
    });

    test('cardPaddingLarge is larger than cardPadding', () {
      expect(AppSpacing.cardPaddingLarge.top, greaterThan(AppSpacing.cardPadding.top));
    });
  });

  group('AppSpacing — border radii', () {
    test('cardRadius equals 16', () {
      expect(AppSpacing.cardRadius, equals(16.0));
    });

    test('cardRadiusLarge equals 20', () {
      expect(AppSpacing.cardRadiusLarge, equals(20.0));
    });

    test('chipRadius equals 20', () {
      expect(AppSpacing.chipRadius, equals(20.0));
    });

    test('iconBoxRadius equals 12', () {
      expect(AppSpacing.iconBoxRadius, equals(12.0));
    });

    test('buttonRadius equals 14', () {
      expect(AppSpacing.buttonRadius, equals(14.0));
    });

    test('avatarRadius equals 24', () {
      expect(AppSpacing.avatarRadius, equals(24.0));
    });

    test('cardRadiusLarge is greater than cardRadius', () {
      expect(AppSpacing.cardRadiusLarge, greaterThan(AppSpacing.cardRadius));
    });
  });

  group('AppSpacing — vertical SizedBox gaps', () {
    test('verticalSm has height 8', () {
      expect(AppSpacing.verticalSm.height, equals(8.0));
    });

    test('verticalMd has height 12', () {
      expect(AppSpacing.verticalMd.height, equals(12.0));
    });

    test('verticalLg has height 16', () {
      expect(AppSpacing.verticalLg.height, equals(16.0));
    });

    test('verticalXl has height 20', () {
      expect(AppSpacing.verticalXl.height, equals(20.0));
    });

    test('verticalXxl has height 24', () {
      expect(AppSpacing.verticalXxl.height, equals(24.0));
    });

    test('verticalXxxl has height 32', () {
      expect(AppSpacing.verticalXxxl.height, equals(32.0));
    });

    test('vertical gap heights match their corresponding spacing values', () {
      expect(AppSpacing.verticalSm.height, equals(AppSpacing.sm));
      expect(AppSpacing.verticalMd.height, equals(AppSpacing.md));
      expect(AppSpacing.verticalLg.height, equals(AppSpacing.lg));
      expect(AppSpacing.verticalXl.height, equals(AppSpacing.xl));
      expect(AppSpacing.verticalXxl.height, equals(AppSpacing.xxl));
      expect(AppSpacing.verticalXxxl.height, equals(AppSpacing.xxxl));
    });
  });
}