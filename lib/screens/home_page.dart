import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_simple_app/screens/add_book_page.dart';
import 'package:flutter_simple_app/screens/book_details_page.dart';

// HomePage is a StatelessWidget. This means it describes part of the user interface which can't change over time.
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get reference to 'books' collection in Firestore (i created this on the firebase website manually as a test)
    CollectionReference books = FirebaseFirestore.instance.collection('books');

    return Scaffold(
      appBar: AppBar(
        title: Text("Home - MyBooks!"), // The title of your AppBar
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: books.snapshots(), // Stream of snapshots from 'books' collection
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          // If the snapshot has an error, return a Text widget with a message
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          // While the snapshot connection is waiting, return a loading Text widget
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          // When data is available, return a ListView widget
          return new ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              // Get data from document snapshot
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;

              // For each document in the snapshot, build a Card widget
              return Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: new Text(data['title'] is String ? data['title'] : "N/A"), // Display the book title or "N/A" if not available
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(data['author'] is String ? "Author: " + data['author'] : "Author: N/A"),
                          new Text(data['genre'] is String ? "Genre: " + data['genre'] : "Genre: N/A"),
                        ],
                      ),
                      leading: (data['imageUrl'] is String)
                          ? Image.network(data['imageUrl']) // If an image URL is available, display the image
                          : null,
                    ),
                    // Button to navigate to the BookDetailsPage for the current book
                    TextButton(
                      child: Text("Show Details"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BookDetailsPage(book: data, docId: document.id),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            }).toList(), // Convert map to list
          );
        },
      ),
      // Button to navigate to the AddBookPage
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookPage()),
          );
        },
        child: Icon(Icons.add), // Button icon
        backgroundColor: Colors.green, // Button color
      ),
    );
  }
}