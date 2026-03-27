import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/components/widgets/page_header.dart';

import 'package:oasis/services/router/app_router_constants.dart';

class CategoryItem {

  const CategoryItem({
    required this.slug,
    required this.tags,
    required this.title,
    required this.description,
    required this.productCount,
    required this.imageUrl,
  });
  final String title;
  final String slug;
  final String description;
  final int productCount;
  final String imageUrl;
  final List<String> tags;
}

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  static const List<CategoryItem> categories = [
    CategoryItem(
      title: 'Decor',
      slug: 'decor',
      description:
          'Bring warmth and personality to your home with décor pieces that reflect your unique style, turning every room into a captivating blend of luxury and comfort.',
      productCount: 29,
      imageUrl:
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=80',
      tags: ['decor', 'furniture', 'home'],
    ),
    CategoryItem(
      title: 'Bedroom',
      slug: 'bedroom',
      description:
          'Bring warmth and personality to your home with décor pieces that reflect your unique style, turning every room into a captivating blend of luxury and comfort.',
      productCount: 29,
      imageUrl:
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=80',
      tags: ['bedroom', 'bed', 'home'],
    ),
    CategoryItem(
      title: 'Sitting Room',
      tags: ['sitting', 'room', 'home'],
      slug: 'sitting-room',
      description:
          'Bring warmth and personality to your home with décor pieces that reflect your unique style, turning every room into a captivating blend of luxury and comfort.',
      productCount: 29,
      imageUrl:
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=80',
    ),
    CategoryItem(
      title: 'Accessories',
      slug: 'accessories',
      description:
          'Bring warmth and personality to your home with décor pieces that reflect your unique style, turning every room into a captivating blend of luxury and comfort.',
      productCount: 29,
      imageUrl:
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=80',
      tags: ['sitting', 'room', 'home'],
    ),
    CategoryItem(
      title: 'Kitchen',
      slug: 'kitchen',
      description:
          'Bring warmth and personality to your home with décor pieces that reflect your unique style, turning every room into a captivating blend of luxury and comfort.',
      productCount: 29,
      imageUrl:
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=80',
      tags: ['sitting', 'room', 'home'],
    ),
    CategoryItem(
      title: 'Lighting',
      slug: 'lighting',
      description:
          'Bring warmth and personality to your home with décor pieces that reflect your unique style, turning every room into a captivating blend of luxury and comfort.',
      productCount: 29,
      imageUrl:
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=600&q=80',
      tags: ['sitting', 'room', 'home'],
    ),
    CategoryItem(
      title: 'Storage',
      slug: 'storage',
      description:
          'Maximize your space with stylish storage solutions that combine functionality with high-end design, keeping your home organized and clutter-free while maintaining an elegant touch.',
      productCount: 40,
      imageUrl:
          'https://images.unsplash.com/photo-1507089947368-19c1da9775ae?w=600&q=80',
      tags: ['sitting', 'room', 'home'],
    ),
    CategoryItem(
      title: 'Office',
      slug: 'office',
      description:
          'Transform your workspace into a modern hub of productivity with office furniture that promotes both comfort and innovation for a seamless work-life balance.',
      productCount: 45,
      imageUrl:
          'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=600&q=80',
      tags: ['sitting', 'room', 'home'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              PageHeader(
                title: 'Categories',
                textStyle: textStyle,
                onTap: () {
                  GoRouter.of(context).pop();
                },
              ),
              // cards
              const SizedBox(height: 24),
              Text(
                'Explore our collections and find the perfect furniture for your home',
                style: textStyle.headlineSmall,
              ),
              const SizedBox(height: 24),
              ...categories.map(
                (cat) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: CategoryCard(item: cat),
                ),
              ),
              const SizedBox(height: 24),
              const _BottomCTA(),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {

  const CategoryCard({super.key, required this.item});
  final CategoryItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image section
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Image.network(
              item.imageUrl,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  color: const Color(0xFFEEECE8),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xFF6C5CE7),
                      strokeWidth: 2,
                    ),
                  ),
                );
              },
              errorBuilder: (context, object, stack) => Container(
                color: const Color(0xFFEEECE8),
                child: const Icon(
                  Icons.image_outlined,
                  size: 48,
                  color: Color(0xFFAAAAAA),
                ),
              ),
            ),
          ),

          // Content section
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product count badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0EEF8),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${item.productCount} products',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF6C5CE7),
                      fontFamily: 'Arial',
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Title
                Text(
                  item.title,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1A1A1A),
                    letterSpacing: -0.5,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 10),

                // Description
                Text(
                  item.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF666666),
                    height: 1.6,
                    fontFamily: 'Arial',
                  ),
                ),
                const SizedBox(height: 18),

                // Explore button
                _ExploreButton(
                  onTap: () {
                    GoRouter.of(context).pushNamed(
                      RouteNames.categoryView,
                      pathParameters: {'slug': item.slug},
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExploreButton extends StatefulWidget {

  const _ExploreButton({required this.onTap});
  final VoidCallback onTap;

  @override
  State<_ExploreButton> createState() => _ExploreButtonState();
}

class _ExploreButtonState extends State<_ExploreButton> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (_) => setState(() => _hovered = true),
      onTapUp: (_) => setState(() => _hovered = false),
      onTapCancel: () => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: _hovered ? const Color(0xFF1A1A1A) : Colors.transparent,
          border: Border.all(color: const Color(0xFF1A1A1A), width: 1.5),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 150),
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: _hovered ? Colors.white : const Color(0xFF1A1A1A),
                fontFamily: 'Arial',
                letterSpacing: 0.2,
              ),
              child: const Text('Explore Products'),
            ),
            const SizedBox(width: 8),
            AnimatedRotation(
              turns: _hovered ? -0.125 : 0,
              duration: const Duration(milliseconds: 150),
              child: Icon(
                Icons.arrow_outward_rounded,
                size: 16,
                color: _hovered ? Colors.white : const Color(0xFF1A1A1A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomCTA extends StatelessWidget {
  const _BottomCTA();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          "Can't find what you're looking for?",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A1A),
            letterSpacing: -0.3,
            height: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Browse our complete shop or contact our team for personalized recommendations',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF777777),
            height: 1.6,
            fontFamily: 'Arial',
          ),
        ),
        const SizedBox(height: 28),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              GoRouter.of(context).pushNamed(RouteNames.shop);
            },
            icon: const Icon(Icons.arrow_outward_rounded, size: 18),
            iconAlignment: IconAlignment.end,
            label: const Text(
              'Browse All Products',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
                fontFamily: 'Arial',
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6C5CE7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 18),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 0,
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
