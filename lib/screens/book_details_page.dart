import 'package:flutter/material.dart';

class BookDetailsPage extends StatelessWidget {
  // The book details and document ID are required parameters
  final Map<String, dynamic> book;
  final String docId;

  // Initialize with required parameters
  BookDetailsPage({Key? key, required this.book, required this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Return a scaffold, which implements the basic material design visual layout structure
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']), // Set the title of the AppBar to the book title
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0), // Add padding to all sides
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align children to the start of the column
          children: <Widget>[
            Text("Author: " + book['author']), // Display the author of the book
            Text("Genre: " + book['genre']), // Display the genre of the book
            book['imageUrl'] is String
                ? Image.network(book['imageUrl']) // If an image URL is available, display the image
                : Container(), // Else, display an empty container
            // TODO: Here, you can add Edit and Delete buttons if needed, I figured it would out of the scope for this project
          ],
        ),
      ),
    );
  }
}
