import 'package:timeago/timeago.dart' as timeago;

String formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  return timeago.format(dateTime);
}
