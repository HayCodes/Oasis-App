class ProductPrice {
  const ProductPrice({
    required this.amount,
    required this.currency,
    this.discount,
  });

  factory ProductPrice.fromJson(Map<String, dynamic> json) =>
      ProductPrice(
        amount: (json['amount'] as num).toDouble(),
        currency: json['currency'] as String? ?? 'USD',
        discount: json['discount'] != null
            ? (json['discount'] as num).toDouble()
            : null,
      );

  final double amount;
  final String currency;
  final double? discount;

  /// Price after discount applied
  double get effectivePrice {
    if (discount == null || discount == 0) return amount;
    return amount - (amount * (discount! / 100));
  }

  bool get isOnSale => (discount ?? 0) > 0;
}