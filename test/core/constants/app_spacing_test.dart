import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_spacing.dart';

void main() {
  group('AppSpacing — numeric values', () {
    test('xs is 4', () => expect(AppSpacing.xs, equals(4.0)));
    test('sm is 8', () => expect(AppSpacing.sm, equals(8.0)));
    test('md is 12', () => expect(AppSpacing.md, equals(12.0)));
    test('lg is 16', () => expect(AppSpacing.lg, equals(16.0)));
    test('xl is 20', () => expect(AppSpacing.xl, equals(20.0)));
    test('xxl is 24', () => expect(AppSpacing.xxl, equals(24.0)));
    test('xxxl is 32', () => expect(AppSpacing.xxxl, equals(32.0)));

    test('values are strictly increasing', () {
      expect(AppSpacing.xs, lessThan(AppSpacing.sm));
      expect(AppSpacing.sm, lessThan(AppSpacing.md));
      expect(AppSpacing.md, lessThan(AppSpacing.lg));
      expect(AppSpacing.lg, lessThan(AppSpacing.xl));
      expect(AppSpacing.xl, lessThan(AppSpacing.xxl));
      expect(AppSpacing.xxl, lessThan(AppSpacing.xxxl));
    });
  });

  group('AppSpacing — page padding', () {
    test('profilePagePadding has horizontal 20, vertical 16', () {
      const padding = AppSpacing.profilePagePadding;
      expect(padding.left, equals(20.0));
      expect(padding.right, equals(20.0));
      expect(padding.top, equals(16.0));
      expect(padding.bottom, equals(16.0));
    });

    test('historyPagePadding has horizontal 20, vertical 24', () {
      const padding = AppSpacing.historyPagePadding;
      expect(padding.left, equals(20.0));
      expect(padding.right, equals(20.0));
      expect(padding.top, equals(24.0));
      expect(padding.bottom, equals(24.0));
    });
  });

  group('AppSpacing — card padding', () {
    test('cardPadding is EdgeInsets.all(18)', () {
      const padding = AppSpacing.cardPadding;
      expect(padding.left, equals(18.0));
      expect(padding.right, equals(18.0));
      expect(padding.top, equals(18.0));
      expect(padding.bottom, equals(18.0));
    });

    test('cardPaddingLarge is EdgeInsets.all(24)', () {
      const padding = AppSpacing.cardPaddingLarge;
      expect(padding.left, equals(24.0));
      expect(padding.right, equals(24.0));
      expect(padding.top, equals(24.0));
      expect(padding.bottom, equals(24.0));
    });
  });

  group('AppSpacing — border radii', () {
    test('cardRadius is 16', () => expect(AppSpacing.cardRadius, equals(16.0)));
    test('cardRadiusLarge is 20', () => expect(AppSpacing.cardRadiusLarge, equals(20.0)));
    test('chipRadius is 20', () => expect(AppSpacing.chipRadius, equals(20.0)));
    test('iconBoxRadius is 12', () => expect(AppSpacing.iconBoxRadius, equals(12.0)));
    test('buttonRadius is 14', () => expect(AppSpacing.buttonRadius, equals(14.0)));
    test('avatarRadius is 24', () => expect(AppSpacing.avatarRadius, equals(24.0)));
  });

  group('AppSpacing — vertical gap SizedBoxes', () {
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

    test('all vertical gaps have null width', () {
      for (final box in [
        AppSpacing.verticalSm,
        AppSpacing.verticalMd,
        AppSpacing.verticalLg,
        AppSpacing.verticalXl,
        AppSpacing.verticalXxl,
        AppSpacing.verticalXxxl,
      ]) {
        expect(box.width, isNull, reason: 'vertical gap should have no fixed width');
      }
    });

    test('vertical gap heights match corresponding spacing values', () {
      expect(AppSpacing.verticalSm.height, equals(AppSpacing.sm));
      expect(AppSpacing.verticalMd.height, equals(AppSpacing.md));
      expect(AppSpacing.verticalLg.height, equals(AppSpacing.lg));
      expect(AppSpacing.verticalXl.height, equals(AppSpacing.xl));
      expect(AppSpacing.verticalXxl.height, equals(AppSpacing.xxl));
      expect(AppSpacing.verticalXxxl.height, equals(AppSpacing.xxxl));
    });
  });
}