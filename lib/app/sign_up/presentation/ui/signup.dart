import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/app/sign_in/presentation/ui/widgets/auth_widget.dart';
import 'package:oasis/components/themes/app_theme.dart';

import 'package:oasis/components/widgets/page_header.dart';
import 'package:oasis/components/widgets/primary_button.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            PageHeader(
              title: 'Create Account',
              textStyle: textStyle,
              onTap: () {
                GoRouter.of(context).pop();
              },
            ),

            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildSignUpForm(textStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSignUpForm(TextTheme textStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Plant image
        Center(
          child: Image.asset(
            'images/stand.png',
            height: 180,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 32),

        // Welcome text
        Text(
          "Let's get your account set up",
          style: textStyle.titleMedium?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),

        const SizedBox(height: 20),

        // name field
        buildTextField(
          controller: _nameController,
          hintText: 'Full name',
          obscureText: false,
          keyboardType: TextInputType.name,
          onChanged: (value) {},
        ),

        const SizedBox(height: 12),

        // Email field
        buildTextField(
          controller: _emailController,
          hintText: 'hello@example.com',
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {},
        ),

        const SizedBox(height: 12),

        // Password field
        buildTextField(
          controller: _passwordController,
          hintText: 'Enter Password',
          obscureText: _obscurePassword,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) {},
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.grey.shade400,
              size: 20,
            ),
            onPressed: () =>
                setState(() => _obscurePassword = !_obscurePassword),
          ),
        ),

        const SizedBox(height: 8),

        // Confirm Password field
        buildTextField(
          controller: _passwordConfirmController,
          hintText: 'Enter Password',
          obscureText: _obscureConfirmPassword,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) {},
          suffixIcon: IconButton(
            icon: Icon(
              _obscureConfirmPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.grey.shade400,
              size: 20,
            ),
            onPressed: () => setState(
              () => _obscureConfirmPassword = !_obscureConfirmPassword,
            ),
          ),
        ),

        const SizedBox(height: 20),
        // Signup button
        buildPrimaryButton('Create Account', onPressed: () => {}),

        const SizedBox(height: 24),
        // OR divider
        Row(
          children: [
            Expanded(child: Divider(color: Colors.grey.shade300)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                'OR',
                style: TextStyle(color: Colors.grey.shade400, fontSize: 13),
              ),
            ),
            Expanded(child: Divider(color: Colors.grey.shade300)),
          ],
        ),

        const SizedBox(height: 24),
        // Continue with Google
        buildGoogleButton(onPressed: () => {}),

        const SizedBox(height: 24),
        // Sign in link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account?',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            InkWell(
              onTap: () {
                GoRouter.of(context).pop();
              },
              child: const Text(
                ' Log in',
                style: TextStyle(
                  color: Color(0xFF7B6FE8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 32),
      ],
    );
  }
}
