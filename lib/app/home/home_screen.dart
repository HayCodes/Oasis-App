import 'package:flutter/material.dart';
import 'package:oasis/app/home/presentation/ui/categories.dart';
import 'package:oasis/app/home/presentation/ui/home_widgets.dart';
import 'package:oasis/app/home/presentation/ui/product_pagination.dart';
import 'package:oasis/app/home/presentation/ui/top_products.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/components/widgets/faq.dart';
import 'package:oasis/components/widgets/home_screen/menu_drawer.dart';
import 'package:oasis/services/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final int _selectedCategory = 0;
  final bool _isGridView = true;
  static const int _pageSize = 4;
  int _visibleCount = _pageSize;
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _productsKey = GlobalKey();

  List<Product> get _allFilteredProducts {
    if (_selectedCategory == 0) {
      return sampleProducts;
    } else if (_selectedCategory == 1) {
      return sampleProducts.where((p) => p.isNew).toList();
    } else {
      final cat = categories[_selectedCategory];
      return sampleProducts.where((p) => p.category == cat).toList();
    }
  }

  List<Product> get _filteredProducts {
    return _allFilteredProducts.take(_visibleCount).toList();
  }

  void _showMore() {
    setState(() {
      _visibleCount = (_visibleCount + _pageSize).clamp(
        0,
        sampleProducts.length,
      );
    });
  }

  void _collapse() {
    setState(() {
      _visibleCount = _pageSize;
    });

    Future.delayed(const Duration(milliseconds: 50), () {
      Scrollable.ensureVisible(
        _productsKey.currentContext!,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
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
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        const SliverToBoxAdapter(child: HomeHeader()),
        const SliverToBoxAdapter(child: HeroBanner()),
        const SliverToBoxAdapter(child: Categories()),
        SliverToBoxAdapter(
          key: _productsKey,
          child: TopProducts(
            categories: categories,
            filteredProducts: _filteredProducts,
          ),
        ),
        ProductGrid(products: _filteredProducts, isGridView: _isGridView),
        SliverToBoxAdapter(
          child: PaginationFooter(
            shownCount: _filteredProducts.length,
            totalCount: _allFilteredProducts.length,
            onShowMore: _showMore,
            onCollapse: _collapse,
          ),
        ),
        const SliverToBoxAdapter(child: FAQSection()),
      ],
    );
  }
}
