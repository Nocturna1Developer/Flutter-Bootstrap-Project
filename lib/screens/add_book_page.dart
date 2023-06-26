import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final CollectionReference books = FirebaseFirestore.instance.collection('books');
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _author = '';
  String _genre = '';
  String _imageUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Book"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Book Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter book title';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Author'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter author';
                  }
                  return null;
                },
                onSaved: (value) {
                  _author = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Genre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter genre';
                  }
                  return null;
                },
                onSaved: (value) {
                  _genre = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Image URL'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter image URL';
                  }
                  return null;
                },
                onSaved: (value) {
                  _imageUrl = value!;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Save data to Firestore
                    books.add({
                      'title': _title,
                      'author': _author,
                      'genre': _genre,
                      'imageUrl': _imageUrl,
                    }).then((value) {
                      Navigator.pop(context);
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
