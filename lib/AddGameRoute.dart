import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Game.dart';
import 'database_helper.dart';

class AddGameRoute extends StatefulWidget {
  @override
  _AddGameRouteState createState() => _AddGameRouteState();
}

class _AddGameRouteState extends State<AddGameRoute> {
  final _formKey = GlobalKey<FormState>();
  final _game = Game();



  //TODO: Make this form look nice
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
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
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText: 'Rating',
                      ),
                      validator: (value) {
                        if(value.isEmpty) {
                          return 'Please enter some text.';
                        } return null;
                      },
                      onSaved: (val) => setState(() => _game.rating = int.parse(val)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      appBar: AppBar(
        title: Text('Add Game'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          if(_formKey.currentState.validate()) {
            print('valid!');
            _formKey.currentState.save();
            int i = await DatabaseHelper.instance.insert({
              DatabaseHelper.columnName : _game.name,
              DatabaseHelper.columnRating : _game.rating,
            });
            Navigator.pop(context);
          }
        },
        backgroundColor: Colors.green,
        child: Icon(Icons.done),
      ),
      );
  }
}