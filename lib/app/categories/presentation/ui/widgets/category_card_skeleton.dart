import 'package:flutter/material.dart';
import 'package:oasis/components/widgets/common/shimmer_wrapper.dart';

class CategoryCardSkeleton extends StatelessWidget {
  const CategoryCardSkeleton({super.key});

  Widget _bone({
    double? width,
    double? height,
    double radius = 6,
    bool pill = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(pill ? 999 : radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return shimmerWrapper(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _bone(height: 200, width: double.infinity, radius: 0),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _bone(height: 28, width: 110, pill: true),
                  const SizedBox(height: 10),
                  _bone(height: 36, width: double.infinity),
                  const SizedBox(height: 6),
                  _bone(height: 36, width: 160),
                  const SizedBox(height: 10),
                  _bone(height: 14, width: double.infinity),
                  const SizedBox(height: 6),
                  _bone(height: 14, width: double.infinity),
                  const SizedBox(height: 6),
                  _bone(height: 14, width: 180),
                  const SizedBox(height: 18),
                  _bone(height: 42, width: 160, pill: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
