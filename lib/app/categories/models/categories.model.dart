import 'package:equatable/equatable.dart';

class CategoriesModel extends Equatable {

  const CategoriesModel({
    required this.data,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
  final List<Category> data;

  CategoriesModel copyWith({
    List<Category>? data,
  }) {
    return CategoriesModel(
      data: data ?? this.data,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object> get props => [data];
}

class Category extends Equatable {

  const Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.image,
    required this.popularity,
    required this.productCount,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'] as int,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      popularity: json['popularity'] as int,
      productCount: json['productCount'] as int,
    );
  }
  final int id;
  final String name;
  final String slug;
  final String description;
  final String image;
  final int popularity;
  final int productCount;

  Category copyWith({
    int? id,
    String? name,
    String? slug,
    String? description,
    String? image,
    int? popularity,
    int? productCount,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      image: image ?? this.image,
      popularity: popularity ?? this.popularity,
      productCount: productCount ?? this.productCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'slug': slug,
      'description': description,
      'image': image,
      'popularity': popularity,
      'productCount': productCount,
    };
  }

  @override
  List<Object> get props =>
      [
        id,
        name,
        slug,
        description,
        image,
        popularity,
        productCount,
      ];
}