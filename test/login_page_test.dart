
import 'package:flutter/material.dart';
import 'package:flutter_application_2/presentation/login_page.dart';
import 'package:flutter_test/flutter_test.dart';



void main() {

  testWidgets("widget should have a textfield", (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    final textFieldFinder = find.byType(TextField);

    expect(textFieldFinder, findsOneWidget);
  });

  testWidgets("widget should have a button", (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    final button = find.byType(TextButton);

    expect(button, findsOneWidget);
  });

    testWidgets("widget's textfield should receive a string", (WidgetTester tester) async{
    await tester.pumpWidget(MaterialApp(
      home: LoginPage(),
    ));

    final textFieldFinder = find.byType(TextField);
    await tester.enterText(textFieldFinder,"helyezerteofilo-cit");
    
    expect(find.text("helyezerteofilo-cit"), findsOneWidget);
  });

}