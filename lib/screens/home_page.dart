import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference books = FirebaseFirestore.instance.collection('books');

    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: books.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return new ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return new ListTile(
                title: new Text(data['title']),
                subtitle: new Text(data['author']),
                leading: (data['imageUrl'] != null)
                    ? Image.network(data['imageUrl'])
                    : null,
              );
            }).toList(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to AddBookPage when floating action button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddBookPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class AddBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Book"),
      ),
      // Add your AddBookPage implementation here
    );
  }
}
