import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis/app/home/presentation/ui/categories.dart';
import 'package:oasis/app/home/presentation/ui/home_widgets.dart';
import 'package:oasis/app/home/presentation/ui/top_products.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/app/shop/presentation/bloc/top_products/bloc.dart';
import 'package:oasis/app/shop/presentation/bloc/top_products/events.dart';
import 'package:oasis/app/shop/presentation/bloc/top_products/state.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/components/widgets/common/fetch_error_widget.dart';
import 'package:oasis/components/widgets/common/top_products_skeleton.dart';
import 'package:oasis/components/widgets/faq.dart';
import 'package:oasis/components/widgets/home_screen/menu_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // ── UI state (all lifted here so every widget reacts correctly) ─────────────
  bool _isGridView = true;
  String _sortBy = 'Most Recent';
  bool _fetchInitiated = false;

  // ── Pagination ──────────────────────────────────────────────────────────────
  static const int _pageSize = 6;
  int _visibleCount = _pageSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_fetchInitiated) {
      _fetchInitiated = true;
      context.read<TopProductsBloc>().add(const FetchTopProducts());
    }
  }

  // ── Filtering & Sorting ─────────────────────────────────────────────────────
  List<Product> _filteredProducts(List<Product> all) {
    final result = List.of(all);

    // Sort
    switch (_sortBy) {
      case 'Price: Low to High':
        result.sort(
          (a, b) => a.price.effectivePrice.compareTo(b.price.effectivePrice),
        );
      case 'Price: High to Low':
        result.sort(
          (a, b) => b.price.effectivePrice.compareTo(a.price.effectivePrice),
        );
      case 'Most Popular':
        result.sort((a, b) => b.popularity.compareTo(a.popularity));
      default: // Most Recent
        result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return result;
  }

  void _resetPagination() => setState(() => _visibleCount = _pageSize);

  // ── Sort sheet ──────────────────────────────────────────────────────────────

  Future<void> _showSortSheet() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: AppColors.background,
      shape: const RoundedRectangleBorder(),
      builder: (_) => SortBottomSheet(currentSort: _sortBy),
    );
    if (selected != null && selected != _sortBy) {
      setState(() {
        _sortBy = selected;
        _visibleCount = _pageSize; // reset pagination on sort change
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MenuDrawer(),
      backgroundColor: AppColors.white,
      body: SafeArea(child: _mainContainer()),
    );
  }

  Widget _mainContainer() {
    return BlocBuilder<TopProductsBloc, TopProductsState>(
      builder: (context, state) {
        // extractCategories already prepends 'All' — don't add it again
        final categories = extractCategories(state.topProducts);
        final allFiltered = _filteredProducts(state.topProducts);
        final visibleProducts = allFiltered.take(_visibleCount).toList();
        final hasMore = _visibleCount < allFiltered.length;

        final isLoading =
            state.topProductStatus == FetchStatus.loading &&
            state.topProducts.isEmpty;
        final isFailure =
            state.topProductStatus == FetchStatus.failure &&
            state.topProducts.isEmpty;

        return CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(child: HomeHeader()),
            const SliverToBoxAdapter(child: HeroBanner()),
            const SliverToBoxAdapter(child: Categories()),

            // ── Top Products header + toolbar ───────────────────────────────
            SliverToBoxAdapter(
              child: isLoading
                  ? const TopProductsSkeleton()
                  : TopProducts(
                      categories: categories,
                      isGridView: _isGridView,
                      itemCount: allFiltered.length,
                      onSortTap: _showSortSheet,
                      onToggleView: () =>
                          setState(() => _isGridView = !_isGridView),
                    ),
            ),

            // ── Product grid ────────────────────────────────────────────────
            if (isLoading)
              ProductGridSkeleton(isGridView: _isGridView)
            else if (isFailure)
              SliverToBoxAdapter(
                child: FetchErrorWidget(
                  message: state.errorMessage,
                  onRetry: () => context.read<TopProductsBloc>().add(
                    const FetchTopProducts(),
                  ),
                ),
              )
            else
              ProductGrid(products: visibleProducts, isGridView: _isGridView),

            // ── Pagination footer ───────────────────────────────────────────
            if (!isLoading && !isFailure && state.topProducts.isNotEmpty)
              SliverToBoxAdapter(
                child: _PaginationFooter(
                  visibleCount: visibleProducts.length,
                  totalCount: allFiltered.length,
                  hasMore: hasMore,
                  isExpanded: _visibleCount > _pageSize,
                  onShowMore: () => setState(() => _visibleCount += _pageSize),
                  onShowLess: () => setState(_resetPagination),
                ),
              ),

            // ── Remote pagination loading indicator ─────────────────────────
            if (state.topProductStatus == FetchStatus.loading &&
                state.topProducts.isNotEmpty)
              const SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 24),
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 1,
                      color: AppColors.accent,
                    ),
                  ),
                ),
              ),

            const SliverToBoxAdapter(child: FAQSection()),
          ],
        );
      },
    );
  }
}

// ── Pagination Footer ─────────────────────────────────────────────────────────
class _PaginationFooter extends StatelessWidget {
  const _PaginationFooter({
    required this.visibleCount,
    required this.totalCount,
    required this.hasMore,
    required this.isExpanded,
    required this.onShowMore,
    required this.onShowLess,
  });

  final int visibleCount;
  final int totalCount;
  final bool hasMore;
  final bool isExpanded;
  final VoidCallback onShowMore;
  final VoidCallback onShowLess;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        children: [
          // Count label
          Text(
            'Showing $visibleCount of $totalCount results',
            style: GoogleFonts.jost(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 10),

          // Progress bar
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: LinearProgressIndicator(
              value: totalCount > 0 ? visibleCount / totalCount : 0,
              backgroundColor: AppColors.inputBorder,
              color: AppColors.textPrimary,
              minHeight: 3,
            ),
          ),

          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Show More — hidden once all items visible
              if (hasMore)
                OutlinedButton(
                  onPressed: onShowMore,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    side: const BorderSide(
                      color: AppColors.textPrimary,
                      width: 1.5,
                    ),
                    foregroundColor: AppColors.textPrimary,
                  ),
                  child: Text(
                    'Show more',
                    style: GoogleFonts.jost(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),

              if (hasMore && isExpanded) const SizedBox(width: 12),

              // Show Less — only visible once user has expanded beyond first page
              if (isExpanded)
                OutlinedButton(
                  onPressed: onShowLess,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    side: const BorderSide(
                      color: AppColors.inputBorder,
                      width: 1.5,
                    ),
                    foregroundColor: AppColors.textSecondary,
                  ),
                  child: Text(
                    'Show less',
                    style: GoogleFonts.jost(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
