class Validator {
  static String? validateEmpty(String value) {
    return value.isNotEmpty ? null : 'The field cannot be empty';
  }
}
