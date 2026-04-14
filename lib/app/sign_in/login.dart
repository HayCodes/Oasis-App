import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/app/sign_in/presentation/bloc/auth.bloc.dart';
import 'package:oasis/app/sign_in/presentation/bloc/auth.event.dart';
import 'package:oasis/app/sign_in/presentation/bloc/auth.state.dart';
import 'package:oasis/app/sign_in/presentation/ui/widgets/auth_widget.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/components/widgets/page_header.dart';
import 'package:oasis/services/router/app_router_constants.dart';

class Auth extends StatefulWidget {
  const Auth({super.key});

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _onLoginPressed() {
    context.read<AuthBloc>().add(const SubmitLoginEvent());
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
              title: 'Login',
              textStyle: textStyle,
              onTap: () {
                GoRouter.of(context).pushReplacementNamed(RouteNames.home);
              },
            ),
            // Body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: _buildAuthForm(textStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAuthForm(TextTheme textStyle) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 32),

        // Plant image
        Center(
          child: Image.asset(
            'images/flower-vase.png',
            height: 180,
            fit: BoxFit.contain,
          ),
        ),

        const SizedBox(height: 32),

        // Welcome text
        Text(
          'Welcome back',
          style: textStyle.titleMedium?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),

        const SizedBox(height: 20),

        // Email field
        buildTextField(
          controller: _emailController,
          hintText: 'hello@example.com',
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          onChanged: (val) {
            context.read<AuthBloc>().add(EmailEvent(val));
          },
        ),

        const SizedBox(height: 12),

        // Password field
        buildTextField(
          controller: _passwordController,
          hintText: 'Enter your password',
          keyboardType: TextInputType.visiblePassword,
          obscureText: _obscurePassword,
          onChanged: (val) {
            context.read<AuthBloc>().add(PasswordEvent(val));
          },
          suffixIcon: IconButton(
            onPressed: () => setState(() {
              _obscurePassword = !_obscurePassword;
            }),
            icon: Icon(
              _obscurePassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ),
        ),

        const SizedBox(height: 8),

        BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == FetchStatus.success) {
              GoRouter.of(context).goNamed(RouteNames.home);
            }
            if (state.status == FetchStatus.failure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error ?? 'Something went wrong')),
              );
            }
          },
          listenWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Forgot password
                forgotPassword(context),

                const SizedBox(height: 20),

                // Login button
                buildActionButton(
                  state.status == FetchStatus.loading
                      ? 'Logging In...'
                      : 'Login',
                  onPressed: state.status != FetchStatus.loading
                      ? _onLoginPressed
                      : null,
                ),

                const SizedBox(height: 24),

                // OR divider
                const Row(
                  children: [
                    Expanded(child: Divider(color: AppColors.inputBorder)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'OR',
                        style: TextStyle(
                          color: AppColors.inputBorder,
                          fontSize: 13,
                        ),
                      ),
                    ),
                    Expanded(child: Divider(color: AppColors.inputBorder)),
                  ],
                ),

                const SizedBox(height: 24),

                // Continue with Google
                buildGoogleButton(onPressed: () {}),

                const SizedBox(height: 24),
              ],
            );
          },
        ),

        // Sign up link
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'First time here? ',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
            ),
            GestureDetector(
              onTap: () {
                GoRouter.of(context).pushNamed(RouteNames.signup);
              },
              child: const Text(
                'Create an account',
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
