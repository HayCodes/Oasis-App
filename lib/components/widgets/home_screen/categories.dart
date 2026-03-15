import 'package:flutter/material.dart';
import 'package:oasis/components/themes/app_theme.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});
  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text('Categories', style: textStyle.displayMedium),
        ),
        SizedBox(height: 15),
        CategoriesCard(
          title: 'Sitting Room',
          imageUrl: 'images/sofa.png',
          onTap: () => {},
        ),
        SizedBox(height: 15),
        CategoriesCard(
          title: 'Accessories',
          imageUrl: 'images/flower-vase.png',
          onTap: () => {},
        ),
        SizedBox(height: 15),
        CategoriesCard(
          title: 'Kitchen',
          imageUrl: 'images/kettle.png',
          onTap: () => {},
        ),
        SizedBox(height: 15),
        CategoriesCard(
          title: 'Bedroom',
          imageUrl: 'images/stand.png',
          // ignore: avoid_print
          onTap: () => {print('Bedroom tapped')},
        ),
      ],
    );
  }
}

class CategoriesCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const CategoriesCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.background.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        clipBehavior: Clip.hardEdge,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      title,
                      style: TextStyle(
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
                      onPressed: onTap,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.resolveWith((states) {
                          if (states.contains(WidgetState.pressed)) {
                            return AppColors.buttonPrimary;
                          }
                          return AppColors.background;
                        }),
                        maximumSize: WidgetStatePropertyAll(Size(120, 50)),
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                            side: BorderSide(
                              color: AppColors.textMuted,
                              width: 1.5,
                            ),
                          ),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Shop Now', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                          Icon(Icons.arrow_forward, size: 13,),
                        ]
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
