import 'package:flutter/foundation.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import '../../utils/utils.dart';

Future<void> sendEmail(String recipienct_mail, String id, String pass) async {
  final util = Utils();
  String username = util.adminEmail;
  String password = util.adminPassword;

  // SMTP Server setup
  final smtpServer = gmail(username, password);

  // Create the email
  final message = Message()
    ..from = Address(username, 'Smart Education App')
    ..recipients.add(recipienct_mail)
    ..subject = 'Welcome to Smart Education System'
    ..text = 'This is an automated email message. Please Note your username & password for login our app.\nUSERNAME: $id \nPASSWORD: $pass';

  try {
    final sendReport = await send(message, smtpServer);
    if (kDebugMode) {
      print('Message sent: ${sendReport.toString()}');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Message not sent. Error: $e');
    }
  }
}