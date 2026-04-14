import 'package:equatable/equatable.dart';

abstract class AllProductsEvent extends Equatable {
  const AllProductsEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllProducts extends AllProductsEvent {
  const FetchAllProducts({this.query});

  final String? query;

  @override
  List<Object?> get props => [query];
}

class FetchMoreProducts extends AllProductsEvent {
  const FetchMoreProducts({this.query});

  final String? query;

  @override
  List<Object?> get props => [query];
}