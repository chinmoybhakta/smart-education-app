import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:smart_edu_again/main.dart' as app;
import 'package:smart_edu_again/src/feature/common_widget/smart_textfield.dart';

void main() {
  //SETUP
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Invalid login attempts', (WidgetTester tester) async {
    app.main();
    // WAIT
    await tester.pumpAndSettle(const Duration(seconds: 15));
    // ARRANGE
    final usernameField = find.byKey(const Key('usernameField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.text('Log in');
    //ACT
    for(int i = 0; i < 5; i++) {
      // WAIT
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 2));
      //ACT
      await tester.enterText(usernameField, 'chini baba');
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.enterText(passwordField, '1234');
      await tester.pumpAndSettle(const Duration(seconds: 1));
      await tester.tap(loginButton);
      // WAIT
      await tester.pumpAndSettle(const Duration(seconds: 5));
      // ARRANGE
      final invalidSnack = find.text("Invalid Credentials");
      debugPrint('Invalid SnackBar count: ${tester.widgetList(invalidSnack).length}');
      // EXPECT
      expect(invalidSnack, findsOneWidget);
      // WAIT
      await tester.pumpAndSettle(const Duration(seconds: 1));
      // ARRANGE
      await tester.enterText(usernameField, '');
      await tester.enterText(passwordField, '');
    }
  });

  testWidgets('Successful admin login and logout', (WidgetTester tester) async {
    app.main();
    // WAIT
    await tester.pumpAndSettle(const Duration(seconds: 15));
    // ARRANGE
    final usernameField = find.byKey(const Key('usernameField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.text('Log in');
    // ACT
    await tester.enterText(usernameField, 'chini');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.enterText(passwordField, 'sugar007');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(loginButton);
    // WAIT
    await tester.pumpAndSettle(const Duration(seconds: 5));
    // ARRANGE
    final menuButton = find.byKey(const Key('Drawer Menu'));
    // ACT
    await tester.tap(menuButton);
    await tester.pumpAndSettle();
    // EXPECT
    expect(find.text('Hello Teacher!'), findsOneWidget);
    // ARRANGE
    final logoutButton = find.text('Log Out');
    // ACT
    await tester.tap(logoutButton);
  });

  testWidgets('Successful user login and logout', (WidgetTester tester) async {
    app.main();
    // WAIT
    await tester.pumpAndSettle(const Duration(seconds: 15));
    // ARRANGE
    final usernameField = find.byKey(const Key('usernameField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.text('Log in');
    // ACT
    await tester.enterText(usernameField, 'CHI003');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.enterText(passwordField, 'bVbcgn1x');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(loginButton);
    // WAIT
    await tester.pumpAndSettle(const Duration(seconds: 5));
    // ARRANGE
    final menuButton = find.byKey(const Key('Drawer Menu'));
    // ACT
    await tester.tap(menuButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    // ARRANGE
    final logoutButton = find.text('Log Out');
    // ACT
    await tester.tap(logoutButton);
  });

  testWidgets('Successful student sign up', (WidgetTester tester) async {
    app.main();
    // WAIT
    await tester.pumpAndSettle(const Duration(seconds: 15));
    // ARRANGE
    final usernameField = find.byKey(const Key('usernameField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.text('Log in');
    // ACT
    await tester.enterText(usernameField, 'chini');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.enterText(passwordField, 'sugar007');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(loginButton);
    // WAIT
    await tester.pumpAndSettle(const Duration(seconds: 5));
    // ARRANGE
    final menuButton = find.byKey(const Key('Drawer Menu'));
    // ACT
    await tester.tap(menuButton);
    // WAIT
    await tester.pumpAndSettle(const Duration(seconds: 5));
    // ARRANGE
    final signupButton = find.text('New Student Sign up');
    // ACT
    await tester.tap(signupButton);
    // WAIT
    await tester.pumpAndSettle(const Duration(seconds: 5));
    // EXPECT
    expect(find.text('NEW STUDENT FORM'), findsOneWidget);
    // ARRANGE
    await tester.enterText(find.byKey(const Key('Name')), 'John Doe');

    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byKey(const Key('Date of Birth')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.enterText(find.byKey(const Key('E-mail')), 'chinmoybhakta5@gmail.com');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.enterText(find.byKey(const Key('Student Contact')), '01711111111');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.enterText(find.byKey(const Key('Guardian Name')), 'Jane Doe');
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byKey(const Key('Guardian Relation')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text('Father'));
    await tester.pumpAndSettle(const Duration(seconds: 1));

    await tester.enterText(find.byKey(const Key('Guardian Contact')), '01722222222');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.enterText(find.byKey(const Key('Hobby')), 'Reading');
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Ensure screen visibility
    await tester.ensureVisible(find.byKey(const Key('Nationality')));

    await tester.tap(find.byKey(const Key('Nationality')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text('Bangladeshi'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byKey(const Key('Gender')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text('Male'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byKey(const Key('Religion')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text('Islam'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byKey(const Key('Selected Class')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text('one'));
    await tester.pumpAndSettle(const Duration(seconds: 5));

    await tester.tap(find.byKey(const Key('Favourite Subject')));
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(find.text('Physical Test'));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // ACT
    await tester.tap(menuButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    // ARRANGE
    final statusButton = find.text('Student Status');
    // ACT
    await tester.tap(statusButton);
    await tester.pumpAndSettle(const Duration(seconds: 10));
    // EXPECT
    expect(find.text('John Doe'), findsOneWidget);
  });

  testWidgets('Successful student delete', (WidgetTester tester) async {
    app.main();
    // WAIT
    await tester.pumpAndSettle(const Duration(seconds: 15));
    // ARRANGE
    final usernameField = find.byKey(const Key('usernameField'));
    final passwordField = find.byKey(const Key('passwordField'));
    final loginButton = find.text('Log in');
    await tester.pumpAndSettle(const Duration(seconds: 2));
    // ACT
    await tester.enterText(usernameField, 'chini');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.enterText(passwordField, 'sugar007');
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(loginButton);
    // WAIT
    await tester.pumpAndSettle(const Duration(seconds: 5));
    // ARRANGE
    final studentNameFinder = find.text('John Doe');
    expect(studentNameFinder, findsOneWidget);

    // Find the Delete button in the same row as the student name
    final allDeleteButtons = find.byIcon(Icons.delete);
    final deleteButton = allDeleteButtons.last;

    // Find the horizontal scrollable around the DataTable (adjust type if different)
    final horizontalScroll = find.byType(SingleChildScrollView).first;
    await tester.pumpAndSettle(const Duration(seconds: 1));
    // Scroll horizontally until deleteButton is visible in the viewport
    await tester.dragUntilVisible(
      deleteButton,          // Widget you want to make visible
      horizontalScroll,      // Scrollable widget
      const Offset(-300, 0), // Scroll left by 300 pixels;
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));

    expect(deleteButton, findsOneWidget);

    // Tap the delete icon button
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await tester.tap(deleteButton);
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Confirm in the AlertDialog
    final yesButton = find.text('Yes');
    expect(yesButton, findsOneWidget);
    await tester.pumpAndSettle(const Duration(seconds: 2));
    await tester.tap(yesButton);
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // Scroll horizontally until deleteButton is visible in the viewport
    await tester.drag(
      horizontalScroll,      // Scrollable widget
      const Offset(300, 0), // Scroll right by 300 pixels;
    );
    await tester.pumpAndSettle(const Duration(seconds: 1));

    // Verify the student is no longer in the list
    expect(find.text('John Doe'), findsNothing);
  });
}
