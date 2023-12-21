import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as pth;

import 'ThirdScreen.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  List userData = [];
  late Database database;

  @override
  void initState() {
    super.initState();
    fetchData();
    initDatabase();
  }

  Future<void> fetchData() async {
    var response = await http.get(Uri.parse('https://randomuser.me/api/?results=5'));
    setState(() {
      userData = jsonDecode(response.body)['results'];
    });
  }

  initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = pth.join(databasesPath, 'user.db');
    database = await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE IF NOT EXISTS users(name TEXT, email TEXT)");
  }

  Future<void> insertUser(user) async {
    await database.insert(
      'users',
      user,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen'),
      ),
      body: ListView.builder(
        itemCount: userData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(userData[index]['name']['first']),
            subtitle: Text(userData[index]['email']),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  child: Text('Fetch More Users'),
                  onPressed: () {
                    fetchData();
                  },
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  child: Text('Store User'),
                  onPressed: () {
                    insertUser({
                      'name': userData[index]['name']['first'],
                      'email': userData[index]['email'],
                    });
                  },
                ),
              ],
            ),
          );
        },
      ),
      persistentFooterButtons: [
        ElevatedButton(
          child: Text('Go to Third Screen'),
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(opacity: animation, child: ThirdScreen(database: database)),
                transitionDuration: Duration(seconds: 2),
              ),
            );
          },
        ),
      ],
    );
  }
}
