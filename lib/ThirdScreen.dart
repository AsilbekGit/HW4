import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class ThirdScreen extends StatefulWidget {
  final Database database;

  ThirdScreen({required this.database});

  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  List userData = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Map> list = await widget.database.rawQuery('SELECT * FROM users');
    setState(() {
      userData = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Third Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        itemCount: userData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(userData[index]['name']),
            subtitle: Text(userData[index]['email']),
          );
        },
      ),
    );
  }
}
