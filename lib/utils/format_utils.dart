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

  static bool isToday(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    return today == aDate;
  }

  static bool isYesterday(DateTime dateTime) {
    final now = DateTime.now();
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final aDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    return yesterday == aDate;
  }

}
