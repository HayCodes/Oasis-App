import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/core/database/database.dart';
import 'package:oasis/core/integrations/integrations.dart';
import 'package:oasis/locator.dart';
import 'package:oasis/services/router/app_router_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _textFade;
  late Animation<double> _logoScale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _logoScale = Tween<double>(begin: 0.85, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
      ),
    );
    _textFade = Tween<double>(begin: 0, end: 2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );

    _controller.forward();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(milliseconds: 3000));

    if (!mounted) return;

    final secureStorage = sl<SecureStorage>();
    final expiry = await secureStorage.read(DbKeys.TOKEN_EXPIRY);

    if (!mounted) return;
    debugPrint('token expiry: $expiry');
    if (expiry == null) {
      GoRouter.of(context).goNamed(RouteNames.home);
      return;
    }
    final expiryTime = DateTime.fromMillisecondsSinceEpoch(
      int.parse(expiry) * 1000,
    );
    final isExpired = expiryTime.isBefore(DateTime.now());

    debugPrint('isExpired: $isExpired');
    if (isExpired) {
      GoRouter.of(context).goNamed(RouteNames.auth);
      return;
    }

    // Token is still valid — resume the refresh cycle
    sl<ApiClient>().tokenInterceptor.scheduleRefreshFromExpiry(
      int.parse(expiry),
    );

    GoRouter.of(context).goNamed(RouteNames.home);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FadeTransition(
                  opacity: _textFade,
                  child: ScaleTransition(
                    scale: _logoScale,
                    child: _buildFullBrand(),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildFullBrand() {
    return const Image(image: AssetImage('images/Oasis.png'));
  }
}
