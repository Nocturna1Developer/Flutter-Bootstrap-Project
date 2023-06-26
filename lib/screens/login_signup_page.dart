import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_simple_app/screens/home_page.dart';

// Enum to represent the authentication mode
enum AuthMode { LOGIN, SIGNUP }

// LoginSignupPage is a StatefulWidget. This allows it to maintain state that can change over the lifetime of the widget.
class LoginSignupPage extends StatefulWidget {
  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

// _LoginSignupPageState is the state associated with LoginSignupPage widget.
class _LoginSignupPageState extends State<LoginSignupPage> {
  final _auth = FirebaseAuth.instance; // instance of the Firebase Auth package
  final _emailController = TextEditingController(); // controller for the email input field
  final _passwordController = TextEditingController(); // controller for the password input field
  AuthMode _authMode = AuthMode.LOGIN; // state to keep track of current auth mode, default is login

  @override
  Widget build(BuildContext context) {
    // Scaffold is a layout structure where you can material-design visual layout structure
    return Scaffold(
      appBar: AppBar(
        title: Text(_authMode == AuthMode.LOGIN ? "Login" : "Signup"), // change title based on the auth mode
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // padding around the Column widget
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // align the children widgets to the center of the column
          children: [
            // TextField widget for user to enter email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"), // label for the text field
            ),
            // TextField widget for user to enter password, text is obscured
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20.0), // space between widgets
            // show Login or Signup button based on the auth mode
            if (_authMode == AuthMode.LOGIN)
              ElevatedButton(
                onPressed: () => _login(),
                child: Text("Login"),
              ),
            if (_authMode == AuthMode.SIGNUP)
              ElevatedButton(
                onPressed: () => _signup(),
                child: Text("Sign up"),
              ),
            // switch between Login and Signup
            TextButton(
              child: Text(_authMode == AuthMode.LOGIN
                  ? 'Create Account'
                  : 'Already have an account? Login'),
              onPressed: _switchAuthMode,
            ),
          ],
        ),
      ),
    );
  }

  // Switches between login and signup mode
  void _switchAuthMode() {
    setState(() {
      _authMode =
      _authMode == AuthMode.LOGIN ? AuthMode.SIGNUP : AuthMode.LOGIN;
    });
  }

  // Function to log in the user using Firebase Auth
  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navigate to Home Page after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {

    }
  }

  // Function to sign up the user using Firebase Auth
  void _signup() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navigate to Home Page after successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle exceptions as necessary
    }
  }
}