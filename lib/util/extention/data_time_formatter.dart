import 'package:intl/intl.dart';

String formatDate(DateTime? date) {
  if (date == null) return "Date not available";
  return DateFormat('dd MMM yyyy').format(date);
}
