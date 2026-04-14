import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:oasis/app/categories/data/categories.datasource.dart';
import 'package:oasis/app/categories/models/categories.model.dart';
import 'package:oasis/app/categories/models/category_content.model.dart';
import 'package:oasis/common/common.dart';
import 'package:oasis/core/integrations/integrations.dart';

abstract class CategoryRepository {
  AsyncEither<List<Category>> getAllCategories({String? query});
  AsyncEither<CategoryContent> getCategoryContent(String slug);
}

class CategoryRepositoryImpl implements CategoryRepository {
  const CategoryRepositoryImpl(this._categoryDataSource);
  final CategoriesDataSource _categoryDataSource;

  @override
  AsyncEither<List<Category>> getAllCategories({String? query}) async {
    try {
      final res = await _categoryDataSource.getAllCategories(query: query);

      if (res.status) {
        final categories = (res.data as List)
            .map((e) => Category.fromJson(e as Map<String, dynamic>))
            .toList();
        return Right(categories);
      } else {
        return Left(res.message ?? AppTexts.GENERIC_ERROR);
      }
    } on DioException catch (e) {
      return Left(NetworkExceptions.getDioException(e));
    } catch (e) {
      return const Left(AppTexts.GENERIC_ERROR);
    }
  }

  @override
  AsyncEither<CategoryContent> getCategoryContent(String slug) async {
    try {
      final res = await _categoryDataSource.getCategoryContent(slug);
      if (res.status) {
        final content = CategoryContent.fromJson(res.data);
        return Right(content);
      } else {
        return Left(res.message ?? AppTexts.GENERIC_ERROR);
      }
    } on DioException catch(e) {
      return Left(NetworkExceptions.getDioException(e));
    } catch (e) {
      return const Left(AppTexts.GENERIC_ERROR);
    }
  }
}
