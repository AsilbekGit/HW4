# Flutter App

This is a simple Flutter app that consists of three screens: a welcome screen, a second screen that fetches and stores user data, and a third screen that displays the stored user data.

## Welcome Screen

The welcome screen displays a welcome message to the user. It includes an icon in the app bar and an image in the body. There's also a button that navigates to the second screen.

## Second Screen

The second screen fetches user data from an API and displays it in a list. Each list item includes two buttons: one to fetch more user data from the API, and another to store the current user's data into a SQLite database. There's also a button that navigates to the third screen with a fade transition animation.

## Third Screen

The third screen reads the user data from the SQLite database and displays it in a list. It includes a back button in the app bar that navigates back to the second screen.

## Getting Started

To get started with this project, clone the repository and run `flutter run` in the root directory.

## Dependencies

This project uses the following packages:
- `http`: for fetching user data from an API.
- `sqflite`: for storing and reading user data in a SQLite database.
- `path`: for getting the path to the SQLite database.

Make sure to run `flutter pub get` to fetch the necessary dependencies.


