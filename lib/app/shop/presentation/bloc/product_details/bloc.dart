import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/shop/data/shop.repository.dart';
import 'package:oasis/app/shop/presentation/bloc/product_details/events.dart';
import 'package:oasis/app/shop/presentation/bloc/product_details/state.dart';
import 'package:oasis/common/common.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc(this._repository) : super(const ProductDetailState()) {
    on<FetchProductDetail>(_onFetchProductDetail);
  }

  final ProductRepository _repository;

  Future<void> _onFetchProductDetail(
    FetchProductDetail event,
    Emitter<ProductDetailState> emit,
  ) async {
    emit(state.copyWith(productDetailsStatus: FetchStatus.loading));
    final result = await _repository.getProductDetails(event.slug);
    result.fold(
      (error) => emit(
        state.copyWith(productDetailsStatus: FetchStatus.failure, errorMessage: error),
      ),
      (res) => emit(
        state.copyWith(
          productDetailsStatus: FetchStatus.success,
          product: res.product,
          relatedProducts: res.relatedProducts,
        ),
      ),
    );
  }
}
