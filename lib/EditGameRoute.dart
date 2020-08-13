import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Game.dart';
import 'database_helper.dart';

class EditGameRoute extends StatefulWidget {
  @override
  _EditGameRouteState createState() => _EditGameRouteState();
}

class _EditGameRouteState extends State<EditGameRoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FlatButton(
            child: Text('Delete'),
            color: Colors.red,
            textColor: Colors.white,
            onPressed: (){},
          ),
        ],
      ),
      appBar: AppBar(),
    );
  }
}
