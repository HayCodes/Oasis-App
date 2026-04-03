import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/app/shop/presentation/bloc/shop.bloc.dart';
import 'package:oasis/app/shop/presentation/bloc/shop.state.dart';
import 'package:oasis/app/shop/product_card.dart';
import 'package:oasis/components/themes/app_theme.dart';

class TopProducts extends StatefulWidget {
  const TopProducts({super.key, required this.categories});
  final List<String> categories;

  @override
  State<TopProducts> createState() => _TopProductsState();
}

class _TopProductsState extends State<TopProducts> {
  int _selectedCategory = 0;
  bool _isGridView = true;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return BlocBuilder<ShopBloc, ShopState>(
      buildWhen: (prev, curr) =>
          prev.topProducts.length != curr.topProducts.length,
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text('Top Products', style: textStyle.displayMedium),
            ),
            const SizedBox(height: 20),
            CategoryTabs(
              categories: widget.categories,
              selectedIndex: _selectedCategory,
              onCategorySelected: (index) =>
                  setState(() => _selectedCategory = index),
            ),
            ProductToolbar(
              itemCount: state.topProducts.length,
              isGridView: _isGridView,
              onSortTap: () => _showSortSheet(context),
              onToggleView: () => setState(() => _isGridView = !_isGridView),
            ),
          ],
        );
      },
    );
  }

  void _showSortSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(),
      builder: (_) => const SortBottomSheet(),
    );
  }
}

// ── CategoryTabs ────────────────────────────────────────────────────────────

class CategoryTabs extends StatelessWidget {
  const CategoryTabs({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });
  final List<String> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () => onCategorySelected(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.textPrimary : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? AppColors.textPrimary
                      : AppColors.inputBorder,
                ),
              ),
              child: Center(
                child: Text(
                  categories[index].toUpperCase(),
                  style: GoogleFonts.jost(
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          );
        },
      ),
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
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
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
              _ToolbarButton(
                icon: Icons.tune_rounded,
                label: 'FILTER',
                onTap: () {}, // wire up your filter logic here
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
  const SortBottomSheet({super.key});

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
                    ),
                  ),
                  onTap: () => Navigator.pop(context),
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
