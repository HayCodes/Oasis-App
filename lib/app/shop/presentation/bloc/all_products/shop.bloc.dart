import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/shop/data/shop.repository.dart';
import 'package:oasis/app/shop/presentation/bloc/all_products/shop.events.dart';
import 'package:oasis/app/shop/presentation/bloc/all_products/shop.state.dart';
import 'package:oasis/common/common.dart';

class AllProductsBloc extends Bloc<AllProductsEvent, AllProductsState> {
  AllProductsBloc(this._repository) : super(const AllProductsState()) {
    on<FetchAllProducts>(_onFetchAllProducts);
    on<FetchMoreProducts>(_onFetchMoreProducts);
  }

  final ProductRepository _repository;

  Future<void> _onFetchAllProducts(
    FetchAllProducts event,
    Emitter<AllProductsState> emit,
  ) async {
    emit(
      state.copyWith(
        status: FetchStatus.loading,
        products: [],
        currentPage: 1,
        hasReachedMax: false,
      ),
    );
    final result = await _repository.getAllProducts(query: event.query);
    result.fold(
      (error) => emit(
        state.copyWith(status: FetchStatus.failure, errorMessage: error),
      ),
      (res) => emit(
        state.copyWith(
          status: FetchStatus.success,
          products: res.data,
          currentPage: res.meta.currentPage,
          hasReachedMax: res.meta.currentPage >= res.meta.lastPage,
        ),
      ),
    );
  }

  Future<void> _onFetchMoreProducts(
    FetchMoreProducts event,
    Emitter<AllProductsState> emit,
  ) async {
    if (state.hasReachedMax || state.status == FetchStatus.loading) return;

    emit(state.copyWith(status: FetchStatus.loading));
    final nextPage = state.currentPage + 1;
    final query =
        'page=$nextPage${event.query != null ? '&${event.query}' : ''}';
    final result = await _repository.getAllProducts(query: query);
    result.fold(
      (error) => emit(
        state.copyWith(status: FetchStatus.failure, errorMessage: error),
      ),
      (res) => emit(
        state.copyWith(
          status: FetchStatus.success,
          products: [...state.products, ...res.data],
          currentPage: res.meta.currentPage,
          hasReachedMax: res.meta.currentPage >= res.meta.lastPage,
        ),
      ),
    );
  }
}
