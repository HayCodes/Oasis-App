import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/app/shop/presentation/bloc/shop.bloc.dart';
import 'package:oasis/app/shop/presentation/bloc/shop.events.dart';
import 'package:oasis/app/shop/product_detail_screen.dart';
import 'package:oasis/components/themes/app_theme.dart';

class ProductCard extends StatefulWidget {

  const ProductCard({super.key, required this.product, this.isWide = false});
  final Product product;
  final bool isWide;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  // bool _isFavorite = false;

  bool get _isNew =>
      DateTime
          .now()
          .difference(widget.product.createdAt)
          .inDays <= 30;

  bool get _isOnSale => widget.product.price.isOnSale;

  double get _displayPrice => widget.product.price.effectivePrice;

  double get _originalPrice => widget.product.price.amount;

  // type 'List<dynamic>' is not a subtype of type 'Map<String,dynamic>' in type cast
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ShopBloc>().add(FetchProductDetail(widget.product.slug));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const ProductDetailScreen(),
          ),
        );
      },
      child: Container(
        decoration: const BoxDecoration(color: AppColors.background),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Expanded(
              flex: widget.isWide ? 5 : 6,
              child: Stack(
                children: [
                  // Product Image
                  ClipRRect(
                    child: CachedNetworkImage(
                      imageUrl: widget.product.featuredImage.src,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: AppColors.background,
                        child: const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 1,
                            color: AppColors.accent,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: AppColors.accentLight,
                        child: const Icon(
                          Icons.image_outlined,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ),
                  ),

                  // Badges
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_isNew)
                          _buildBadge('NEW', AppColors.black, Colors.white),
                        if (_isOnSale) ...[
                          if (_isNew) const SizedBox(height: 6),
                          _buildBadge('SALE', AppColors.accent, Colors.white),
                        ],
                      ],
                    ),
                  ),

                  // Favorite Button
                  // Positioned(
                  //   top: 8,
                  //   right: 8,
                  //   child: GestureDetector(
                  //     onTap: () {
                  //       setState(() => _isFavorite = !_isFavorite);
                  //     },
                  //     child: Container(
                  //       width: 36,
                  //       height: 36,
                  //       decoration: const BoxDecoration(
                  //         color: Colors.white,
                  //         shape: BoxShape.circle,
                  //       ),
                  //       child: Icon(
                  //         _isFavorite ? Icons.favorite : Icons.favorite_border,
                  //         size: 16,
                  //         color: _isFavorite
                  //             ? AppColors.accent
                  //             : AppColors.textMuted,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),

            // Info Section
            Expanded(
              flex: widget.isWide ? 3 : 4,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.product.category.name.toUpperCase(),
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textMuted,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          widget.product.name,
                          style: GoogleFonts.inter(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              '\$${_displayPrice.toStringAsFixed(0)}',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: _isOnSale
                                    ? AppColors.accent
                                    : AppColors.textPrimary,
                              ),
                            ),
                            if (_isOnSale) ...[
                              const SizedBox(width: 6),
                              Text(
                                '\$${_originalPrice.toStringAsFixed(0)}',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: AppColors.textMuted,
                                  decoration: TextDecoration.lineThrough,
                                ),
                              ),
                            ],
                          ],
                        ),
                        // Rating
                        Row(
                          children: [
                            const Icon(
                              Icons.local_fire_department_rounded,
                              size: 12,
                              color: AppColors.accent,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              widget.product.popularity.toString(),
                              style: GoogleFonts.inter(
                                fontSize: 11,
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(String label, Color bg, Color textColor) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(color: bg),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: textColor,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}
