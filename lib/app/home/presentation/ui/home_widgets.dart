import 'package:flutter/material.dart';
import 'package:oasis/components/cart_button.dart';
import 'package:oasis/components/hamburger.dart';

class HeroBanner extends StatelessWidget {
  const HeroBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const SizedBox(height: 15.0),
        Column(
          children: [
            Text('FURNITURE STORE', style: textTheme.headlineSmall),
            const SizedBox(height: 5.0),
            Text(
              'Discover the Artistry of Modern Contemporary Furniture',
              style: textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5.0),
            Text(
              'Experience the elegance and functionality of cutting-edge design where luxury meets innovation in every piece for ultimate relaxation',
              style: textTheme.displaySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
        const SizedBox(height: 10.0),
        SizedBox(
          height: 300,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                'images/hero-chair.jpg',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Builder(
        builder: (context) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Hamburger
              HamburgerButton(context: context),

              // Logo
              const Expanded(
                child: Image(
                  image: AssetImage('images/Oasis.png'),
                  width: 20.0,
                  height: 20.0,
                ),
              ),

              // Cart icon
              const Cartbutton(),
            ],
          );
        },
      ),
    );
  }
}
