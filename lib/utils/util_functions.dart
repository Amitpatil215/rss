import 'package:intl/intl.dart';

DateTime parseDate(String? data) {
  if (data == null) {
    return DateTime.now();
  }

  DateFormat dateFormat = DateFormat("dd-MM-yyyy");
  // Parse the string to a DateTime object
  DateTime parsedDate = dateFormat.parse(data);

  return parsedDate;
}