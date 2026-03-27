import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    required this.textStyle,
    this.onTap,
  });

  final String title;
  final TextTheme textStyle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final canPop = GoRouter.of(context).canPop();

    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          title,
          style: textStyle.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        if (canPop)
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: GestureDetector(
                onTap: onTap ?? () => GoRouter.of(context).pop(),
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade100,
                  ),
                  child: const Icon(Icons.arrow_back_ios, size: 18),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
