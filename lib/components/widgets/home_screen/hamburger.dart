import 'package:flutter/material.dart';

class HamburgerButton extends StatelessWidget {
  final BuildContext context;
  const HamburgerButton({super.key, required this.context});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Scaffold.of(this.context).openDrawer(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 22, height: 1.5, color: Colors.black),
          const SizedBox(height: 5),
          Container(width: 14, height: 1.5, color: Colors.black),
        ],
      ),
    );
  }
}