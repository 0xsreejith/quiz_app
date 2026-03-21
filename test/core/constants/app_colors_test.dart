import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_colors.dart';

void main() {
  group('AppColors - Primary Palette', () {
    test('primary is correct indigo color', () {
      expect(AppColors.primary, const Color(0xFF3F51B5));
    });

    test('primaryLight is correct light indigo', () {
      expect(AppColors.primaryLight, const Color(0xFFE8EAF6));
    });

    test('primaryAccent is correct accent indigo', () {
      expect(AppColors.primaryAccent, const Color(0xFF5C6BC0));
    });
  });

  group('AppColors - Text Colors', () {
    test('textDark has correct value', () {
      expect(AppColors.textDark, const Color(0xFF1A1D2E));
    });

    test('textDarkest has correct value', () {
      expect(AppColors.textDarkest, const Color(0xFF111827));
    });

    test('textMuted has correct value', () {
      expect(AppColors.textMuted, const Color(0xFF7C8495));
    });
  });

  group('AppColors - Surfaces', () {
    test('cardBg has correct value', () {
      expect(AppColors.cardBg, const Color(0xFFF7F8FC));
    });

    test('historyBg has correct value', () {
      expect(AppColors.historyBg, const Color(0xFFF4F6F9));
    });

    test('darkCard has correct value', () {
      expect(AppColors.darkCard, const Color(0xFF282828));
    });

    test('divider has correct value', () {
      expect(AppColors.divider, const Color(0xFFE8ECF2));
    });

    test('avatarBg has correct value', () {
      expect(AppColors.avatarBg, const Color(0xFFE0E4EB));
    });

    test('avatarIcon has correct value', () {
      expect(AppColors.avatarIcon, const Color(0xFFB0B8C9));
    });
  });

  group('AppColors - Semantic Colors', () {
    test('accentGreen has correct value', () {
      expect(AppColors.accentGreen, const Color(0xFF4CAF50));
    });

    test('emerald has correct value', () {
      expect(AppColors.emerald, const Color(0xFF047857));
    });

    test('starColor has correct value', () {
      expect(AppColors.starColor, const Color(0xFFD4B96A));
    });

    test('darkNavy has correct value', () {
      expect(AppColors.darkNavy, const Color(0xFF1E3A8A));
    });

    test('deepNavy has correct value', () {
      expect(AppColors.deepNavy, const Color(0xFF2E4094));
    });

    test('indigo has correct value', () {
      expect(AppColors.indigo, const Color(0xFF312E81));
    });

    test('indigoMid has correct value', () {
      expect(AppColors.indigoMid, const Color(0xFF4338CA));
    });

    test('blueBright has correct value', () {
      expect(AppColors.blueBright, const Color(0xFF2563EB));
    });
  });

  group('AppColors - Status / Action', () {
    test('logoutRed has correct value', () {
      expect(AppColors.logoutRed, const Color(0xFFE53935));
    });

    test('logoutBorder has correct value', () {
      expect(AppColors.logoutBorder, const Color(0xFFFFCDD2));
    });
  });

  group('AppColors - Chip / Badge Backgrounds', () {
    test('chipBgBlue has correct value', () {
      expect(AppColors.chipBgBlue, const Color(0xFFE0E7FF));
    });

    test('chipBgSlate has correct value', () {
      expect(AppColors.chipBgSlate, const Color(0xFFE2E8F0));
    });

    test('chipBgGreen has correct value', () {
      expect(AppColors.chipBgGreen, const Color(0xFFD1FAE5));
    });

    test('chipBgLightBlue has correct value', () {
      expect(AppColors.chipBgLightBlue, const Color(0xFFDBEAFE));
    });
  });

  group('AppColors - Color properties', () {
    test('all colors are fully opaque (alpha = 0xFF)', () {
      final opaqueColors = [
        AppColors.primary,
        AppColors.primaryLight,
        AppColors.primaryAccent,
        AppColors.textDark,
        AppColors.textDarkest,
        AppColors.textMuted,
        AppColors.cardBg,
        AppColors.historyBg,
        AppColors.darkCard,
        AppColors.divider,
        AppColors.accentGreen,
        AppColors.logoutRed,
      ];
      for (final color in opaqueColors) {
        expect(
          color.alpha,
          0xFF,
          reason: 'Expected $color to have full opacity',
        );
      }
    });

    // Regression: verify primary is distinct from primaryAccent
    test('primary and primaryAccent are different colors', () {
      expect(AppColors.primary, isNot(AppColors.primaryAccent));
    });

    // Boundary: darkCard is dark (low RGB values)
    test('darkCard has low luminance (is a dark color)', () {
      expect(AppColors.darkCard.computeLuminance(), lessThan(0.05));
    });
  });
}