import 'package:flutter/material.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/components/widgets/home_screen/cart_button.dart';
import 'package:oasis/components/widgets/home_screen/categories.dart';
import 'package:oasis/components/widgets/home_screen/faq.dart';
import 'package:oasis/components/widgets/home_screen/hamburger.dart';
import 'package:oasis/components/widgets/home_screen/menu_drawer.dart';
import 'package:oasis/components/widgets/home_screen/product_pagination.dart';
import 'package:oasis/components/widgets/home_screen/top_products.dart';
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
        SliverToBoxAdapter(child: _buildHeader()),
        SliverToBoxAdapter(child: _buildHeroBanner()),
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Builder(
        builder: (context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Hamburger
              HamburgerButton(context: context),

              // Logo
              const Expanded(
                child: Image(
                  image: AssetImage('images/Oasis.png'),
                  width: 20.0,
                  height: 20.0,
                ),
              ),

              // Cart icon
              const Cartbutton(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeroBanner() {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 15.0),
        Column(
          children: [
            Text('FURNITURE STORE', style: textTheme.headlineSmall),
            const SizedBox(height: 5.0),
            Text(
              'Discover the Artistry of Modern Contemporary Furniture',
              style: textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5.0),
            Text(
              'Experience the elegance and functionality of cutting-edge design where luxury meets innovation in every piece for ultimate relaxation',
              style: textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 300,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'images/hero-chair.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
