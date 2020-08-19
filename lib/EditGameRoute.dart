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
                    initialValue: widget.game.name,
                    decoration: InputDecoration(
                      hintText: widget.game.name,
                    ),
                    validator: (value) {
                      if(value.isEmpty) {
                        return 'Please enter some text.';
                      } return null;
                    },
                    onSaved: (val) => setState(() => widget.game.name = val),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: widget.game.rating.toString(),
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: widget.game.rating.toString(),
                    ),
                    validator: (value) {
                      if(value.isEmpty) {
                        return 'Please enter some text.';
                      } return null;
                    },
                    onSaved: (val) => setState(() => widget.game.rating = int.parse(val)),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: widget.game.url,
                    ),
                    validator: (value) {
                      if(value.isEmpty) {
                        return 'Please enter a URL.';
                      } return null;
                    },
                    onSaved: (val) => setState(() => widget.game.url = val),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: Text('Edit Game'),
      ),
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () async {
                if(_formKey.currentState.validate()) {
                  print('valid!');
                  _formKey.currentState.save();
                  int i = await DatabaseHelper.instance.update({
                    DatabaseHelper.columnId : widget.game.id,
                    DatabaseHelper.columnName : widget.game.name,
                    DatabaseHelper.columnRating: widget.game.rating,
                    DatabaseHelper.columnUrl: widget.game.url,
                  });
                  Navigator.pop(context);
                }
              },
              backgroundColor: Colors.green,
              child: Icon(Icons.done),
              heroTag: null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: () async {
                  int rowsAffected = await DatabaseHelper.instance.delete(widget.game.id);
                  Navigator.pop(context);
                },
                child: Icon(Icons.delete),
                backgroundColor: Colors.red,
                heroTag: null,
              ),
            ),
          )
        ],
      ),
    );
  }
}
