import 'package:flutter/material.dart';
import 'screens/login_signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future<void> main() async {
  // This line ensures that all Flutter widgets have a chance to instantiate
  WidgetsFlutterBinding.ensureInitialized();

  // This line initializes Firebase in the app
  await Firebase.initializeApp();

  // This line is offloads the computationally heavy operation in a background.
  final result = await compute(heavyComputation, "Flutter");
  print(result);

  // This line builds and runs the application widget tree
  runApp(const MyApp());
}

// Test function for heavy operations
String heavyComputation(String value) {
  // A place holder for heavy operations
  return "Completed";
}

// This widget is the root of your application.
class MyApp extends StatelessWidget {
  // A constructor may have optional parameters. Key is one of them used by Flutter.
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Reads!', // The title of application
      theme: ThemeData(
        // Theme of application
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginSignupPage(), // Set the home page of the application to LoginSignupPage
    );
  }
}