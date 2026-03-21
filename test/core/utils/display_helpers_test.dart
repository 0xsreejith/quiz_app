import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/core/utils/display_helpers.dart';

void main() {
  group('DisplayHelpers.formatDisplayName', () {
    test('extracts local part from email and uppercases it', () {
      expect(DisplayHelpers.formatDisplayName('john@example.com'), 'JOHN');
    });

    test('returns USER for empty email', () {
      expect(DisplayHelpers.formatDisplayName(''), 'USER');
    });

    test('uppercases mixed-case local part', () {
      expect(
        DisplayHelpers.formatDisplayName('JohnDoe@example.com'),
        'JOHNDOE',
      );
    });

    test('handles email with no domain (just local part with @)', () {
      expect(DisplayHelpers.formatDisplayName('alice@'), 'ALICE');
    });

    test('handles email with multiple @ characters', () {
      // split('@')[0] returns the first segment
      expect(
        DisplayHelpers.formatDisplayName('user@sub@domain.com'),
        'USER',
      );
    });

    test('handles email with numbers and special chars in local part', () {
      expect(
        DisplayHelpers.formatDisplayName('user.name+tag123@example.com'),
        'USER.NAME+TAG123',
      );
    });

    test('handles email with only uppercase letters', () {
      expect(
        DisplayHelpers.formatDisplayName('ADMIN@example.com'),
        'ADMIN',
      );
    });

    test('returns USER for whitespace-only email treated as non-empty', () {
      // whitespace email is not empty, so it passes the isEmpty check
      // split('@')[0] returns the whitespace string uppercased
      expect(
        DisplayHelpers.formatDisplayName('   @domain.com'),
        '   ',
      );
    });
  });

  group('DisplayHelpers.formatEmailDisplay', () {
    test('returns uppercase version of a valid email', () {
      expect(
        DisplayHelpers.formatEmailDisplay('user@example.com'),
        'USER@EXAMPLE.COM',
      );
    });

    test('returns NO EMAIL AVAILABLE for empty string', () {
      expect(DisplayHelpers.formatEmailDisplay(''), 'NO EMAIL AVAILABLE');
    });

    test('uppercases already-uppercase email unchanged', () {
      expect(
        DisplayHelpers.formatEmailDisplay('ADMIN@EXAMPLE.COM'),
        'ADMIN@EXAMPLE.COM',
      );
    });

    test('uppercases mixed-case email', () {
      expect(
        DisplayHelpers.formatEmailDisplay('John.Doe@Example.COM'),
        'JOHN.DOE@EXAMPLE.COM',
      );
    });

    test('uppercases email with numbers unchanged for digits', () {
      expect(
        DisplayHelpers.formatEmailDisplay('user123@test.org'),
        'USER123@TEST.ORG',
      );
    });

    test('uppercases email with dots and hyphens in domain', () {
      expect(
        DisplayHelpers.formatEmailDisplay('a@sub.domain.co.uk'),
        'A@SUB.DOMAIN.CO.UK',
      );
    });

    // Regression: confirm NO EMAIL AVAILABLE is not returned for non-empty input
    test('does not return fallback for non-empty email', () {
      final result = DisplayHelpers.formatEmailDisplay('x@y.z');
      expect(result, isNot('NO EMAIL AVAILABLE'));
    });
  });
}