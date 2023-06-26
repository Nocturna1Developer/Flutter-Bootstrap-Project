import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Define a StatefulWidget for the add book page
class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  // Define a CollectionReference to the 'books' collection in Firestore
  final CollectionReference books = FirebaseFirestore.instance.collection('books');

  // Define a GlobalKey to uniquely identify the Form widget and allow for validation
  final _formKey = GlobalKey<FormState>();

  // Define variables to hold the input values
  String _title = '';
  String _author = '';
  String _genre = '';
  String _imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Book"), // The title of the AppBar
      ),
      body: Form(
        key: _formKey, // Assign the GlobalKey to the Form
        child: Padding(
          padding: const EdgeInsets.all(8.0), // Add padding to all sides
          child: ListView(
            children: <Widget>[
              // TextFormFields for each input, with validation and onSaved functions
              TextFormField(
                decoration: InputDecoration(labelText: 'Book Title'),
                validator: (value) { // Check that a value has been provided
                  if (value == null || value.isEmpty) {
                    return 'Please enter book title';
                  }
                  return null;
                },
                onSaved: (value) { // Save the input value to _title
                  _title = value!;
                },
              ),

              // An ElevatedButton to save the book
              ElevatedButton(
                onPressed: () {
                  // Check if all validators return null, then save the input values
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save data to Firestore
                    books.add({
                      'title': _title,
                      'author': _author,
                      'genre': _genre,
                      'imageUrl': _imageUrl,
                    }).then((value) {
                      Navigator.pop(context); // Pop the page from the navigation stack
                    }).catchError((error) {
                      print("Failed to add book: $error");
                    });
                  }
                },
                child: Text('Save Book'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}