import 'package:equatable/equatable.dart';
import 'package:oasis/app/categories/models/categories.model.dart';
import 'package:oasis/common/common.dart';

class CategoriesState extends Equatable {
  const CategoriesState({
    this.categories = const [],
    this.categoriesStatus = FetchStatus.initial,
    this.errorMessage,
  });

  final List<Category> categories;
  final FetchStatus categoriesStatus;
  final String? errorMessage;

  CategoriesState copyWith({
    List<Category>? categories,
    FetchStatus? categoriesStatus,
    String? errorMessage,
  }) {
    return CategoriesState(
      categories: categories ?? this.categories,
      categoriesStatus: categoriesStatus ?? this.categoriesStatus,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [categories, categoriesStatus, errorMessage];
}