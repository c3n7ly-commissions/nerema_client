import 'package:flutter/material.dart';
import 'pages/auth/sign_in.dart';
import 'pages/auth/password_reset.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nerema',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/sign-in',
      routes: {
        '/sign-in': (context) => SignInScreen(),
        '/forgot-password': (context) => PasswordResetScreen(),
      },
    );
  }
}
