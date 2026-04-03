import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oasis/app/categories/data/categories.repository.dart';
import 'package:oasis/app/categories/models/category_content.model.dart';
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

    if (res.status) {
      final model = CategoryContentResponse.fromJson(
        res.data as Map<String, dynamic>,
      );
      emit(
        state.copyWith(
          category: model.category,
          tags: model.tags,
          products: model.products,
          relatedProducts: model.relatedProducts,
          contentStatus: FetchStatus.success,
        ),
      );
    } else {
      emit(
        state.copyWith(
          contentStatus: FetchStatus.failure,
          errorMessage: res.message,
        ),
      );
    }
  }
}
