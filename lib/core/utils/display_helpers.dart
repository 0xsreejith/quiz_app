/// Pure display-formatting helpers. No UI code, no controllers, no network.
abstract final class DisplayHelpers {
  /// Extracts username from an email address and uppercases it.
  /// Returns `'USER'` if the email is empty.
  static String formatDisplayName(String email) {
    if (email.isEmpty) return 'USER';
    return email.split('@')[0].toUpperCase();
  }

  /// Returns the uppercased email, or a fallback string.
  static String formatEmailDisplay(String email) {
    if (email.isEmpty) return 'NO EMAIL AVAILABLE';
    return email.toUpperCase();
  }
}
