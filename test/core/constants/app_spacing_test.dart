import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';

void main() {
  group('AppSpacing - Numeric values', () {
    test('xs is 4', () => expect(AppSpacing.xs, 4.0));
    test('sm is 8', () => expect(AppSpacing.sm, 8.0));
    test('md is 12', () => expect(AppSpacing.md, 12.0));
    test('lg is 16', () => expect(AppSpacing.lg, 16.0));
    test('xl is 20', () => expect(AppSpacing.xl, 20.0));
    test('xxl is 24', () => expect(AppSpacing.xxl, 24.0));
    test('xxxl is 32', () => expect(AppSpacing.xxxl, 32.0));

    test('numeric values are in ascending order', () {
      expect(AppSpacing.xs, lessThan(AppSpacing.sm));
      expect(AppSpacing.sm, lessThan(AppSpacing.md));
      expect(AppSpacing.md, lessThan(AppSpacing.lg));
      expect(AppSpacing.lg, lessThan(AppSpacing.xl));
      expect(AppSpacing.xl, lessThan(AppSpacing.xxl));
      expect(AppSpacing.xxl, lessThan(AppSpacing.xxxl));
    });
  });

  group('AppSpacing - Page padding', () {
    test('profilePagePadding has correct horizontal and vertical values', () {
      const padding = AppSpacing.profilePagePadding;
      expect(padding.left, 20.0);
      expect(padding.right, 20.0);
      expect(padding.top, 16.0);
      expect(padding.bottom, 16.0);
    });

    test('historyPagePadding has correct horizontal and vertical values', () {
      const padding = AppSpacing.historyPagePadding;
      expect(padding.left, 20.0);
      expect(padding.right, 20.0);
      expect(padding.top, 24.0);
      expect(padding.bottom, 24.0);
    });
  });

  group('AppSpacing - Card padding', () {
    test('cardPadding is 18 on all sides', () {
      const padding = AppSpacing.cardPadding;
      expect(padding.top, 18.0);
      expect(padding.right, 18.0);
      expect(padding.bottom, 18.0);
      expect(padding.left, 18.0);
    });

    test('cardPaddingLarge is 24 on all sides', () {
      const padding = AppSpacing.cardPaddingLarge;
      expect(padding.top, 24.0);
      expect(padding.right, 24.0);
      expect(padding.bottom, 24.0);
      expect(padding.left, 24.0);
    });

    test('cardPaddingLarge is larger than cardPadding', () {
      expect(AppSpacing.cardPaddingLarge.top, greaterThan(AppSpacing.cardPadding.top));
    });
  });

  group('AppSpacing - Border radii', () {
    test('cardRadius is 16', () => expect(AppSpacing.cardRadius, 16.0));
    test('cardRadiusLarge is 20', () => expect(AppSpacing.cardRadiusLarge, 20.0));
    test('chipRadius is 20', () => expect(AppSpacing.chipRadius, 20.0));
    test('iconBoxRadius is 12', () => expect(AppSpacing.iconBoxRadius, 12.0));
    test('buttonRadius is 14', () => expect(AppSpacing.buttonRadius, 14.0));
    test('avatarRadius is 24', () => expect(AppSpacing.avatarRadius, 24.0));

    test('cardRadiusLarge is larger than cardRadius', () {
      expect(AppSpacing.cardRadiusLarge, greaterThan(AppSpacing.cardRadius));
    });
  });

  group('AppSpacing - SizedBox gaps', () {
    test('verticalSm has height 8', () {
      expect(AppSpacing.verticalSm.height, 8.0);
    });

    test('verticalMd has height 12', () {
      expect(AppSpacing.verticalMd.height, 12.0);
    });

    test('verticalLg has height 16', () {
      expect(AppSpacing.verticalLg.height, 16.0);
    });

    test('verticalXl has height 20', () {
      expect(AppSpacing.verticalXl.height, 20.0);
    });

    test('verticalXxl has height 24', () {
      expect(AppSpacing.verticalXxl.height, 24.0);
    });

    test('verticalXxxl has height 32', () {
      expect(AppSpacing.verticalXxxl.height, 32.0);
    });

    test('all vertical gaps have null width (height-only SizedBoxes)', () {
      expect(AppSpacing.verticalSm.width, isNull);
      expect(AppSpacing.verticalMd.width, isNull);
      expect(AppSpacing.verticalLg.width, isNull);
    });

    test('SizedBox heights match their corresponding double constants', () {
      expect(AppSpacing.verticalSm.height, AppSpacing.sm);
      expect(AppSpacing.verticalMd.height, AppSpacing.md);
      expect(AppSpacing.verticalLg.height, AppSpacing.lg);
      expect(AppSpacing.verticalXl.height, AppSpacing.xl);
      expect(AppSpacing.verticalXxl.height, AppSpacing.xxl);
      expect(AppSpacing.verticalXxxl.height, AppSpacing.xxxl);
    });
  });
}