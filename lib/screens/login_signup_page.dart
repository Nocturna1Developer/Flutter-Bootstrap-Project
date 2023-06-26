import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_simple_app/screens/home_page.dart';

enum AuthMode { LOGIN, SIGNUP }

class LoginSignupPage extends StatefulWidget {
  @override
  _LoginSignupPageState createState() => _LoginSignupPageState();
}

class _LoginSignupPageState extends State<LoginSignupPage> {
  final _auth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  AuthMode _authMode = AuthMode.LOGIN;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_authMode == AuthMode.LOGIN ? "Login" : "Signup"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
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

  void _switchAuthMode() {
    setState(() {
      _authMode =
      _authMode == AuthMode.LOGIN ? AuthMode.SIGNUP : AuthMode.LOGIN;
    });
  }

  void _login() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle exceptions as necessary
    }
  }

  void _signup() async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle exceptions as necessary
    }
  }
}
