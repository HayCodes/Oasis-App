import 'package:oasis/app/categories/data/categories.datasource.dart';
import 'package:oasis/common/models/abstract.api.model.dart';

abstract class CategoryRepository {
  Future<AbstractApiResponse> getAllCategories({String? query});

  Future<AbstractApiResponse> getCategoryContent(String slug);
}

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl(this._categoryDataSource);

  final CategoriesDataSource _categoryDataSource;

  @override
  Future<AbstractApiResponse> getAllCategories({String? query}) async {
    final res = await _categoryDataSource.getAllCategories(query: query);
    return res;
  }

  @override
  Future<AbstractApiResponse> getCategoryContent(String slug) async {
    final res = await _categoryDataSource.getCategoryContent(slug);
    return res;
  }
}
