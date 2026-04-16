import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/app/shop/product_card.dart';
import 'package:oasis/components/themes/app_theme.dart';

class TopProducts extends StatelessWidget {
  const TopProducts({
    super.key,
    required this.categories,
    required this.isGridView,
    required this.itemCount,
    required this.onSortTap,
    required this.onToggleView,
  });

  final List<String> categories;
  final bool isGridView;
  final int itemCount;
  final VoidCallback onSortTap;
  final VoidCallback onToggleView;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme
        .of(context)
        .textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text('Top Products', style: textStyle.displayMedium),
        ),
        const SizedBox(height: 10),
        ProductToolbar(
          itemCount: itemCount,
          isGridView: isGridView,
          onSortTap: onSortTap,
          onToggleView: onToggleView,
        ),
      ],
    );
  }
}


// ── ProductToolbar ───────────────────────────────────────────────────────────

class ProductToolbar extends StatelessWidget {
  const ProductToolbar({
    super.key,
    required this.itemCount,
    required this.isGridView,
    required this.onSortTap,
    required this.onToggleView,
  });
  final int itemCount;
  final bool isGridView;
  final VoidCallback onSortTap;
  final VoidCallback onToggleView;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$itemCount items',
            style: GoogleFonts.jost(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
          Row(
            children: [
              _ToolbarButton(
                icon: Icons.sort_rounded,
                label: 'SORT',
                onTap: onSortTap,
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: onToggleView,
                child: Icon(
                  isGridView
                      ? Icons.grid_view_rounded
                      : Icons.view_agenda_outlined,
                  size: 18,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ToolbarButton extends StatelessWidget {
  const _ToolbarButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.jost(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Products ─────────────────────────────────────────────────────

class ProductGrid extends StatelessWidget {
  const ProductGrid({
    super.key,
    required this.products,
    required this.isGridView,
  });
  final List<Product> products;

  final bool isGridView;

  @override
  Widget build(BuildContext context) {
    if (products.isEmpty) {
      return SliverToBoxAdapter(
        child: Center(
          child: Text(
            'No items found',
            style: GoogleFonts.inter(fontSize: 20, color: AppColors.textMuted),
          ),
        ),
      );
    }

    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) =>
              ProductCard(product: products[index], isWide: !isGridView),
          childCount: products.length,
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

// ── SortBottomSheet ──────────────────────────────────────────────────────────

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({super.key, required this.currentSort});

  final String currentSort;

  static const _options = [
    'Most Recent',
    'Price: Low to High',
    'Price: High to Low',
    'Most Popular',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'SORT BY',
            style: GoogleFonts.jost(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              letterSpacing: 2,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, color: AppColors.inputBorder),
          ..._options.map(
            (option) => Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    option,
                    style: GoogleFonts.jost(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      fontWeight: option == currentSort ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                  trailing: option == currentSort
                      ? const Icon(Icons.check, size: 16)
                      : null,
                  onTap: () => Navigator.pop(context, option),
                ),
                const Divider(height: 1, color: AppColors.inputBorder),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
