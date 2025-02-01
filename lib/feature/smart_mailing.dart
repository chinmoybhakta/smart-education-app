import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

Future<void> sendEmail(String recipienct_mail, String id, String pass) async {
  String username = 'cbhakta12@niter.edu.bd'; // Sender's email
  String password = 'andc toul tmpm evuy'; // Sender's email password

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
    print('Message sent: ${sendReport.toString()}');
  } catch (e) {
    print('Message not sent. Error: $e');
  }
}