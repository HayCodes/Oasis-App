import 'package:equatable/equatable.dart';

abstract class ShopEvent extends Equatable {
  const ShopEvent();

  @override
  List<Object?> get props => [];
}

class FetchTopProducts extends ShopEvent {
  const FetchTopProducts();
}

class FetchAllProducts extends ShopEvent {
  const FetchAllProducts({this.query});

  final String? query;

  @override
  List<Object?> get props => [query];
}

class FetchMoreProducts extends ShopEvent {
  const FetchMoreProducts({this.query});

  final String? query;

  @override
  List<Object?> get props => [query];
}

class FetchProductDetail extends ShopEvent {
  const FetchProductDetail(this.slug);

  final String slug;

  @override
  List<Object?> get props => [slug];
}
