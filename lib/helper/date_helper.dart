import 'package:intl/intl.dart';

String getTodaysDate() {
  return DateFormat.yMMMMd('en_US').format(DateTime.now());
}

DateTime convertTimestampToDateTime(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
}

String formatDateTime(DateTime dateTime) {
  return DateFormat().format(dateTime);
}
