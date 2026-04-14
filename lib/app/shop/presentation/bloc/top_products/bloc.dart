import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/shop/data/shop.repository.dart';
import 'package:oasis/app/shop/presentation/bloc/top_products/events.dart';
import 'package:oasis/app/shop/presentation/bloc/top_products/state.dart';
import 'package:oasis/common/common.dart';

class TopProductsBloc extends Bloc<TopProductsEvent, TopProductsState> {
  TopProductsBloc(this._repository) : super(const TopProductsState()) {
    on<FetchTopProducts>(_onFetchTopProducts);
  }

  final ProductRepository _repository;

  Future<void> _onFetchTopProducts(
    FetchTopProducts event,
    Emitter<TopProductsState> emit,
  ) async {
    emit(state.copyWith(status: FetchStatus.loading));
    final result = await _repository.getTopProducts();
    result.fold(
      (error) {
        emit(state.copyWith(status: FetchStatus.failure, errorMessage: error));
      },
      (content) {
        emit(
          state.copyWith(products: content.data, status: FetchStatus.success),
        );
      },
    );
  }
}
