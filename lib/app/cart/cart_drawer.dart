import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oasis/components/themes/app_theme.dart';

class CartDrawer extends StatefulWidget {
  const CartDrawer({super.key});

  static void show(BuildContext context) {
    Navigator.of(context).push(
      PageRouteBuilder(
        opaque: false,
        barrierDismissible: true,
        pageBuilder: (_, _, _) => const CartDrawer(),
        transitionsBuilder: (_, animation, _, child) {
          return SlideTransition(
            position:
                Tween<Offset>(
                  begin: const Offset(1.0, 0.0),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(parent: animation, curve: Curves.easeOut),
                ),
            child: child,
          );
        },
      ),
    );
  }

  @override
  State<CartDrawer> createState() => _CartDrawerState();
}

class _CartDrawerState extends State<CartDrawer> {
  // 🔁 Replace with your real cart state later
  late final List<Map<String, dynamic>> cartItems = [
    {
      'name': 'possimus eius facere',
      'description':
          'Est ea consequatur voluptatem at cum at. Aut magni qui minima dicta aut consectetur quia. Consequuntur omnis perspiciatis vel id.',
      'price': 301.0,
      'quantity': 1,
      'color': const Color(0xFFC4A0A0),
      'image': 'images/light.png',
    },
    {
      'name': 'possimus eius facere',
      'description':
          'Est ea consequatur voluptatem at cum at. Aut magni qui minima dicta aut consectetur quia. Consequuntur omnis perspiciatis vel id.',
      'price': 301.0,
      'quantity': 1,
      'color': const Color(0xFFC4A0A0),
      'image': 'images/light.png',
    },
    {
      'name': 'possimus eius facere',
      'description':
          'Est ea consequatur voluptatem at cum at. Aut magni qui minima dicta aut consectetur quia. Consequuntur omnis perspiciatis vel id.',
      'price': 301.0,
      'quantity': 1,
      'color': const Color(0xFFC4A0A0),
      'image': 'images/light.png',
    },
    {
      'name': 'possimus eius facere',
      'description':
          'Est ea consequatur voluptatem at cum at. Aut magni qui minima dicta aut consectetur quia. Consequuntur omnis perspiciatis vel id.',
      'price': 301.0,
      'quantity': 1,
      'color': const Color(0xFFC4A0A0),
      'image': 'images/light.png',
    },
  ];

  double get subtotal =>
      cartItems.fold(0, (sum, item) => sum + item['price'] * item['quantity']);

  void _incrementQuantity(int index) {
    setState(() => cartItems[index]['quantity']++);
  }

  void _decrementQuantity(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      }
    });
  }

  void _removeItem(int index) {
    setState(() => cartItems.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;
    final isEmpty = cartItems.isEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  'Cart',
                  style: textStyle.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: const Icon(Icons.close, size: 18),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Body
            Expanded(
              child: isEmpty ? _buildEmptyCart(textStyle) : _buildCartItems(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyCart(TextTheme textStyle) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Your cart is empty',
          style: textStyle.titleMedium?.copyWith(
            color: Colors.black87,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 24),
        Image.asset('images/light.png', height: 280),
      ],
    );
  }

  Widget _buildCartItems() {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            itemCount: cartItems.length,
            itemBuilder: (context, index) => _buildCartItem(index),
          ),
        ),
        _buildSubtotal(),
        _buildCheckoutButton(),
      ],
    );
  }

  Widget _buildCartItem(int index) {
    final item = cartItems[index];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 120,
              height: 140,
              color: Colors.grey.shade100,
              child: Image.asset(item['image'], fit: BoxFit.cover),
            ),
          ),
          const SizedBox(width: 16),

          // Product details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () => _removeItem(index),
                      icon: const Icon(Icons.delete_outline, size: 20),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  item['description'],
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                    height: 1.4,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${item['price'].toStringAsFixed(0)}',
                  style: const TextStyle(
                    color: Color(0xFF6B6BDB),
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 10),

                // Quantity controls + color swatch
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Row(
                        children: [
                          _quantityButton(
                            icon: Icons.remove,
                            onTap: () => _decrementQuantity(index),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              '${item['quantity']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          _quantityButton(
                            icon: Icons.add,
                            onTap: () => _incrementQuantity(index),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Color swatch
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: item['color'],
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Icon(icon, size: 16),
      ),
    );
  }

  Widget _buildSubtotal() {
    return Column(
      children: [
        const Divider(height: 1),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                'Subtotal',
                style: TextStyle(color: Colors.grey.shade600, fontSize: 15),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '\$${subtotal.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Color(0xFF6B6BDB),
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'SHIPPING & TAXES CALCULATED AT CHECKOUT',
                    style: TextStyle(
                      color: Colors.grey.shade400,
                      fontSize: 9,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCheckoutButton() {
    return SafeArea(
      top: false,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.buttonPrimary
            ),
            child: Center(
              child: Text(
                'CHECKOUT',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ),
      // child: TextButton(
      //   style: ButtonStyle(
      //     maximumSize: WidgetStatePropertyAll(Size:);
      //   ),
      //   onPressed: () {
      //     // 🔁 Handle checkout
      //   },
      //   child: const Text(
      //     'CHECKOUT',
      //     style: TextStyle(
      //       color: Colors.white,
      //       fontSize: 16,
      //       fontWeight: FontWeight.w500,
      //     ),
      //   ),
      // ),
    );
  }
}
