import 'package:intl/intl.dart';
class Utils{
  static String formatDateTime(DateTime date) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd'); // Customize your format here
    return formatter.format(date);
  }

  final adminEmail = "djchinmoy9@gmail.com";
  final adminPassword = "zsjc fhas cmqp kgzt";

  final List<String> classDetails = [
    "one", "two", "three", "four", "five",
    "six", "seven", "eight", "nine", "ten", "admission"
  ];
}

