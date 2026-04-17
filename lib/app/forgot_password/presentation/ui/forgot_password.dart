import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/app/forgot_password/presentation/bloc/forgot_password/bloc.dart';
import 'package:oasis/app/forgot_password/presentation/bloc/forgot_password/events.dart';
import 'package:oasis/app/forgot_password/presentation/bloc/forgot_password/states.dart';
import 'package:oasis/app/forgot_password/presentation/bloc/reset_password/bloc.dart';
import 'package:oasis/app/forgot_password/presentation/bloc/reset_password/events.dart';
import 'package:oasis/app/forgot_password/presentation/bloc/reset_password/states.dart';
import 'package:oasis/app/sign_in/presentation/ui/widgets/auth_widget.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/components/widgets/page_header.dart';
import 'package:oasis/components/widgets/primary_button.dart';
import 'package:oasis/components/widgets/top_snackbar.dart';

class ForgotPasswordSheet extends StatefulWidget {
  const ForgotPasswordSheet({super.key});

  @override
  State<ForgotPasswordSheet> createState() => _ForgotPasswordSheetState();
}

class _ForgotPasswordSheetState extends State<ForgotPasswordSheet> {
  int _step = 0;

  final _emailController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _otpController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
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

  Widget _buildForgotStep() {
    return BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
      listener: (context, state) {
        if (state.status == FetchStatus.success) {
          context.read<ResetPasswordBloc>().add(
            ResetEmailEvent(_emailController.text.trim()),
          );
          setState(() => _step = 1);
          TopSnackbar.show('OTP sent successfully!');
        }
        if (state.status == FetchStatus.failure) {
          TopSnackbar.show(state.error ?? AppTexts.GENERIC_ERROR);
        }
      },
      builder: (context, state) {
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
              Center(child: Image.asset('images/broken-vase.png')),
              const SizedBox(height: 24),
              const Text(
                "Enter your email and we'll send a password reset OTP.",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              buildTextField(
                controller: _emailController,
                hintText: 'hello@example.com',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {
                  context.read<ForgotPasswordBloc>().add(
                    ForgotPasswordEmailEvent(val),
                  );
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: buildPrimaryButton(
                  state.status == FetchStatus.loading
                      ? 'Sending OTP...'
                      : 'Reset Password',
                  onPressed: state.status != FetchStatus.loading
                      ? () => context.read<ForgotPasswordBloc>().add(
                          const SubmitForgotPasswordEvent(),
                        )
                      : null,
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
                        style: TextStyle(color: AppColors.accent),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  Widget _buildResetStep() {
    return BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
      listener: (context, state) {
        if (state.status == FetchStatus.success) {
          GoRouter.of(context).pop();
          TopSnackbar.show('Password reset successfully!');
        }
        if (state.status == FetchStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error ?? 'Something went wrong')),
          );
        }
      },
      builder: (context, state) {
        return Container(
          key: const ValueKey('reset'),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PageHeader(
                title: 'Reset Password',
                textStyle: Theme.of(context).textTheme,
                onTap: () => setState(() => _step = 0),
              ),
              const SizedBox(height: 24),
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

              // Email - pre-filled from step 1, user can correct if needed
              buildTextField(
                controller: _emailController,
                hintText: 'hello@example.com',
                obscureText: false,
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) {
                  context.read<ResetPasswordBloc>().add(ResetEmailEvent(val));
                },
              ),

              const SizedBox(height: 12),
              // OTP field
              buildTextField(
                controller: _otpController,
                hintText: 'Enter OTP',
                obscureText: false,
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  context.read<ResetPasswordBloc>().add(OtpEvent(val));
                },
              ),
              const SizedBox(height: 12),
              // New password
              buildTextField(
                controller: _newPasswordController,
                hintText: 'Enter new password',
                obscureText: _obscurePassword,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (val) {
                  context.read<ResetPasswordBloc>().add(
                    ResetPasswordEvent(val),
                  );
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
              const SizedBox(height: 12),
              // Confirm password
              buildTextField(
                controller: _confirmPasswordController,
                hintText: 'Confirm new password',
                obscureText: _obscureConfirmPassword,
                keyboardType: TextInputType.visiblePassword,
                onChanged: (val) {
                  context.read<ResetPasswordBloc>().add(
                    ResetPasswordConfirmationEvent(val),
                  );
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
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: buildPrimaryButton(
                  state.status == FetchStatus.loading
                      ? 'Resetting...'
                      : 'Reset Password',
                  onPressed: state.status != FetchStatus.loading
                      ? () => context.read<ResetPasswordBloc>().add(
                          const SubmitResetEvent(),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
