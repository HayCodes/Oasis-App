import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllCategoriesEvent extends CategoriesEvent {
  const FetchAllCategoriesEvent({this.query});

  final String? query;

  @override
  List<Object?> get props => [query];
}
