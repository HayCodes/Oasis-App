import 'package:intl/intl.dart';

extension StringUtilss on String? {
  bool get isNullOrEmpty => this == null || (this ?? '').isEmpty;

  String get formattedDob {
    final replacedDob = '${this?.replaceAll('/', '-')}';
    final day = replacedDob.split('-')[0];
    final month = replacedDob.split('-')[1];
    final year = replacedDob.split('-')[2];

    return '$year-$month-$day';
  }

  String removeWhitespace() {
    return this?.replaceAll(RegExp(r'\s+'), '') ?? "";
  }

  String get formatPhone => this?.replaceFirst(RegExp('0'), '').trim() ?? '';

  String toCapitalized() => (this?.length ?? 0) > 0
      ? '${this?[0].toUpperCase()}${this?.substring(1).toLowerCase()}'
      : '';

  String toTitleCase() =>
      this
          ?.replaceAll(RegExp(' +'), ' ')
          .split(' ')
          .map((str) => str.toCapitalized())
          .join(' ') ??
      '';

  String get websocketUrl => '${(this ?? '').replaceAll('https', 'wss')}/ws';

  String formatAmount() {
    final value = NumberFormat('#,##0.00', 'en_US');
    final format = double.tryParse(this ?? "0");
    if (format == null) return '0.00';
    return value.format(format);
  }

  num cleanAmount() {
    return num.tryParse(this?.replaceAll(',', '') ?? '0') ?? 0;
  }
}
