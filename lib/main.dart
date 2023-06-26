// Import necessary Flutter and Dart packages
import 'package:flutter/material.dart';
import 'screens/login_signup_page.dart'; // Import the login/signup page

// The starting point of the application
void main() {
  runApp(const MyApp());
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo', // The title of your application
      theme: ThemeData(
        // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginSignupPage(), // Set the home page of the application to LoginSignupPage
    );
  }
}
