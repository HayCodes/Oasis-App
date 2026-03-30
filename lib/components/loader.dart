import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oasis/components/app.text.dart';
import 'package:oasis/components/themes/app_theme.dart';

class AppSpinner extends StatefulWidget {
  const AppSpinner({super.key});

  @override
  AppSpinnerState createState() => AppSpinnerState();
}

class AppSpinnerState extends State<AppSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..repeat(reverse: true);
    _opacityAnimation = Tween<double>(begin: 0.2, end: 1).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: Container(
            height: 80.h,
            width: 80.w,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: AnimatedOpacity(
              opacity: _opacityAnimation.value,
              duration: const Duration(milliseconds: 400),
              // TO- DO FIX THE LOADER WELL
              child: const Icon(Icons.circle_rounded),
            ),
          ),
        );
      },
    );
  }
}

class AppLoader {
  static void show(BuildContext context) {
    return Loader.show(
      context,
      progressIndicator: const AppSpinner(),
      overlayColor: AppColors.background.withValues(alpha: 0.7),
    );
  }

  static void hide() {
    return Loader.hide();
  }
}

class TextLoadingView extends StatelessWidget {
  const TextLoadingView({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppText(text ?? 'Please wait...', fontSize: 12.sp),
        Transform.scale(scale: 0.7, child: const CupertinoActivityIndicator()),
      ],
    );
  }
}

class AdaptiveCircularProgress extends StatelessWidget {
  const AdaptiveCircularProgress({
    super.key,
    this.size = 20,
    this.strokeWidth = 2.5,
    this.color = AppColors.accent,
  });

  final double size;
  final double strokeWidth;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: !Platform.isIOS
          ? SizedBox(
              height: size,
              width: size,
              child: CircularProgressIndicator(
                color: color,
                strokeWidth: strokeWidth,
              ),
            )
          : CupertinoActivityIndicator(color: color, radius: 16),
    );
  }
}

class CustomShimmer extends HookWidget {
  const CustomShimmer({
    super.key,
    this.size,
    this.shape = BoxShape.rectangle,
    this.borderRadius,
  });

  final Size? size;
  final BoxShape shape;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final controller = useAnimationController(
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    return FadeTransition(
      opacity: Tween<double>(
        begin: 0.6,
        end: 1.0,
      ).animate(CurvedAnimation(parent: controller, curve: Curves.easeInOut)),
      child: Container(
        width: size?.width ?? 100,
        height: size?.height ?? 100,
        decoration: BoxDecoration(
          shape: shape,
          color: const Color.fromRGBO(28, 28, 28, 1),
          borderRadius: shape == BoxShape.circle
              ? null
              : (borderRadius != null)
              ? borderRadius
              : BorderRadius.circular(12),
        ),
      ),
    );
  }
}
