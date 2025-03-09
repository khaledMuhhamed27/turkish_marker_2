import 'package:timeago/timeago.dart' as timeago;

class ShortTimeMessages implements timeago.LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'ago';
  @override
  String suffixFromNow() => 'from now';

  @override
  String lessThanOneMinute(int seconds) => 'now';
  @override
  String aboutAMinute(int minutes) => '1 minutes ';
  @override
  String minutes(int minutes) => '${minutes}m ';
  @override
  String aboutAnHour(int minutes) => '1 hours ';
  @override
  String hours(int hours) => '${hours}h ';
  @override
  String aDay(int hours) => '1d ago';
  @override
  String days(int days) => '${days}d ';
  @override
  String aboutAMonth(int days) => '1 month ';
  @override
  String months(int months) => '${months}mo ';
  @override
  String aboutAYear(int year) => '1 year ';
  @override
  String years(int years) => '${years}y ';

  @override
  String wordSeparator() => ' ';
}

String formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formatted = timeago.format(dateTime, locale: 'short1');
  return formatted;
}
