import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/components/widgets/page_header.dart';

import '../components/themes/app_theme.dart';

class Support extends StatelessWidget {
  const Support({super.key});

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
              title: 'Support',
              textStyle: textStyle,
              onTap: () {
                GoRouter.of(context).pop();
              },
            ),

            Expanded(child: _buildSupport(context)),
          ],
        ),
      ),
    );
  }
}


Widget _buildSupport(BuildContext context) {
  final textStyle = Theme.of(context).textTheme;

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('CONTACT US', style: textStyle.labelLarge)
    
        ],
      ),
    ),
  );
}