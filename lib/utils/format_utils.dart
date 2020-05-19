class FormatUtils {
  static bool isEmailValid(String email) {
    if (email == null) return false;
    return RegExp(r"^[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]+$")
        .hasMatch(email);
  }

  static bool isPhoneNumberValid(String phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return false;
    }
    return formatPhoneNumber(phoneNumber).length == 10;
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber == null || phoneNumber.isEmpty) {
      return '';
    }
    return phoneNumber
        .replaceAll('(', '')
        .replaceAll(')', '')
        .replaceAll('+', '');
  }
}
