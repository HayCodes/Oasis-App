import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis/app/shop/models/product_details.model.dart';
import 'package:oasis/app/shop/presentation/bloc/product_details/bloc.dart';
import 'package:oasis/app/shop/presentation/bloc/product_details/events.dart';
import 'package:oasis/app/shop/presentation/bloc/product_details/state.dart';
import 'package:oasis/app/shop/presentation/ui/product_details_widget.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/components/themes/app_theme.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key, required this.slug});
  final String slug;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    context.read<ProductDetailBloc>().add(FetchProductDetail(widget.slug));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductDetailBloc, ProductDetailState>(
      listener: (context, state) {
        final product = state.getProduct(widget.slug);
        debugPrint('🟡ProductDetailBloc → state: $product');
        debugPrint('🟡Product ID: ${product?.id}');
        debugPrint('🟡Slug: ${widget.slug}');
      },
      builder: (context, state) {
        final product = state.getProduct(widget.slug);
        if ((state.productDetailsStatus == FetchStatus.initial ||
                state.productDetailsStatus == FetchStatus.loading) &&
            product?.id.toString() != widget.slug) {
          return const Scaffold(
            backgroundColor: AppColors.background,
            body: Center(
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: AppColors.accent,
              ),
            ),
          );
        }

        if (state.productDetailsStatus == FetchStatus.failure ||
            product == null) {
          return Scaffold(
            backgroundColor: AppColors.background,
            appBar: AppBar(
              backgroundColor: AppColors.background,
              elevation: 0,
              leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 16,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
            ),
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: AppColors.textMuted,
                    size: 40,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    state.errorMessage ?? 'Failed to load product.',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Stack(
            children: [
              CustomScrollView(
                slivers: [
                  _buildSliverAppBar(product),
                  SliverToBoxAdapter(child: _buildProductInfo(product)),
                  if (state.relatedProducts.isNotEmpty) ...[
                    SliverToBoxAdapter(child: _buildRelatedHeader()),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: BuildRelatedProducts(
                          products: state.relatedProducts,
                        ),
                      ),
                    ),
                  ],
                  const SliverToBoxAdapter(child: SizedBox(height: 120)),
                ],
              ),
              _buildBottomBar(context, product),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSliverAppBar(ProductDetail productDetail) {
    return SliverAppBar(
      expandedHeight: 420,
      pinned: true,
      backgroundColor: AppColors.background,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Container(
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 16,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () => setState(() => _isFavorite = !_isFavorite),
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            width: 36,
            height: 36,
            child: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              size: 16,
              color: _isFavorite ? AppColors.accent : AppColors.textPrimary,
            ),
          ),
        ),
        const SizedBox(width: 8),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: CachedNetworkImage(
          imageUrl: productDetail.featuredImage.src,
          fit: BoxFit.cover,
          placeholder: (ctx, url) => Container(color: AppColors.accentLight),
          errorWidget: (ctx, url, err) => Container(
            color: AppColors.accentLight,
            child: const Icon(Icons.image_outlined, color: AppColors.textMuted),
          ),
        ),
      ),
    );
  }

  Widget _buildProductInfo(ProductDetail productDetail) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category & Name
          Text(
            productDetail.category.name.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: AppColors.textMuted,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            productDetail.name,
            style: GoogleFonts.cormorant(
              fontSize: 28,
              fontWeight: FontWeight.w400,
              color: AppColors.textPrimary,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 12),

          // Price & Rating
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    r'$'
                    '${productDetail.price.effectivePrice.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.accent,
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    r'$'
                    '${productDetail.price.amount.toStringAsFixed(0)}',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                      decoration: TextDecoration.lineThrough,
                      decorationColor: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  // ── Discount Badge ──────────────────────────────
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.red.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Text(
                      '-${productDetail.price.discount?.toStringAsFixed(0)}%',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.red,
                      ),
                    ),
                  ),
                ],
              ),

              // ── Rating ───────────────────────────────────────────
              Row(
                children: [
                  const Icon(
                    Icons.star_rounded,
                    size: 14,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    productDetail.rating.toString(),
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),
          const Divider(color: AppColors.inputBorder),
          const SizedBox(height: 20),

          // Tags
          if (productDetail.tags.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: productDetail.tags
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.tag,
                        border: Border.all(color: AppColors.inputBorder),
                      ),
                      child: Text(
                        tag.toUpperCase(),
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 24),
          ],

          // Colors
          if (productDetail.colors.isNotEmpty) ...[
            Text(
              'COLORS',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: productDetail.colors.map((color) {
                final colorValue = _namedColorToColor(color);
                return Container(
                  width: 28,
                  height: 28,
                  decoration: BoxDecoration(
                    color: colorValue,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.inputBorder),
                  ),
                );
              }).toList(),
            ),
          ],

          const SizedBox(height: 28),
          const Divider(color: AppColors.inputBorder),
          const SizedBox(height: 20),

          // Description
          Text(
            'DESCRIPTION',
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            productDetail.description,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.7,
            ),
          ),

          const SizedBox(height: 24),
          const Divider(color: AppColors.inputBorder),
          const SizedBox(height: 20),

          // DELIVERY INFO
          _buildInfoRow(
            Icons.local_shipping_outlined,
            r'Free shipping on orders over $200',
          ),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.refresh_rounded, 'Free returns within 30 days'),
          const SizedBox(height: 12),
          _buildInfoRow(Icons.verified_outlined, 'Authenticity guaranteed'),
          const SizedBox(height: 12),
          _buildInfoRow(
            Icons.chair_alt_rounded,
            'Made from the best material sourced',
          ),
        ],
      ),
    );
  }

  Widget _buildRelatedHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 16),
      child: Text(
        'YOU MAY ALSO LIKE',
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
          letterSpacing: 1.5,
        ),
      ),
    );
  }

  // Widget _buildRelatedGrid(List<Product> products) {
  //   return SliverPadding(
  //     padding: const EdgeInsets.symmetric(horizontal: 16),
  //     sliver: SliverGrid(
  //       delegate: SliverChildBuilderDelegate(
  //         (context, index) => ProductCard(product: products[index]),
  //         childCount: products.length,
  //       ),
  //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: 2,
  //         childAspectRatio: 0.62,
  //         crossAxisSpacing: 12,
  //         mainAxisSpacing: 12,
  //       ),
  //     ),
  //   );
  // }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: AppColors.accent),
        const SizedBox(width: 10),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(BuildContext context, ProductDetail product) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.fromLTRB(24, 10, 24, 24),
        decoration: BoxDecoration(
          color: AppColors.background,
          border: const Border(top: BorderSide(color: AppColors.inputBorder)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Added to cart',
                  style: GoogleFonts.inter(fontSize: 13),
                ),
                backgroundColor: AppColors.accent,
                duration: const Duration(seconds: 2),
              ),
            );
          },
          child: Container(
            height: 52,
            color: AppColors.textPrimary,
            child: Center(
              child: Text(
                'ADD TO CART',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // best-effort named color parser
  Color _namedColorToColor(String value) {
    final trimmed = value.trim();

    // Handle hex colors like #D8D8D8 or #FFF
    if (trimmed.startsWith('#')) {
      try {
        var hex = trimmed.substring(1); // remove '#'
        if (hex.length == 3) {
          hex = hex.split('').map((c) => '$c$c').join();
        }
        if (hex.length == 6) hex = 'FF$hex'; // add full opacity
        return Color(int.parse(hex, radix: 16));
      } catch (_) {
        return Colors.grey.shade300;
      }
    }

    // Fallback: named colors
    const map = {
      'red': Colors.red,
      'blue': Colors.blue,
      'green': Colors.green,
      'black': Colors.black,
      'white': Colors.white,
      'grey': Colors.grey,
      'gray': Colors.grey,
      'pink': Colors.pink,
      'orange': Colors.orange,
      'purple': Colors.purple,
      'yellow': Colors.yellow,
      'brown': Colors.brown,
    };
    return map[trimmed.toLowerCase()] ?? Colors.grey.shade300;
  }
}
