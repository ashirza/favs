import 'package:favs/database_helper.dart';
import 'package:flutter/material.dart';
import 'AddGameRoute.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: Container(
        child: Column(
          children: [
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
            Expanded(
              child: FutureBuilder(
                future: DatabaseHelper.instance.queryAll(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, int position) {
                        final item = snapshot.data[position];
                        return Card(
                          child: ListTile(
                            title: Text(item['name']),
                            subtitle: Text(item['rating'].toString()),
                            trailing: Icon(Icons.videogame_asset),
                          ),
                        );
                      },
                    );
                  } else return Text('Loading..');
                  },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => AddGameRoute()),
          ).then((value) {setState(() {
          });});
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
    );
  }
}

