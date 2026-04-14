class ProductCategory {
  const ProductCategory({required this.name, required this.slug});

  factory ProductCategory.empty() => const ProductCategory(name: '', slug: '');

  factory ProductCategory.fromJson(Map<String, dynamic> json) =>
      ProductCategory(
        name: json['name'] as String,
        slug: json['slug'] as String,
      );

  final String name;
  final String slug;
}