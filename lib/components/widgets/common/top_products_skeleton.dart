import 'package:flutter/material.dart';

class TopProductsSkeleton extends StatelessWidget {
  const TopProductsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        // Title skeleton
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text('Top Products', style: textStyle.displayMedium),
        ),
        const SizedBox(height: 20),
        // Category tabs skeleton
        SizedBox(
          height: 44,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: 4,
            itemBuilder: (_, i) => const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              child: _SkeletonBox(width: 70, height: 28),
            ),
          ),
        ),
        // Toolbar skeleton
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _SkeletonBox(width: 60, height: 12, radius: 3),
              _SkeletonBox(width: 80, height: 12, radius: 3),
            ],
          ),
        ),
      ],
    );
  }
}

class ProductGridSkeleton extends StatelessWidget {
  const ProductGridSkeleton({super.key, this.isGridView = true});

  final bool isGridView;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (_, _) => const _ProductCardSkeleton(),
          childCount: isGridView ? 6 : 3,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isGridView ? 2 : 1,
          childAspectRatio: isGridView ? 0.62 : 1.4,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
      ),
    );
  }
}

class _ProductCardSkeleton extends StatefulWidget {
  const _ProductCardSkeleton();

  @override
  State<_ProductCardSkeleton> createState() => _ProductCardSkeletonState();
}

class _ProductCardSkeletonState extends State<_ProductCardSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _shimmer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
    _shimmer = Tween<double>(
      begin: 0.4,
      end: 0.9,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmer,
      builder: (_, _) => Container(
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image area
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                color: Color.lerp(
                  Colors.grey.shade200,
                  Colors.grey.shade300,
                  _shimmer.value,
                ),
              ),
            ),
            // Text area
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 10,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color.lerp(
                          Colors.grey.shade200,
                          Colors.grey.shade300,
                          _shimmer.value,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    Container(
                      height: 10,
                      width: 80,
                      decoration: BoxDecoration(
                        color: Color.lerp(
                          Colors.grey.shade200,
                          Colors.grey.shade300,
                          _shimmer.value,
                        ),
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({
    required this.width,
    required this.height,
    this.radius = 0,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
