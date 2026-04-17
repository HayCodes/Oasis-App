import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oasis/app/forgot_password/presentation/ui/forgot_password.dart';

Widget forgotPassword(BuildContext context) {
  void showForgotPassword() {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ForgotPasswordSheet(),
      isScrollControlled: true,
    );
  }

  return Align(
    alignment: Alignment.centerRight,
    child: TextButton(
      onPressed: showForgotPassword,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: const Text(
        'Forgot password?',
        style: TextStyle(color: Color(0xFF7B6FE8), fontSize: 14),
      ),
    ),
  );
}

Widget buildTextField({
  required TextEditingController controller,
  required String hintText,
  required bool obscureText,
  required TextInputType keyboardType,
  required Function(String) onChanged,
  Widget? suffixIcon,
}) {
  return TextField(
    controller: controller,
    keyboardType: keyboardType,
    obscureText: obscureText,
    onChanged: onChanged,
    decoration: InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(50),
        borderSide: const BorderSide(color: Color(0xFF7B6FE8), width: 1.5),
      ),
    ),
  );
}

Widget buildActionButton(String title, {required VoidCallback? onPressed}) {
  return SizedBox(
    height: 56,
    child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF7B6FE8),
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      child: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
  );
}

Widget buildGoogleButton({required VoidCallback onPressed}) {
  return SizedBox(
    height: 56,
    child: OutlinedButton.icon(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.black87,
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
      ),
      icon: const FaIcon(FontAwesomeIcons.google, size: 24),
      label: const Text(
        'Continue with Google',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
  );
}
