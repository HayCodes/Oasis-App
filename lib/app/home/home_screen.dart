import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis/app/home/presentation/ui/categories.dart';
import 'package:oasis/app/home/presentation/ui/home_widgets.dart';
import 'package:oasis/app/home/presentation/ui/top_products.dart';
import 'package:oasis/app/shop/presentation/bloc/top_products/bloc.dart';
import 'package:oasis/app/shop/presentation/bloc/top_products/events.dart';
import 'package:oasis/app/shop/presentation/bloc/top_products/state.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/components/widgets/faq.dart';
import 'package:oasis/components/widgets/home_screen/menu_drawer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _productsKey = GlobalKey();
  bool _isGridView = true;
  bool _fetchInitiated = false;


  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_fetchInitiated) {
      _fetchInitiated = true;
      context.read<TopProductsBloc>()
        .add(const FetchTopProducts());
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
        return CustomScrollView(
          controller: _scrollController,
          slivers: [
            const SliverToBoxAdapter(child: HomeHeader()),
            const SliverToBoxAdapter(child: HeroBanner()),
            const SliverToBoxAdapter(child: Categories()),

            // Top Products header + toolbar
            SliverToBoxAdapter(
              key: _productsKey,
              child: TopProducts(categories: extractCategories(state.topProducts)),
            ),

            // All Products grid
            _buildProductsSliver(state),

            // Loading indicator for pagination
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

  Widget _buildProductsSliver(TopProductsState state) {
    // initial load
    if (state.topProductStatus == FetchStatus.loading &&
        state.topProducts.isEmpty) {
      return const SliverToBoxAdapter(
        child: SizedBox(
          height: 300,
          child: Center(
            child: CircularProgressIndicator(
              strokeWidth: 1,
              color: AppColors.accent,
            ),
          ),
        ),
      );
    }

    // failure
    if (state.topProductStatus == FetchStatus.failure &&
        state.topProducts.isEmpty) {
      return SliverToBoxAdapter(
        child: SizedBox(
          height: 300,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                    Icons.error_outline, color: AppColors.textMuted, size: 40),
                const SizedBox(height: 12),
                Text(
                  state.errorMessage ?? 'Failed to load products.',
                  style: GoogleFonts.inter(
                      fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () =>
                      context.read<TopProductsBloc>().add(const FetchTopProducts()),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                    color: AppColors.textPrimary,
                    child: Text(
                      'RETRY',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // ✅ Show top products instead of allProducts
    return ProductGrid(products: state.topProducts, isGridView: _isGridView);
  }}