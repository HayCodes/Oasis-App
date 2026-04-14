import 'package:equatable/equatable.dart';

abstract class TopProductsEvent extends Equatable {
  const TopProductsEvent();

  @override
  List<Object?> get props => [];
}

class FetchTopProducts extends TopProductsEvent {
  const FetchTopProducts();
}