import 'package:equatable/equatable.dart';

abstract class ProductDetailEvent extends Equatable {
  const ProductDetailEvent();

  @override
  List<Object?> get props => [];
}

class FetchProductDetail extends ProductDetailEvent {
  const FetchProductDetail(this.slug);

  final String slug;

  @override
  List<Object?> get props => [slug];
}