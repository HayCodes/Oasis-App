class FeaturedImage {

  const FeaturedImage({required this.src, required this.alt});

  factory FeaturedImage.fromJson(Map<String, dynamic> json) =>
      FeaturedImage(
        src: json['src'] as String? ?? '',
        alt: json['alt'] as String? ?? '',
      );
  final String src;
  final String alt;
}
