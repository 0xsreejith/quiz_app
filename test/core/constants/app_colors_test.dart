import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_colors.dart';

void main() {
  group('AppColors — primary palette', () {
    test('primary has correct ARGB value', () {
      expect(AppColors.primary, equals(const Color(0xFF3F51B5)));
    });

    test('primaryLight has correct ARGB value', () {
      expect(AppColors.primaryLight, equals(const Color(0xFFE8EAF6)));
    });

    test('primaryAccent has correct ARGB value', () {
      expect(AppColors.primaryAccent, equals(const Color(0xFF5C6BC0)));
    });
  });

  group('AppColors — text', () {
    test('textDark has correct ARGB value', () {
      expect(AppColors.textDark, equals(const Color(0xFF1A1D2E)));
    });

    test('textDarkest has correct ARGB value', () {
      expect(AppColors.textDarkest, equals(const Color(0xFF111827)));
    });

    test('textMuted has correct ARGB value', () {
      expect(AppColors.textMuted, equals(const Color(0xFF7C8495)));
    });
  });

  group('AppColors — surfaces', () {
    test('cardBg has correct ARGB value', () {
      expect(AppColors.cardBg, equals(const Color(0xFFF7F8FC)));
    });

    test('historyBg has correct ARGB value', () {
      expect(AppColors.historyBg, equals(const Color(0xFFF4F6F9)));
    });

    test('darkCard has correct ARGB value', () {
      expect(AppColors.darkCard, equals(const Color(0xFF282828)));
    });

    test('divider has correct ARGB value', () {
      expect(AppColors.divider, equals(const Color(0xFFE8ECF2)));
    });

    test('avatarBg has correct ARGB value', () {
      expect(AppColors.avatarBg, equals(const Color(0xFFE0E4EB)));
    });

    test('avatarIcon has correct ARGB value', () {
      expect(AppColors.avatarIcon, equals(const Color(0xFFB0B8C9)));
    });
  });

  group('AppColors — semantic', () {
    test('accentGreen has correct ARGB value', () {
      expect(AppColors.accentGreen, equals(const Color(0xFF4CAF50)));
    });

    test('emerald has correct ARGB value', () {
      expect(AppColors.emerald, equals(const Color(0xFF047857)));
    });

    test('starColor has correct ARGB value', () {
      expect(AppColors.starColor, equals(const Color(0xFFD4B96A)));
    });

    test('darkNavy has correct ARGB value', () {
      expect(AppColors.darkNavy, equals(const Color(0xFF1E3A8A)));
    });

    test('deepNavy has correct ARGB value', () {
      expect(AppColors.deepNavy, equals(const Color(0xFF2E4094)));
    });

    test('indigo has correct ARGB value', () {
      expect(AppColors.indigo, equals(const Color(0xFF312E81)));
    });

    test('indigoMid has correct ARGB value', () {
      expect(AppColors.indigoMid, equals(const Color(0xFF4338CA)));
    });

    test('blueBright has correct ARGB value', () {
      expect(AppColors.blueBright, equals(const Color(0xFF2563EB)));
    });
  });

  group('AppColors — status / action', () {
    test('logoutRed has correct ARGB value', () {
      expect(AppColors.logoutRed, equals(const Color(0xFFE53935)));
    });

    test('logoutBorder has correct ARGB value', () {
      expect(AppColors.logoutBorder, equals(const Color(0xFFFFCDD2)));
    });
  });

  group('AppColors — chip / badge backgrounds', () {
    test('chipBgBlue has correct ARGB value', () {
      expect(AppColors.chipBgBlue, equals(const Color(0xFFE0E7FF)));
    });

    test('chipBgSlate has correct ARGB value', () {
      expect(AppColors.chipBgSlate, equals(const Color(0xFFE2E8F0)));
    });

    test('chipBgGreen has correct ARGB value', () {
      expect(AppColors.chipBgGreen, equals(const Color(0xFFD1FAE5)));
    });

    test('chipBgLightBlue has correct ARGB value', () {
      expect(AppColors.chipBgLightBlue, equals(const Color(0xFFDBEAFE)));
    });
  });

  group('AppColors — all colors are fully opaque', () {
    test('all defined colors have opacity 1.0 (fully opaque)', () {
      final colors = <String, Color>{
        'primary': AppColors.primary,
        'primaryLight': AppColors.primaryLight,
        'primaryAccent': AppColors.primaryAccent,
        'textDark': AppColors.textDark,
        'textDarkest': AppColors.textDarkest,
        'textMuted': AppColors.textMuted,
        'cardBg': AppColors.cardBg,
        'historyBg': AppColors.historyBg,
        'darkCard': AppColors.darkCard,
        'divider': AppColors.divider,
        'avatarBg': AppColors.avatarBg,
        'avatarIcon': AppColors.avatarIcon,
        'accentGreen': AppColors.accentGreen,
        'emerald': AppColors.emerald,
        'starColor': AppColors.starColor,
        'darkNavy': AppColors.darkNavy,
        'deepNavy': AppColors.deepNavy,
        'indigo': AppColors.indigo,
        'indigoMid': AppColors.indigoMid,
        'blueBright': AppColors.blueBright,
        'logoutRed': AppColors.logoutRed,
        'logoutBorder': AppColors.logoutBorder,
        'chipBgBlue': AppColors.chipBgBlue,
        'chipBgSlate': AppColors.chipBgSlate,
        'chipBgGreen': AppColors.chipBgGreen,
        'chipBgLightBlue': AppColors.chipBgLightBlue,
      };

      for (final entry in colors.entries) {
        expect(
          entry.value.opacity,
          equals(1.0),
          reason: '${entry.key} should be fully opaque',
        );
      }
    });
  });
}