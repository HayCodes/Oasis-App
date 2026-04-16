import 'package:flutter/material.dart';
import 'package:oasis/components/widgets/common/category_header_skeleton.dart';
import 'package:oasis/components/widgets/common/product_skeleton.dart';
import 'package:oasis/components/widgets/common/search_skeleton.dart';
import 'package:oasis/components/widgets/common/shimmer_wrapper.dart';
import 'package:oasis/components/widgets/common/tag_skeleton.dart';

class CategorySkeletonScreen extends StatelessWidget {
  const CategorySkeletonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return shimmerWrapper(
      child: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // ── Header ─────────────────────────────────────────────
                  const CategoryHeaderSkeleton(),

                  const SizedBox(height: 12),

                  // ── Description ────────────────────────────────────────
                  Container(
                    height: 14,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    height: 14,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ── Search ─────────────────────────────────────────────
                  const SearchSkeleton(),

                  const SizedBox(height: 16),

                  // ── Tags ───────────────────────────────────────────────
                  const TagSkeleton(),

                  const SizedBox(height: 28),

                  // ── "Top Products" label + sort dropdown ───────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 16,
                        width: 110,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Container(
                        height: 16,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          // ── Product Grid ────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (_, __) => const ProductSkeleton(),
                childCount: 6,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.72,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
