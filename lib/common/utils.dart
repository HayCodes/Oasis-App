import 'dart:async';
import 'dart:ui';

import 'package:oasis/app/shop/models/product.model.dart';

class Debouncer {
  Debouncer({required this.milliseconds});

  final int milliseconds;
  Timer? _timer;

  void run(VoidCallback action) {
    if (_timer?.isActive ?? false) _timer!.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

List<String> extractCategories(List<Product> products) {
  final seen = <String>{};
  final categories = <String>['All'];
  for (final p in products) {
    if (seen.add(p.category.name)) {
      categories.add(p.category.name);
    }
  }
  return categories;
}

