import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/categories/data/categories.repository.dart';
import 'package:oasis/app/categories/presentation/bloc/category_content/category_content.events.dart';
import 'package:oasis/app/categories/presentation/bloc/category_content/category_content.state.dart';
import 'package:oasis/common/common.dart';

class CategoryContentBloc
    extends Bloc<CategoryContentEvent, CategoryContentState> {
  CategoryContentBloc(this._categoryRepository)
    : super(const CategoryContentState()) {
    on<FetchCategoryContentEvent>(_onFetchCategoryContentEvent);
  }

  final CategoryRepository _categoryRepository;

  Future<void> _onFetchCategoryContentEvent(
    FetchCategoryContentEvent event,
    Emitter<CategoryContentState> emit,
  ) async {
    emit(state.copyWith(contentStatus: FetchStatus.loading));

    final res = await _categoryRepository.getCategoryContent(event.slug);

    res.fold(
      (error) => emit(
        state.copyWith(contentStatus: FetchStatus.failure, errorMessage: error),
      ),
      (content) => emit(
        state.copyWith(
          category: content.category,
          tags: content.tags,
          products: content.products,
          relatedProducts: content.relatedProducts,
          contentStatus: FetchStatus.success,
        ),
      ),
    );
  }
}
