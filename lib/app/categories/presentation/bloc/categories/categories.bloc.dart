import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/categories/data/categories.repository.dart';
import 'package:oasis/app/categories/presentation/bloc/categories/categories.events.dart';
import 'package:oasis/app/categories/presentation/bloc/categories/categories.state.dart';
import 'package:oasis/common/common.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  CategoriesBloc(this._categoryRepository) : super(const CategoriesState()) {
    on<FetchAllCategoriesEvent>(_onFetchAllCategories);
  }

  final CategoryRepository _categoryRepository;

  Future<void> _onFetchAllCategories(
    FetchAllCategoriesEvent event,
    Emitter<CategoriesState> emit,
  ) async {
    emit(state.copyWith(categoriesStatus: FetchStatus.loading));

    final res = await _categoryRepository.getAllCategories(query: event.query);

    res.fold(
      (error) => emit(
        state.copyWith(
          categoriesStatus: FetchStatus.failure,
          errorMessage: error,
        ),
      ),
      (categories) => emit(
        state.copyWith(
          categories: categories,
          categoriesStatus: FetchStatus.success,
        ),
      ),
    );
  }
}
