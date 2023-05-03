import 'package:flutter/material.dart';
import 'package:flutter_application_2/presentation/login_page.dart';

void main() async{
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        
        home: LoginPage(),
      );
  }
}

