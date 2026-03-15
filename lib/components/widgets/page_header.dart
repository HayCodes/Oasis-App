import 'package:flutter/material.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final TextTheme textStyle;
  final VoidCallback? onTap;

  const PageHeader({super.key, required this.title, required this.textStyle, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
          title,
          style: textStyle.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey.shade100,
                ),
                child: const Icon(Icons.close, size: 18),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
