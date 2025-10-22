import 'package:ykos_bbq_chicken/main.dart' as app;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:ykos_bbq_chicken/Pages/login/login_page.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets("User can login", (WidgetTester tester) async {
    app.main();
    await tester.pumpWidget(MaterialApp(home: LoginPage(),));

  // 2️⃣ Prüfen, ob bestimmte Widgets sichtbar sind
    expect(find.text('Log In'), findsWidgets);
    expect(find.text('Sign Up'), findsOneWidget);
    expect(find.text('E-mail'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);
  });
}