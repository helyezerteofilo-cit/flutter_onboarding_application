
import 'package:flutter/material.dart';
import 'package:flutter_application_2/login_page.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {

  testWidgets("widget should have a textfield and a button", (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    final textFieldFinder = find.byType(TextField);
    final button = find.text("Access Info");

    expect(textFieldFinder, findsOneWidget);
    expect(button, findsOneWidget);

  });

    testWidgets("widget should receive a string", (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    final textFieldFinder = find.byType(TextField);
    await tester.enterText(textFieldFinder,"helyezerteofilo-cit");
    final username = find.text("helyezerteofilo-cit");
    expect(username, findsOneWidget);

  });

}