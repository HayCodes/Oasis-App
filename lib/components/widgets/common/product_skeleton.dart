import 'package:flutter/material.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Expanded(child: Container(color: Colors.grey.shade300)),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  height: 10,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
                const SizedBox(height: 6),
                Container(height: 10, width: 60, color: Colors.grey.shade300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
