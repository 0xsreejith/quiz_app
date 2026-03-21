import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/constants/app_colors.dart';

void main() {
  group('AppColors — primary palette', () {
    test('primary is correct indigo-blue hex', () {
      expect(AppColors.primary, equals(const Color(0xFF3F51B5)));
    });

    test('primaryLight is correct light indigo hex', () {
      expect(AppColors.primaryLight, equals(const Color(0xFFE8EAF6)));
    });

    test('primaryAccent is correct accent indigo hex', () {
      expect(AppColors.primaryAccent, equals(const Color(0xFF5C6BC0)));
    });
  });

  group('AppColors — text colors', () {
    test('textDark has correct value', () {
      expect(AppColors.textDark, equals(const Color(0xFF1A1D2E)));
    });

    test('textDarkest has correct value', () {
      expect(AppColors.textDarkest, equals(const Color(0xFF111827)));
    });

    test('textMuted has correct value', () {
      expect(AppColors.textMuted, equals(const Color(0xFF7C8495)));
    });
  });

  group('AppColors — surfaces', () {
    test('cardBg has correct value', () {
      expect(AppColors.cardBg, equals(const Color(0xFFF7F8FC)));
    });

    test('historyBg has correct value', () {
      expect(AppColors.historyBg, equals(const Color(0xFFF4F6F9)));
    });

    test('darkCard has correct value', () {
      expect(AppColors.darkCard, equals(const Color(0xFF282828)));
    });

    test('divider has correct value', () {
      expect(AppColors.divider, equals(const Color(0xFFE8ECF2)));
    });

    test('avatarBg has correct value', () {
      expect(AppColors.avatarBg, equals(const Color(0xFFE0E4EB)));
    });

    test('avatarIcon has correct value', () {
      expect(AppColors.avatarIcon, equals(const Color(0xFFB0B8C9)));
    });
  });

  group('AppColors — semantic colors', () {
    test('accentGreen has correct value', () {
      expect(AppColors.accentGreen, equals(const Color(0xFF4CAF50)));
    });

    test('emerald has correct value', () {
      expect(AppColors.emerald, equals(const Color(0xFF047857)));
    });

    test('starColor has correct value', () {
      expect(AppColors.starColor, equals(const Color(0xFFD4B96A)));
    });

    test('darkNavy has correct value', () {
      expect(AppColors.darkNavy, equals(const Color(0xFF1E3A8A)));
    });

    test('deepNavy has correct value', () {
      expect(AppColors.deepNavy, equals(const Color(0xFF2E4094)));
    });

    test('indigo has correct value', () {
      expect(AppColors.indigo, equals(const Color(0xFF312E81)));
    });

    test('indigoMid has correct value', () {
      expect(AppColors.indigoMid, equals(const Color(0xFF4338CA)));
    });

    test('blueBright has correct value', () {
      expect(AppColors.blueBright, equals(const Color(0xFF2563EB)));
    });
  });

  group('AppColors — status / action', () {
    test('logoutRed has correct value', () {
      expect(AppColors.logoutRed, equals(const Color(0xFFE53935)));
    });

    test('logoutBorder has correct value', () {
      expect(AppColors.logoutBorder, equals(const Color(0xFFFFCDD2)));
    });
  });

  group('AppColors — chip/badge backgrounds', () {
    test('chipBgBlue has correct value', () {
      expect(AppColors.chipBgBlue, equals(const Color(0xFFE0E7FF)));
    });

    test('chipBgSlate has correct value', () {
      expect(AppColors.chipBgSlate, equals(const Color(0xFFE2E8F0)));
    });

    test('chipBgGreen has correct value', () {
      expect(AppColors.chipBgGreen, equals(const Color(0xFFD1FAE5)));
    });

    test('chipBgLightBlue has correct value', () {
      expect(AppColors.chipBgLightBlue, equals(const Color(0xFFDBEAFE)));
    });
  });

  group('AppColors — opacity and alpha', () {
    test('all primary palette colors are fully opaque', () {
      expect(AppColors.primary.alpha, equals(255));
      expect(AppColors.primaryLight.alpha, equals(255));
      expect(AppColors.primaryAccent.alpha, equals(255));
    });

    test('text colors are fully opaque', () {
      expect(AppColors.textDark.alpha, equals(255));
      expect(AppColors.textDarkest.alpha, equals(255));
      expect(AppColors.textMuted.alpha, equals(255));
    });
  });

  group('AppColors — distinctness', () {
    test('primary and primaryLight are different colors', () {
      expect(AppColors.primary, isNot(equals(AppColors.primaryLight)));
    });

    test('textDark and textDarkest are different colors', () {
      expect(AppColors.textDark, isNot(equals(AppColors.textDarkest)));
    });

    test('logoutRed and logoutBorder are different colors', () {
      expect(AppColors.logoutRed, isNot(equals(AppColors.logoutBorder)));
    });

    test('darkNavy and deepNavy are different colors', () {
      expect(AppColors.darkNavy, isNot(equals(AppColors.deepNavy)));
    });
  });
}