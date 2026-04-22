import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/app/categories/models/categories.model.dart';
import 'package:oasis/services/router/app_router_constants.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final Category category;

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
              category.image,
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
                    '${category.productCount} products',
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
                  category.name,
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
                  category.description,
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
                      pathParameters: {'slug': category.slug},
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

class BottomCTA extends StatelessWidget {
  const BottomCTA({super.key});

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
              GoRouter.of(context).goNamed(RouteNames.shop);
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
