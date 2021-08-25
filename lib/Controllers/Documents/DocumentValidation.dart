class DocumentValidation {
  static String patternNIC = r'^([0-9]{9}[x|X|v|V]|[0-9]{12})$';
  static String patternPassport = r'^(?!^0+$)[a-zA-Z0-9]{3,20}$';

  bool validation(String value, String pattern) {
    if (value.length == 0) {
      return false;
    } else if (!RegExp(pattern).hasMatch(value)) {
      return false;
    } else {
      return true;
    }
  }
}
