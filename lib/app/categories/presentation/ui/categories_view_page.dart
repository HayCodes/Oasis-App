import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/app/categories/presentation/bloc/category_content/category_content.bloc.dart';
import 'package:oasis/app/categories/presentation/bloc/category_content/category_content.events.dart';
import 'package:oasis/app/categories/presentation/bloc/category_content/category_content.state.dart';
import 'package:oasis/app/categories/presentation/ui/widgets/category_view_page_skeleton.dart';
import 'package:oasis/app/categories/presentation/ui/widgets/category_view_page_widget.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/components/widgets/common/fetch_error_widget.dart';
import 'package:oasis/components/widgets/page_header.dart';

class CategoryViewPage extends StatefulWidget {
  const CategoryViewPage({super.key, required this.slug});
  final String slug;

  @override
  State<CategoryViewPage> createState() => _CategoryViewPageState();
}

class _CategoryViewPageState extends State<CategoryViewPage> {
  String _selectedTag = 'All';
  String _sortBy = 'Most Recent';
  final TextEditingController _searchController = TextEditingController();
  static const int _pageSize = 6;
  int _visibleCount = _pageSize;

  @override
  void initState() {
    super.initState();
    context.read<CategoryContentBloc>().add(
      FetchCategoryContentEvent(widget.slug),
    );
  }

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
      default:
        result.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    }

    return result;
  }

  void _resetPagination() => setState(() => _visibleCount = _pageSize);

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
            debugPrint('🟡Category ID: ${state.category?.slug}');
            debugPrint('🟡Slug: ${widget.slug}');
          },
          builder: (context, state) {
            final tags = ['All', ...state.tags.map((e) => e.name)];
            final allFiltered = _filteredProducts(state.products);
            final visibleProducts = allFiltered.take(_visibleCount).toList();
            final hasMore = _visibleCount < allFiltered.length;
            final isExpanded = _visibleCount > _pageSize;

            final isLoading =
                (state.contentStatus == FetchStatus.loading ||
                    state.contentStatus == FetchStatus.initial) &&
                state.category?.slug != widget.slug;
            final failed = state.contentStatus == FetchStatus.failure;

            if (isLoading) return const CategorySkeletonScreen();

            if (failed) {
              return FetchErrorWidget(
                message: state.errorMessage,
                onRetry: () => context.read<CategoryContentBloc>().add(
                  FetchCategoryContentEvent(widget.slug),
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        PageHeader(
                          title: state.category?.name ?? '',
                          textStyle: textStyle,
                          onTap: () => GoRouter.of(context).pop(),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          state.category?.description ?? '',
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        _buildSearch(
                          searchController: _searchController,
                          context: context,
                          onChanged: (_) => _resetPagination(),
                        ),
                        const SizedBox(height: 16),
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
                                onTap: () => {
                                  setState(() => _selectedTag = tag),
                                  _resetPagination(),
                                },
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Top Products'),
                            SortDropdown(
                              value: _sortBy,
                              onChanged: (val) => {
                                setState(() => _sortBy = val!),
                                _resetPagination(),
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) =>
                          ProductCard(product: visibleProducts[index]),
                      childCount: visibleProducts.length,
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
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 24,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Showing ${visibleProducts.length} of ${allFiltered.length} results',
                          style: const TextStyle(
                            fontSize: 13,
                            color: Color(0xFF999999),
                          ),
                        ),
                        const SizedBox(height: 8),
                        ClipRounded(
                          radius: 50,
                          child: LinearProgressIndicator(
                            value: allFiltered.isNotEmpty
                                ? visibleProducts.length / allFiltered.length
                                : 0,
                            backgroundColor: const Color(0xFFE0E0E0),
                            color: const Color(0xFF1A1A1A),
                            minHeight: 3,
                          ),
                        ),
                        const SizedBox(height: 20),
                        if (hasMore)
                          OutlinedButton(
                            onPressed: () =>
                                setState(() => _visibleCount += _pageSize),
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
                        if (hasMore && isExpanded) const SizedBox(width: 12),
                        if (isExpanded)
                          OutlinedButton(
                            onPressed: _resetPagination,
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
                            child: const Text(
                              'Show less',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        const SizedBox(height: 32),
                        if (state.relatedProducts.isNotEmpty)
                          PeopleAlsoViewed(products: state.relatedProducts),
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

Widget _buildSearch({
  required TextEditingController searchController,
  required BuildContext context,
  required ValueChanged<String> onChanged,
}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50),
      border: Border.all(color: const Color(0xFFE0E0E0)),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: searchController,
            onChanged: onChanged,
            decoration: const InputDecoration(
              hintText: 'Search by name or tag...',
              hintStyle: TextStyle(color: Color(0xFFAAAAAA), fontSize: 14),
              border: InputBorder.none,
              isDense: true,
            ),
          ),
        ),
        const Icon(Icons.search, color: Color(0xFFAAAAAA), size: 20),
      ],
    ),
  );
}
