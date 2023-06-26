# Book App

This app is similar to good reads.

This is a simple book management application built using Flutter. It uses Firebase for both authentication and database services.

## Features

This application provides the following screens:

1. **Login/Signup Screen**: This is the initial screen, where users can either log in using their existing account or sign up with a new account. It uses Firebase Authentication for the email/password authentication process.

2. **Book List Screen**: Upon successful login, the user will be navigated to this screen, where they can see a list of all the books they've added. Each entry displays the book's title, author, and a thumbnail of the book's cover. The data for these books are fetched from Firestore. There's also a button on this screen that takes the user to the screen for adding a new book.

3. **Add/Edit Book Screen**: This screen is used to either add a new book or edit an existing one. Users can enter the book's title, author, genre, and a link to an image of the book's cover. When the user saves the book, it gets added to (or updated in) Firestore. The user is then navigated back to the Book List Screen.

4. **Book Details Screen**: From the Book List Screen, when a user taps on a book, they are navigated to this screen where they can view the full details of the book. This screen also provides options to either edit or delete the book.

## Technologies Used

- **Flutter** 
- **Dart** 
- **Firebase Authentication**: Used for handling user authentication.
- **Firestore**: A flexible, scalable database for mobile, web, and server development from Firebase.

## Development Environment

- **Android Studio**: Google's Android operating system

## Usage

Open the project in Android Studio or any other IDE you prefer. Use the `flutter run` command in the terminal to run the app on your emulator or device. (Also, install flutter first)
