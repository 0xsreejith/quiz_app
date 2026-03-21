import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/utils/display_helpers.dart';

void main() {
  group('DisplayHelpers.formatDisplayName', () {
    test('returns USER for empty email', () {
      expect(DisplayHelpers.formatDisplayName(''), equals('USER'));
    });

    test('extracts username before @ and uppercases it', () {
      expect(DisplayHelpers.formatDisplayName('john@example.com'), equals('JOHN'));
    });

    test('uppercases already-lowercase username', () {
      expect(DisplayHelpers.formatDisplayName('alice@domain.org'), equals('ALICE'));
    });

    test('uppercases mixed-case username', () {
      expect(DisplayHelpers.formatDisplayName('JohnDoe@example.com'), equals('JOHNDOE'));
    });

    test('handles username with dots and numbers', () {
      expect(DisplayHelpers.formatDisplayName('user.name123@test.io'), equals('USER.NAME123'));
    });

    test('handles email with multiple @ signs (takes first segment)', () {
      // split('@')[0] means only the part before the first @
      expect(DisplayHelpers.formatDisplayName('a@b@c.com'), equals('A'));
    });

    test('handles email with only @ sign — empty username becomes empty string uppercased', () {
      // '@domain.com' -> split('@')[0] == '' -> toUpperCase() == ''
      expect(DisplayHelpers.formatDisplayName('@domain.com'), equals(''));
    });

    test('handles email with uppercase domain (only username portion returned)', () {
      expect(DisplayHelpers.formatDisplayName('Quiz@EXAMPLE.COM'), equals('QUIZ'));
    });

    test('single-character username is uppercased', () {
      expect(DisplayHelpers.formatDisplayName('x@y.z'), equals('X'));
    });
  });

  group('DisplayHelpers.formatEmailDisplay', () {
    test('returns NO EMAIL AVAILABLE for empty email', () {
      expect(DisplayHelpers.formatEmailDisplay(''), equals('NO EMAIL AVAILABLE'));
    });

    test('uppercases a normal lowercase email', () {
      expect(DisplayHelpers.formatEmailDisplay('user@example.com'), equals('USER@EXAMPLE.COM'));
    });

    test('uppercases an already-uppercase email unchanged', () {
      expect(DisplayHelpers.formatEmailDisplay('USER@EXAMPLE.COM'), equals('USER@EXAMPLE.COM'));
    });

    test('uppercases mixed-case email', () {
      expect(DisplayHelpers.formatEmailDisplay('User@Example.Com'), equals('USER@EXAMPLE.COM'));
    });

    test('preserves special characters in email while uppercasing letters', () {
      expect(DisplayHelpers.formatEmailDisplay('user.name+tag@sub.domain.org'),
          equals('USER.NAME+TAG@SUB.DOMAIN.ORG'));
    });

    test('handles email with numbers (numbers unchanged)', () {
      expect(DisplayHelpers.formatEmailDisplay('user123@test456.com'), equals('USER123@TEST456.COM'));
    });

    test('single character email is uppercased', () {
      expect(DisplayHelpers.formatEmailDisplay('a@b.c'), equals('A@B.C'));
    });

    // Regression: ensure empty string check doesn't trigger for whitespace-only
    test('whitespace-only email is not treated as empty — uppercased as-is', () {
      // isEmpty returns false for ' ', so it goes to toUpperCase branch
      expect(DisplayHelpers.formatEmailDisplay('   '), equals('   '));
    });
  });
}