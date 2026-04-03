import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/shop/data/shop.repository.dart';
import 'package:oasis/app/shop/presentation/bloc/shop.events.dart';
import 'package:oasis/app/shop/presentation/bloc/shop.state.dart';
import 'package:oasis/common/common.dart';

class ShopBloc extends Bloc<ShopEvent, ShopState> {
  ShopBloc(this._repository) : super(const ShopState()) {
    on<FetchTopProducts>(_onFetchTopProducts);
    on<FetchAllProducts>(_onFetchAllProducts);
    on<FetchMoreProducts>(_onFetchMoreProducts);
    on<FetchProductDetail>(_onFetchProductDetail);
  }

  final ProductRepository _repository;

  Future<void> _onFetchTopProducts(
    FetchTopProducts event,
    Emitter<ShopState> emit,
  ) async {
    emit(state.copyWith(topProductsStatus: FetchStatus.loading));
    try {
      final res = await _repository.getTopProducts();
      emit(
        state.copyWith(
          topProducts: res.data,
          topProductsStatus: FetchStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          topProductsStatus: FetchStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchAllProducts(
    FetchAllProducts event,
    Emitter<ShopState> emit,
  ) async {
    // fresh fetch — reset pagination
    emit(
      state.copyWith(
        allProductsStatus: FetchStatus.loading,
        allProducts: [],
        currentPage: 1,
        hasReachedMax: false,
      ),
    );
    try {
      final res = await _repository.getAllProducts(query: event.query);
      emit(
        state.copyWith(
          allProducts: res.data,
          allProductsStatus: FetchStatus.success,
          currentPage: res.meta.currentPage,
          hasReachedMax: res.meta.currentPage >= res.meta.lastPage,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          allProductsStatus: FetchStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchMoreProducts(
    FetchMoreProducts event,
    Emitter<ShopState> emit,
  ) async {
    if (state.hasReachedMax) return;
    if (state.allProductsStatus == FetchStatus.loading) return;

    emit(state.copyWith(allProductsStatus: FetchStatus.loading));
    try {
      final nextPage = state.currentPage + 1;
      final query =
          'page=$nextPage${event.query != null ? '&${event.query}' : ''}';
      final res = await _repository.getAllProducts(query: query);
      emit(
        state.copyWith(
          allProducts: [...state.allProducts, ...res.data],
          allProductsStatus: FetchStatus.success,
          currentPage: res.meta.currentPage,
          hasReachedMax: res.meta.currentPage >= res.meta.lastPage,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          allProductsStatus: FetchStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchProductDetail(
    FetchProductDetail event,
    Emitter<ShopState> emit,
  ) async {
    emit(state.copyWith(productDetailStatus: FetchStatus.loading));
    try {
      final res = await _repository.getProductDetails(event.slug);
      emit(
        state.copyWith(
          productDetail: res.product,
          relatedProducts: res.relatedProducts,
          productDetailStatus: FetchStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          productDetailStatus: FetchStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
