import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/components/themes/app_theme.dart';

import 'package:oasis/services/router/app_router_constants.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text('Categories', style: textStyle.displayMedium),
        ),
        const SizedBox(height: 15),
        const CategoriesCard(
          slug: 'sitting-room',
          title: 'Sitting Room',
          imageUrl: 'images/sofa.png',
        ),
        const SizedBox(height: 15),
        const CategoriesCard(
          slug: 'accessories',
          title: 'Accessories',
          imageUrl: 'images/flower-vase.png',
        ),
        const SizedBox(height: 15),
        const CategoriesCard(
          slug: 'kitchen',
          title: 'Kitchen',
          imageUrl: 'images/kettle.png',
        ),
        const SizedBox(height: 15),
        const CategoriesCard(
          slug: 'bedroom',
          title: 'Bedroom',
          imageUrl: 'images/stand.png',
        ),
      ],
    );
  }
}

class CategoriesCard extends StatelessWidget {

  const CategoriesCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.slug,
  });
  final String title;
  final String imageUrl;
  final String slug;

  @override
  Widget build(BuildContext context) {
    void handleTap() {
      GoRouter.of(
        context,
      ).pushNamed(RouteNames.categoryView, pathParameters: {'slug': slug});
    }

    return GestureDetector(
      onTap: handleTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.background.withValues(alpha: 0.2),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // shop now button
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: TextButton(
                      onPressed: handleTap,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith((
                          states,
                        ) {
                          if (states.contains(WidgetState.pressed)) {
                            return AppColors.buttonPrimary;
                          }
                          return AppColors.background;
                        }),
                        maximumSize: const WidgetStatePropertyAll(Size(120, 50)),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: const BorderSide(
                              color: AppColors.textMuted,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                           Text(
                            'Shop Now',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.arrow_forward, size: 13),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox.expand(
                child: Image.asset(imageUrl, fit: BoxFit.cover),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
