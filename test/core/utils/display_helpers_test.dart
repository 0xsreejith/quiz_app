import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/utils/display_helpers.dart';

void main() {
  group('DisplayHelpers.formatDisplayName', () {
    test('returns USER for empty email', () {
      expect(DisplayHelpers.formatDisplayName(''), equals('USER'));
    });

    test('extracts username part before @', () {
      expect(DisplayHelpers.formatDisplayName('john@example.com'), equals('JOHN'));
    });

    test('uppercases the extracted username', () {
      expect(DisplayHelpers.formatDisplayName('alice.smith@gmail.com'), equals('ALICE.SMITH'));
    });

    test('handles email with no username (only @domain)', () {
      // split('@')[0] returns empty string for '@example.com'
      expect(DisplayHelpers.formatDisplayName('@example.com'), equals(''));
    });

    test('handles email with multiple @ symbols — uses first segment', () {
      // Dart split('@') splits at every @; [0] is always the local part
      expect(DisplayHelpers.formatDisplayName('user@host@extra.com'), equals('USER'));
    });

    test('preserves dots and underscores in username', () {
      expect(DisplayHelpers.formatDisplayName('first.last_name@domain.org'), equals('FIRST.LAST_NAME'));
    });

    test('handles already-uppercase email', () {
      expect(DisplayHelpers.formatDisplayName('ADMIN@company.io'), equals('ADMIN'));
    });

    test('handles username with numbers', () {
      expect(DisplayHelpers.formatDisplayName('user123@test.com'), equals('USER123'));
    });

    test('handles single-character username', () {
      expect(DisplayHelpers.formatDisplayName('a@b.com'), equals('A'));
    });
  });

  group('DisplayHelpers.formatEmailDisplay', () {
    test('returns NO EMAIL AVAILABLE for empty email', () {
      expect(DisplayHelpers.formatEmailDisplay(''), equals('NO EMAIL AVAILABLE'));
    });

    test('uppercases a standard email', () {
      expect(DisplayHelpers.formatEmailDisplay('user@example.com'), equals('USER@EXAMPLE.COM'));
    });

    test('handles already-uppercase email without duplication', () {
      expect(DisplayHelpers.formatEmailDisplay('USER@EXAMPLE.COM'), equals('USER@EXAMPLE.COM'));
    });

    test('uppercases mixed-case email', () {
      expect(DisplayHelpers.formatEmailDisplay('Alice.Smith@Gmail.Com'), equals('ALICE.SMITH@GMAIL.COM'));
    });

    test('preserves special characters such as dots and plus signs', () {
      expect(
        DisplayHelpers.formatEmailDisplay('first+tag@sub.domain.org'),
        equals('FIRST+TAG@SUB.DOMAIN.ORG'),
      );
    });

    test('handles email with numbers', () {
      expect(DisplayHelpers.formatEmailDisplay('user123@test99.net'), equals('USER123@TEST99.NET'));
    });

    // Boundary / regression: whitespace-only string treated as non-empty
    test('non-empty whitespace string is uppercased (not treated as empty)', () {
      expect(DisplayHelpers.formatEmailDisplay('   '), equals('   '));
    });
  });
}