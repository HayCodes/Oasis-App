import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/common/typedefs.dart';
import 'package:oasis/components/themes/app_theme.dart';

class Validator {
  static String? validateEmail(String? value) {
    final regex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    );
    if (!regex.hasMatch(value ?? '')) {
      return 'Please enter a valid email address.';
    } else {
      return null;
    }
  }

  static String? validateFullName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name.';
    } else if (value
        .split(' ')
        .length != 2 ||
        value.split(' ').any((e) => e.isEmpty || e.length < 2)) {
      return 'Please enter a valid full name.';
    } else {
      return null;
    }
  }

  static String? validateText(String? val,
      String? label, [
        int? length,
      ]) {
    if (val == null || val.isEmpty) {
      return '$label cannot be empty';
    } else if (length != null && val.length < length) {
      return '$label must be at least $length characters';
    } else {
      return null;
    }
  }

  static String? validatePassword(String? password) {
    if (password == null) return 'Password cannot be empty';

    // Check for at least one uppercase letter
    final upperRegex = RegExp('[A-Z]');
    if (!upperRegex.hasMatch(password)) {
      return 'Your password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    final lowerRegex = RegExp('[a-z]');
    if (!lowerRegex.hasMatch(password)) {
      return 'Your password must contain at least one lowercase letter';
    }

    // Check for at least one number
    final numberRegex = RegExp('[0-9]');
    if (!numberRegex.hasMatch(password)) {
      return 'Your password must contain at least one number';
    }

    // Check for at least one special character
    final specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
    if (!specialCharRegex.hasMatch(password)) {
      return 'Your password must contain a special character';
    }

    // Check length
    if (password.length < 8) {
      return 'Your password must be at least 8 characters';
    }
    return null;
  }

  static bool checkForLowerCase(String? password) {
    if (password!.contains(RegExp('[a-z]'))) {
      return true;
    }
    return false;
  }

  static bool checkForUpperCase(String? password) {
    if (password!.contains(RegExp('[A-Z]'))) {
      return true;
    }
    return false;
  }

  static bool checkForNumber(String? password) {
    if (password!.contains(RegExp('[0-9]'))) {
      return true;
    }
    return false;
  }

  static bool checkForSpecialCharacter(String? password) {
    if (password!.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return true;
    }
    return false;
  }

  static bool checkForLength(String? password) {
    if (password!.length >= 7) {
      return true;
    }
    return false;
  }

  static bool checkForAll(String? password) {
    if (checkForLowerCase(password) &&
        checkForUpperCase(password) &&
        checkForNumber(password) &&
        checkForSpecialCharacter(password) &&
        checkForLength(password)) {
      return true;
    }
    return false;
  }

  static bool checkPasswordCases(String password) {
    if (checkForLowerCase(password) &&
        checkForUpperCase(password) &&
        checkForNumber(password)) {
      return true;
    }
    return false;
  }

  static DynamicMap getPasswordStrength(String password) {
    if (checkForAll(password)) {
      return {
        'percent': 1.0,
        'color': AppColors.accent.withValues(alpha: 0.8),
      };
    } else if (checkForSpecialCharacter(password) && checkForLength(password) ||
        checkForLowerCase(password) &&
            checkForUpperCase(password) &&
            checkForNumber(password)) {
      return {
        'percent': 0.6,
        'color': const Color(0xFFFFC13F).withValues(alpha: 0.52),
      };
    } else {
      return {
        'percent': 0.3,
        'color': const Color(0xFFE3022C).withValues(alpha: 0.52),
      };
    }
  }

  static MaskTextInputFormatter dobFormatter = MaskTextInputFormatter(
    mask: '####-##-##',
    filter: {"#": RegExp('[0-9]')},
  );

}
