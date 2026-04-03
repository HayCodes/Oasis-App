import 'package:equatable/equatable.dart';

abstract class CategoryContentEvent extends Equatable {
  const CategoryContentEvent();

  @override
  List<Object?> get props => [];
}

class FetchCategoryContentEvent extends CategoryContentEvent {
  const FetchCategoryContentEvent(this.slug);

  final String slug;

  @override
  List<Object?> get props => [slug];
}
