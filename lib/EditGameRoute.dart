import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Game.dart';
import 'database_helper.dart';

class EditGameRoute extends StatefulWidget {
  final Game game;

  @override
  _EditGameRouteState createState() => _EditGameRouteState();

  EditGameRoute({Key key, @required this.game}) : super(key: key);
}

class _EditGameRouteState extends State<EditGameRoute> {
  final _formKey = GlobalKey<FormState>();

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
                      hintText: 'Name'
                    ),
                    validator: (value) {
                      if(value.isEmpty) {
                        return 'Please enter some text.';
                      } return null;
                    },
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
                  )
                ],
              ),
            ),
          ),
          FlatButton(
            child: Text('Delete'),
            color: Colors.red,
            textColor: Colors.white,
            onPressed: () async {
              int rowsAffected = await DatabaseHelper.instance.delete(widget.game.id);
              Navigator.pop(context);
            },
          ),
          Text(widget.game.id.toString()),
          Text(widget.game.name),
          Text(widget.game.rating.toString()),
        ],
      ),
      appBar: AppBar(
        title: Text('Edit Game'),
      ),
    );
  }
}
