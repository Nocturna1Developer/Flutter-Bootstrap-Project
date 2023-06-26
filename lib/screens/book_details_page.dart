import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  final Map<String, dynamic> book;
  final String docId;

  BookDetailsPage({Key? key, required this.book, required this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Author: " + book['author']),
            Text("Genre: " + book['genre']),
            book['imageUrl'] is String
                ? Image.network(book['imageUrl'])
                : Container(),
            // Add your Edit and Delete buttons here
          ],
        ),
      ),
    );
  }
}
