import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/app/sign_in/presentation/ui/widgets/auth_widget.dart';
import 'package:oasis/app/sign_up/presentation/bloc/sign_up.bloc.dart';
import 'package:oasis/app/sign_up/presentation/bloc/sign_up.event.dart';
import 'package:oasis/app/sign_up/presentation/bloc/sign_up.state.dart';
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
          onChanged: (value) {
            context.read<SignUpBloc>().add(NameEvent(value));
          },
        ),

        const SizedBox(height: 12),

        // Email field
        buildTextField(
          controller: _emailController,
          hintText: 'hello@example.com',
          obscureText: false,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            context.read<SignUpBloc>().add(EmailEvent(value));
          },
        ),

        const SizedBox(height: 12),

        // Password field
        buildTextField(
          controller: _passwordController,
          hintText: 'Enter Password',
          obscureText: _obscurePassword,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) {
            context.read<SignUpBloc>().add(PasswordEvent(value));
          },
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
          hintText: 'Confirm Password',
          obscureText: _obscureConfirmPassword,
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) {
            context.read<SignUpBloc>().add(PasswordConfirmationEvent(value));
          },
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

        BlocConsumer<SignUpBloc, SignUpState>(
          listener: (context, state) {
            debugPrint('--- STATE CHANGED ---');
            debugPrint('Name: ${state.name}');
            debugPrint('Email: ${state.email}');
            debugPrint('Password: ${state.password}');
            debugPrint('Confirm: ${state.passwordConfirmation}');
            debugPrint('Terms: ${state.terms}');
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: state.terms,
                      activeColor: const Color(0xFF7B6FE8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      onChanged: (value) => context.read<SignUpBloc>().add(
                        TermsEvent(value ?? false),
                      ),
                    ),
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                          children: const [
                            TextSpan(text: 'I agree to the '),
                            TextSpan(
                              text: 'Terms & Conditions ',
                              style: TextStyle(
                                color: Color(0xFF7B6FE8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(text: 'of Oasis and acknowledge the '),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: TextStyle(
                                color: Color(0xFF7B6FE8),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                buildPrimaryButton(
                  'Create Account',
                  onPressed: state.terms ? () {} : null,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: Colors.grey.shade300)),
                  ],
                ),
                const SizedBox(height: 24),
                buildGoogleButton(onPressed: () {}),
              ],
            );
          },
        ),

        // Rest — no state needed
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account?',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            InkWell(
              onTap: () => GoRouter.of(context).pop(),
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
