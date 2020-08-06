import 'package:favs/database_helper.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

import 'Game.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: myHome()
    );
  }
}

class myHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Center(
        child: Column(
          children: [
            Text('Favourite Games'),
            Text('TLOU2 : 10'),
            Text('Zelda : 10'),
            FlatButton(
              onPressed: () async {
                int i = await DatabaseHelper.instance.insert({
                  DatabaseHelper.columnName : 'Zelda',
                  DatabaseHelper.columnRating : 10,
                });
                print('the inserted id is $i' );
              },
              child: Text('Insert'),
            ),
            FlatButton(
              onPressed: () async {
                List<Map<String, dynamic>> queryRows = await DatabaseHelper.instance.queryAll();
                print(queryRows);
              },
              child: Text('Query'),
            ),
            FlatButton(
              onPressed: () async {
                int updatedId = await DatabaseHelper.instance.update({
                  DatabaseHelper.columnId : 2,
                  DatabaseHelper.columnName : 'TLOU',
                  DatabaseHelper.columnRating : 10,
                });
                print(updatedId);
              },
              child: Text('Update'),
            ),
            FlatButton(
              onPressed: () async {
                int rowsAffected = await DatabaseHelper.instance.delete(3);
                print(rowsAffected);
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddGameRoute()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

class AddGameRoute extends StatefulWidget {
  @override
  _AddGameRouteState createState() => _AddGameRouteState();
}

class _AddGameRouteState extends State<AddGameRoute> {
  final _formKey = GlobalKey<FormState>();
  final _game = Game();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                    validator: (value) {
                      if(value.isEmpty) {
                        return 'Please enter some text.';
                      } return null;
                    },
                    onSaved: (val) => setState(() => _game.name = val),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
                    validator: (value) {
                      if(value.isEmpty) {
                        return 'Please enter some text.';
                      } return null;
                    },
                    onSaved: (val) => setState(() => _game.rating = int.parse(val)),
                  ),
                  RaisedButton(
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        print('valid!');
                        _formKey.currentState.save();
                        int i = await DatabaseHelper.instance.insert({
                          DatabaseHelper.columnName : _game.name,
                          DatabaseHelper.columnRating : _game.rating,
                        });
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
            Center(
              child: RaisedButton(
                child: Text('Go back'),
                onPressed: () {Navigator.pop(context);},
              ),
            ),
          ],
        ),
      );
  }
}
