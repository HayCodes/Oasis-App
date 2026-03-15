import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme;

    final faqs = [
      FAQItem(
        number: '01',
        question: 'What types of furniture do you offer?',
        answer:
        'We offer a wide range of contemporary furniture including sofas, chairs, tables, beds, storage solutions, and home furniture. Our collection is carefully curated to combine style with functionality and quality.',
        initiallyExpanded: true,
      ),
      FAQItem(
        number: '02',
        question: 'Do you offer international shipping?',
        answer:
        'Yes, we offer international shipping to select countries. Shipping costs and delivery times vary depending on your location. Please contact our customer service team for specific details about shipping to your region.',
      ),
      FAQItem(
        number: '03',
        question: 'What is your return policy?',
        answer:
        'We offer a 30-day return policy on most items. Products must be in original condition with all packaging and documentation. For detailed information about returns and exchanges, please refer to our full return policy page.',
      ),
      FAQItem(
        number: '04',
        question: 'What payment methods do you accept?',
        answer:
        'We accept major credit cards (Visa, MasterCard, American Express), PayPal, and financing options through Affirm. All transactions are secure and encrypted.',
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Text('FAQ', style: textStyle.displayMedium),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 20.0),
          child: Text(
            'We have got the answers to your questions',
            style: textStyle.labelLarge,
          ),
        ),
        const SizedBox(height: 10),
        ...faqs.map((faq) => CustomAccordionTile(item: faq)),
      ],
    );
  }
}

class FAQItem {
  final String number;
  final String question;
  final String answer;
  final bool initiallyExpanded;

  FAQItem({
    required this.number,
    required this.question,
    required this.answer,
    this.initiallyExpanded = false,
  });
}

class CustomAccordionTile extends StatefulWidget {
  final FAQItem item;

  const CustomAccordionTile({super.key, required this.item});

  @override
  State<CustomAccordionTile> createState() => _CustomAccordionTileState();
}

class _CustomAccordionTileState extends State<CustomAccordionTile>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _controller;
  late Animation<double> _heightFactor;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.item.initiallyExpanded;
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
      value: _isExpanded ? 1.0 : 0.0,
    );
    _heightFactor = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: _toggle,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Number
                SizedBox(
                  width: 32,
                  child: Text(
                    widget.item.number,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF888888),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Question
                Expanded(
                  child: Text(
                    widget.item.question,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // Toggle button
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF2F2F2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isExpanded
                            ? Icons.arrow_upward
                            : Icons.arrow_downward,
                        color: const Color(0xFF444444),
                        size: 20,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        // Expandable answer
        ClipRect(
          child: AnimatedBuilder(
            animation: _heightFactor,
            builder: (context, child) {
              return Align(
                alignment: Alignment.topLeft,
                heightFactor: _heightFactor.value,
                child: child,
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 52, bottom: 20),
              child: Text(
                widget.item.answer,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textMuted,
                  height: 1.6,
                ),
              ),
            ),
          ),
        ),
        // Divider
        const Divider(height: 1, color: Color(0xFFE5E5E5)),
      ],
    );
  }
}