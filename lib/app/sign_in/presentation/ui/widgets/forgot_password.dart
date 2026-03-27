import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/app/sign_in/presentation/ui/widgets/auth_widget.dart';
import 'package:oasis/components/widgets/page_header.dart';
import 'package:oasis/components/widgets/primary_button.dart';

class ForgotPasswordSheet extends StatefulWidget {
  const ForgotPasswordSheet({super.key});

  @override
  State<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  int _step = 0; // 0 = forgot password, 1 = reset password

  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: _step == 0 ? _buildForgotStep() : _buildResetStep(),
      ),
    );
  }

  // Step 1 - Forgot Password
  Widget _buildForgotStep() {
    return Container(
      key: const ValueKey('forgot'),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageHeader(
            title: 'Forgot Password',
            textStyle: Theme.of(context).textTheme,
            onTap: () => GoRouter.of(context).pop(),
          ),
          const SizedBox(height: 24),
          const Text("Enter your email and we'll send a password reset OTP"),
          const SizedBox(height: 16),

          // email
          buildTextField(
            controller: _emailController,
            hintText: 'hello@example.com',
            obscureText: false,
            keyboardType: TextInputType.emailAddress,
            onChanged: (val) {},
          ),

          const SizedBox(height: 16),

          // Reset Password Button
          SizedBox(
            width: double.infinity,
            child: buildPrimaryButton(
              'Reset Password',
              onPressed: () {
                setState(() {
                  _step = 1;
                });
              },
            ),
          ),

          const SizedBox(height: 12),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Remembered your password? "),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Text(
                    'Back to login',
                    style: TextStyle(color: Colors.deepPurple),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Step 2 - Reset Password
  Widget _buildResetStep() {
    return Container(
      key: const ValueKey('reset'),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          PageHeader(
            title: 'Reset Password',
            textStyle: Theme.of(context).textTheme,
            onTap: () => Navigator.pop(context),
          ),

          const SizedBox(height: 24),
          // Checkmark icon
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.deepPurple.shade50,
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.deepPurple.shade300,
              size: 40,
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            'Create new password',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 8),
          const Text(
            'Your new password must be different from previously used passwords.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey),
          ),

          const SizedBox(height: 24),
          // new password
          buildTextField(
            controller: _newPasswordController,
            hintText: 'Enter new password',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {},
          ),

          const SizedBox(height: 12),
          // Confirm New Password
          buildTextField(
            controller: _confirmPasswordController,
            hintText: 'Confirm new password',
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) {},
          ),

          const SizedBox(height: 16),
          // Final reset password
          // TO-DO improve the logic of password reset here
          SizedBox(
            width: double.infinity,
            child: buildPrimaryButton(
              'Reset Password',
              onPressed: () {
                GoRouter.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
