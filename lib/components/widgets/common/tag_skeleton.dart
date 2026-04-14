import 'package:flutter/material.dart';

class TagSkeleton extends StatelessWidget {
  const TagSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        4,
            (_) =>
            Container(
              margin: const EdgeInsets.only(right: 8),
              height: 32,
              width: 70,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
      ),
    );
  }
}