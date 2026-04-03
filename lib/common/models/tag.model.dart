class Tag {
  const Tag({
    required this.id,
    required this.name,
    required this.slug,
  });

  factory Tag.fromJson(Map<String, dynamic> json) =>
      Tag(
        id: json['id'] as int,
        name: json['name'] as String,
        slug: json['slug'] as String,
      );

  final int id;
  final String name;
  final String slug;
}