import 'package:flutter/material.dart';

class CategoryHeaderSkeleton extends StatelessWidget {
  const CategoryHeaderSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(height: 24, width: 150, color: Colors.grey.shade300),
        const SizedBox(height: 12),
        Container(
          height: 12,
          width: double.infinity,
          color: Colors.grey.shade300,
        ),
        const SizedBox(height: 6),
        Container(height: 12, width: 200, color: Colors.grey.shade300),
      ],
    );
  }
}
