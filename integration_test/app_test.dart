import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:smart_edu_again/main.dart' as app;

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
      await tester.enterText(passwordField, '1234');
      await tester.tap(loginButton);
      // WAIT
      await tester.pump();
      await tester.pumpAndSettle(const Duration(seconds: 1));
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
    await tester.enterText(passwordField, 'sugar007');
    await tester.tap(loginButton);
    // WAIT
    await tester.pumpAndSettle(const Duration(seconds: 1));
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
    await tester.enterText(usernameField, 'ABI000');
    await tester.enterText(passwordField, '123456');
    await tester.tap(loginButton);
    // WAIT
    await tester.pumpAndSettle(const Duration(seconds: 1));
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
}
