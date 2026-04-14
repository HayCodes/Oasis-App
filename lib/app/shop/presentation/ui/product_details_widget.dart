import 'package:flutter/material.dart';
import 'package:oasis/app/categories/presentation/ui/widgets/category_view_page_widget.dart';
import 'package:oasis/app/shop/models/product.model.dart';

class BuildRelatedProducts extends StatelessWidget {
  const BuildRelatedProducts({super.key, required this.products, this.header});

  final List<Product> products;
  final String? header;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 220,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: products.length,
            separatorBuilder: (context, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) =>
                SizedBox(
                  width: 160,
                  child: ProductCard(product: products[index]),
                ),
          ),
        ),
      ],
    );
  }
}
