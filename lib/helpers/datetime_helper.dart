import 'package:intl/intl.dart';

import '../constants/constants.dart';

DateTime convertMonthYearStringToDateTime(String date) {	
  if (date == endDatePresent) {	
    return DateTime.now();	
  }	
  return DateFormat('MMMM yyyy').parse(date);	
}	

String convertDateTimeToMonthYearString(DateTime date) {
  var month = DateFormat.MMMM().format(date).toString();
  var year = DateFormat.y().format(date).toString();
  return '$month $year';
}

DateTime convertYearStringToDateTime(String date) {
  return DateFormat.y().parse(date);
}

String convertDateTimeToYearString(DateTime date) {
  return DateFormat.y().format(date).toString();
}