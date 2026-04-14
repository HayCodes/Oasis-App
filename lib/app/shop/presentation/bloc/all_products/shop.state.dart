import 'package:equatable/equatable.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/common/common.dart';

class AllProductsState extends Equatable {
  const AllProductsState({
    this.products = const [],
    this.status = FetchStatus.initial,
    this.currentPage = 1,
    this.hasReachedMax = false,
    this.errorMessage,
  });

  final List<Product> products;
  final FetchStatus status;
  final int currentPage;
  final bool hasReachedMax;
  final String? errorMessage;

  AllProductsState copyWith({
    List<Product>? products,
    FetchStatus? status,
    int? currentPage,
    bool? hasReachedMax,
    String? errorMessage,
  }) =>
      AllProductsState(
        products: products ?? this.products,
        status: status ?? this.status,
        currentPage: currentPage ?? this.currentPage,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props =>
      [
        products,
        status,
        currentPage,
        hasReachedMax,
        errorMessage,
      ];
}