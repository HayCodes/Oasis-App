import 'package:equatable/equatable.dart';
import 'package:oasis/app/shop/models/product.model.dart';
import 'package:oasis/common/common.dart';

class TopProductsState extends Equatable {
  const TopProductsState({
    this.topProducts = const [],
    this.topProductStatus = FetchStatus.initial,
    this.errorMessage,
  });

  final List<Product> topProducts;
  final FetchStatus topProductStatus;
  final String? errorMessage;

  TopProductsState copyWith({
    List<Product>? products,
    FetchStatus? status,
    String? errorMessage,
  }) =>
      TopProductsState(
        topProducts: products ?? topProducts,
        topProductStatus: status ?? topProductStatus,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props => [topProducts, topProductStatus, errorMessage];
}