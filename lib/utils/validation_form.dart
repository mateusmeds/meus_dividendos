class ValidationForm {
  static bool isValidIntegerNumber(String value) {
    if (int.tryParse(value) == null) {
      return false;
    }
    return true;
  }

  static bool isValidUnsignedIntegerNumber(String value) {
    if (isValidIntegerNumber(value) && int.parse(value) > 0) {
      return true;
    }
    return false;
  }

  static bool isEmpty(String? value) {
    if (value == null || value.isEmpty) {
      return true;
    }
    return false;
  }

  static bool containsSpacingStart(String value) {
    if (value.startsWith(' ')) {
      return true;
    }
    return false;
  }

  static bool containsSpacingEnd(String value) {
    if (value.endsWith(' ')) {
      return true;
    }
    return false;
  }

  static bool containsSpacing(String value) {
    if (value.contains(' ')) {
      return true;
    }
    return false;
  }

  static bool isValidTicker(String value) {
    RegExp regexTickerValid = RegExp(r'^[A-Z]{4}(3|4|5|6|7|8|11)$');
    if (regexTickerValid.hasMatch(value)) {
      return true;
    }
    return false;
  }
}
