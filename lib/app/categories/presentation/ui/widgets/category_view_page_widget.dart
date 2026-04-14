import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/services/router/app_router_constants.dart';

class ClipRounded extends StatelessWidget {
  const ClipRounded({super.key, required this.radius, required this.child});

  final double radius;
  final Widget child;

  @override
  Widget build(BuildContext context) =>
      ClipRRect(borderRadius: BorderRadius.circular(radius), child: child);
}

class SortDropdown extends StatelessWidget {
  const SortDropdown({super.key, required this.value, required this.onChanged});

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

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.pushNamed(
          RouteNames.productDetail,
          pathParameters: {'slug': product.slug},
        );
      },
      child: Container(
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
                        '\$${product.price.effectivePrice.toStringAsFixed(0)}',
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
                              border: Border.all(
                                color: const Color(0xFFE0E0E0),
                              ),
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
      ),
    );
  }
}

class PeopleAlsoViewed extends StatelessWidget {
  const PeopleAlsoViewed({super.key, required this.products, this.header});

  final List<Product> products;
  final String? header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              header ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            Row(
              children: [
                NavButton(icon: Icons.chevron_left, onTap: () {}),
                const SizedBox(width: 8),
                NavButton(icon: Icons.chevron_right, onTap: () {}),
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
              child: ProductCard(product: products[index]),
            ),
          ),
        ),
      ],
    );
  }
}

class NavButton extends StatelessWidget {
  const NavButton({super.key, required this.icon, required this.onTap});

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
