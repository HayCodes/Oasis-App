import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:oasis/components/themes/app_theme.dart';
import 'package:oasis/components/widgets/home_screen/faq.dart';
import 'package:oasis/components/widgets/page_header.dart';

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
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('CONTACT US', style: textStyle.bodyMedium),
              Text('+1 999 888-76-54', style: textStyle.labelLarge,),
              const SizedBox(height: 10,),
              Text('EMAIL', style: textStyle.bodyMedium),
              Text('hello@oasis.com', style: textStyle.labelLarge,),
              const SizedBox(height: 10,),
              Text('ADDRESS', style: textStyle.bodyMedium),
              Text('2183 Thornridge Dr, Syracuse, Connecticut 28654',
                style: textStyle.labelLarge,),
              const SizedBox(height: 10,),
              Text('OPENING HOURS', style: textStyle.bodyMedium),
              Text('Monday - Friday: 9am - 6pm', style: textStyle.labelLarge,),
            ],
          ),
        ),
        const FAQSection()
      ],
    ),
  );
}