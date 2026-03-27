import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/components/widgets/page_header.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PageHeader(
              title: 'Shop',
              textStyle: textStyle,
              onTap: () {
                GoRouter.of(context).pop();
              },
            ),

            Expanded(
              child: Container(
                padding: const EdgeInsets.all(10),
                child: const Text('Welcome to Oasis Shop'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
