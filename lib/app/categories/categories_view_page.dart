import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/app/categories/categories_screen.dart';
import 'package:oasis/components/widgets/page_header.dart';

class CategoryViewPage extends StatefulWidget {

  const CategoryViewPage({super.key, required this.item});
  final CategoryItem item;

  @override
  State<CategoryViewPage> createState() => _CategoryViewPageState();
}

class _CategoryViewPageState extends State<CategoryViewPage> {
  String _selectedTag = 'All';
  String _sortBy = 'Most Recent';
  final TextEditingController _searchController = TextEditingController();

  // Mock products — replace with real data later
  final List<Map<String, dynamic>> _products = [
    {
      'name': 'natus et cupiditate',
      'price': 287,
      'image':
          'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=400&q=80',
      'colors': [const Color(0xFF4CAF50), const Color(0xFF2196F3)],
    },
    {
      'name': 'in a ut perspiciatis',
      'price': 439,
      'image':
          'https://images.unsplash.com/photo-1506439773649-6e0eb8cfb237?w=400&q=80',
      'colors': [const Color(0xFF1A1A1A), const Color(0xFF4CAF50)],
    },
    {
      'name': 'rem sequit itaque',
      'price': 150,
      'image':
          'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=400&q=80',
      'colors': [const Color(0xFF4CAF50)],
    },
    {
      'name': 'doloremque architecto',
      'price': 172,
      'image':
          'https://images.unsplash.com/photo-1518455027359-f3f8164ba6bd?w=400&q=80',
      'colors': [const Color(0xFF9E9E9E)],
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final tags = ['All', ...widget.item.tags.where((t) => t != 'All')];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F4),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // ── Header ──────────────────────────────────────
                    PageHeader(
                      title: widget.item.title,
                      textStyle: textStyle,
                      onTap: () => GoRouter.of(context).pop(),
                    ),

                    const SizedBox(height: 12),

                    // ── Description ──────────────────────────────────
                    Text(
                      widget.item.description,
                      textAlign: TextAlign.center,
                      style: textStyle.bodyMedium?.copyWith(
                        color: const Color(0xFF777777),
                        height: 1.6,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Breadcrumb ───────────────────────────────────
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     _BreadcrumbItem(
                    //       label: 'Home',
                    //       onTap: () => context.goNamed(RouteNames.home),
                    //     ),
                    //     const _BreadcrumbSeparator(),
                    //     _BreadcrumbItem(
                    //       label: 'Categories',
                    //       onTap: () => GoRouter.of(context).pop(),
                    //     ),
                    //     const _BreadcrumbSeparator(),
                    //     Text(
                    //       widget.item.title,
                    //       style: const TextStyle(
                    //         fontSize: 13,
                    //         fontWeight: FontWeight.w600,
                    //         color: Color(0xFF1A1A1A),
                    //       ),
                    //     ),
                    //   ],
                    // ),

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
                          onChanged: (val) => setState(() => _sortBy = val!),
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
                  (context, index) => _ProductCard(product: _products[index]),
                  childCount: _products.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                      'Showing ${_products.length} of ${widget.item.productCount} results',
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
                        value: _products.length / widget.item.productCount,
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
                    _PeopleAlsoViewed(products: _products),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ],
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

class _BreadcrumbItem extends StatelessWidget {

  const _BreadcrumbItem({required this.label, required this.onTap});
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Text(
      label,
      style: const TextStyle(fontSize: 13, color: Color(0xFF999999)),
    ),
  );
}

class _BreadcrumbSeparator extends StatelessWidget {
  const _BreadcrumbSeparator();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(horizontal: 6),
    child: Icon(Icons.chevron_right, size: 14, color: Color(0xFF999999)),
  );
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
  final Map<String, dynamic> product;

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
              product['image'],
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
                        product['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      '\$ ${product['price']}',
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
                  children: (product['colors'] as List<Color>)
                      .map(
                        (c) => Container(
                          margin: const EdgeInsets.only(right: 5),
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: c,
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
    );
  }
}

class _PeopleAlsoViewed extends StatelessWidget {

  const _PeopleAlsoViewed({required this.products});
  final List<Map<String, dynamic>> products;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'People also viewed',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A1A),
              ),
            ),
            // Row(
            //   children: [
            //     _NavButton(icon: Icons.chevron_left, onTap: () {}),
            //     const SizedBox(width: 8),
            //     _NavButton(icon: Icons.chevron_right, onTap: () {}),
            //   ],
            // ),
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
