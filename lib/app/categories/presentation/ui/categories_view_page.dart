import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/app/categories/data/categories.repository.dart';
import 'package:oasis/app/categories/presentation/bloc/category_content/category_content.bloc.dart';
import 'package:oasis/app/categories/presentation/bloc/category_content/category_content.events.dart';
import 'package:oasis/app/categories/presentation/bloc/category_content/category_content.state.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/components/widgets/page_header.dart';
import 'package:oasis/locator.dart';

class CategoryViewPage extends StatelessWidget {
  const CategoryViewPage({super.key, required this.slug});

  final String slug;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      CategoryContentBloc(sl<CategoryRepository>())
        ..add(FetchCategoryContentEvent(slug)),
      child: _CategoryViewBody(slug: slug),
    );
  }
}

class _CategoryViewBody extends StatefulWidget {
  const _CategoryViewBody({required this.slug});
  final String slug;

  @override
  State<_CategoryViewBody> createState() => _CategoryViewBodyState();
}

class _CategoryViewBodyState extends State<_CategoryViewBody> {
  String _selectedTag = 'All';
  String _sortBy = 'Most Recent';
  final TextEditingController _searchController = TextEditingController();

  List<Product> _filteredProducts(List<Product> products) {
    final result = products.where((p) {
      final matchesTag = _selectedTag == 'All' || p.tags.contains(_selectedTag);
      final matchesSearch =
          _searchController.text.isEmpty ||
          p.name.toLowerCase().contains(_searchController.text.toLowerCase());
      return matchesTag && matchesSearch;
    }).toList();

    switch (_sortBy) {
      case 'Price: Low to High':
        result.sort(
          (a, b) => a.price.effectivePrice.compareTo(b.price.effectivePrice),
        );
      case 'Price: High to Low':
        result.sort(
          (a, b) => b.price.effectivePrice.compareTo(a.price.effectivePrice),
        );
      case 'Popular':
        result.sort((a, b) => b.popularity.compareTo(a.popularity));
      default: // Most Recent
        result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return result;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: BlocConsumer<CategoryContentBloc, CategoryContentState>(
          listener: (context, state) {
            debugPrint('🟡 Status: ${state.contentStatus}');
            debugPrint('🟡 Products: ${state.products.length}');
            debugPrint('🟡 Category: ${state.category?.name}');
          },
          builder: (context, state) {
            final tags = ['All', ...state.tags.map((e) => e.name)];
            final filteredProducts = _filteredProducts(state.products);
            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        // ── Header ──────────────────────────────────────
                        PageHeader(
                          title: state.category?.name ?? '',
                          textStyle: textStyle,
                          onTap: () => GoRouter.of(context).pop(),
                        ),

                        const SizedBox(height: 12),

                        // ── Description ──────────────────────────────────
                        Text(
                          state.category?.description ?? '',
                          textAlign: TextAlign.center,
                          style: textStyle.bodyMedium?.copyWith(
                            color: const Color(0xFF777777),
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: 16),

                        const SizedBox(height: 20),

                        // ── Search ───────────────────────────────────────
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 4,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (_) => setState(() {}),
                                  decoration: const InputDecoration(
                                    hintText: 'Search by name or tag...',
                                    hintStyle: TextStyle(
                                      color: Color(0xFFAAAAAA),
                                      fontSize: 14,
                                    ),
                                    border: InputBorder.none,
                                    isDense: true,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.search,
                                color: Color(0xFFAAAAAA),
                                size: 20,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 16),

                        // ── Filter Tags ──────────────────────────────────
                        SizedBox(
                          height: 38,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: tags.length,
                            separatorBuilder: (context, _) =>
                                const SizedBox(width: 8),
                            itemBuilder: (context, index) {
                              final tag = tags[index];
                              final isSelected = tag == _selectedTag;
                              return GestureDetector(
                                onTap: () => setState(() => _selectedTag = tag),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 150),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? const Color(0xFF6C5CE7)
                                        : Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color(0xFF6C5CE7)
                                          : const Color(0xFFE0E0E0),
                                    ),
                                  ),
                                  child: Text(
                                    tag,
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: isSelected
                                          ? Colors.white
                                          : const Color(0xFF555555),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 28),

                        // ── Top Products + Sort ──────────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Top Products',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1A1A1A),
                              ),
                            ),
                            _SortDropdown(
                              value: _sortBy,
                              onChanged: (val) =>
                                  setState(() => _sortBy = val!),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),

                // ── Product Grid ─────────────────────────────────────────
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          _ProductCard(product: filteredProducts[index]),
                      childCount: filteredProducts.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 12,
                          mainAxisSpacing: 12,
                          childAspectRatio: 0.72,
                        ),
                  ),
                ),

                // ── Pagination info + Show More ───────────────────────────
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Showing ${filteredProducts.length} of ${state.category?.productCount ?? ''} results',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                          ),
                        ),
                        const SizedBox(height: 8),
                        // Progress bar
                        ClipRounded(
                          radius: 50,
                          child: LinearProgressIndicator(
                            value:
                                state.category != null &&
                                    state.category!.productCount > 0
                                ? filteredProducts.length /
                                      state.category!.productCount
                                : 0,
                            backgroundColor: const Color(0xFFE0E0E0),
                            color: const Color(0xFF1A1A1A),
                            minHeight: 3,
                          ),
                        ),
                        const SizedBox(height: 20),
                        OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 14,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            side: const BorderSide(
                              color: Color(0xFF1A1A1A),
                              width: 1.5,
                            ),
                            foregroundColor: const Color(0xFF1A1A1A),
                          ),
                          child: const Text(
                            'Show more',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),

                        // ── People also viewed ─────────────────────────
                        if (state.relatedProducts.isNotEmpty)
                          _PeopleAlsoViewed(products: state.relatedProducts),

                        const SizedBox(height: 32),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// ── Supporting widgets ────────────────────────────────────────────────────────

class ClipRounded extends StatelessWidget {
  const ClipRounded({super.key, required this.radius, required this.child});
  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: child);
}

class _SortDropdown extends StatelessWidget {
  const _SortDropdown({required this.value, required this.onChanged});
  final String value;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE8E8E8)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          style: const TextStyle(
            fontSize: 13,
            color: Color(0xFF1A1A1A),
            fontWeight: FontWeight.w500,
          ),
          items: [
            'Most Recent',
            'Price: Low to High',
            'Price: High to Low',
            'Popular',
          ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              product.featuredImage.src,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, object, stack) =>
                  Container(color: const Color(0xFFEEECE8)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      '\$ ${product.price.effectivePrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1A1A1A),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: product.colors
                      .map(
                        (hex) => Container(
                          margin: const EdgeInsets.only(right: 5),
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Color(
                              int.parse(hex.replaceFirst('#', '0xFF')),
                            ), // ✅ hex string → Color
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFFE0E0E0)),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PeopleAlsoViewed extends StatelessWidget {
  const _PeopleAlsoViewed({required this.products});
  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'People also viewed',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            Row(
              children: [
                _NavButton(icon: Icons.chevron_left, onTap: () {}),
                const SizedBox(width: 8),
                _NavButton(icon: Icons.chevron_right, onTap: () {}),
              ],
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (context, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) => SizedBox(
              width: 160,
              child: _ProductCard(product: products[index]),
            ),
          ),
        ),
      ],
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFFE0E0E0)),
          color: Colors.white,
        ),
        child: Icon(icon, size: 18, color: const Color(0xFF1A1A1A)),
      ),
    );
  }
}
