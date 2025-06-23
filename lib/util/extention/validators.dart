class Validator {
  static final RegExp _emailRegex = RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$');

  static final RegExp _passwordRegex = RegExp(
    r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$&*~]).{8,}$',
  );

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email must be entered";
    } else if (!_emailRegex.hasMatch(value)) {
      return "Enter a valid email";
    }
    return null;
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return "Password must be entered";
    } else if (!_passwordRegex.hasMatch(value)) {
      return "Password must have A-Z, a-z, 0-9 & symbol and at least 8 characters.";
    }
    return null;
  }

  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return "Name must be entered";
    }
    return null;
  }

  static String? validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return "Password must be entered";
    } else if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }
}
