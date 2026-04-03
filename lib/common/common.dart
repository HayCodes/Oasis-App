import 'package:oasis/common/typedefs.dart';

export 'constants.dart';
export 'enums.dart';
export 'extensions.dart';
export 'logger.dart';
export 'typedefs.dart';
export 'utils.dart';
export 'validators.dart';

T? parseNullable<T>(dynamic json, T Function(DynamicMap) fromJson) {
  return json != null ? fromJson(json) : null;
}
