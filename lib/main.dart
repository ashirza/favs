import 'package:favs/database_helper.dart';
import 'package:flutter/material.dart';
import 'AddGameRoute.dart';
import 'EditGameRoute.dart';
import 'Game.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      theme: ThemeData.dark(),
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
            Expanded(
              child: FutureBuilder(
                future: DatabaseHelper.instance.queryAll(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, int position) {
                        final item = snapshot.data[position];
                        Game game = new Game(id: item['id'], name: item['name'], rating: item['rating']);
                        return Card(
                          child: ListTile(
                            title: Text(item['name']),
                            subtitle: Text(item['rating'].toString()),
                            trailing: Icon(Icons.videogame_asset),
                            onLongPress: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) => EditGameRoute(game: game,)),
                              ).then((value) => {setState(() {
                              })});
                            },
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
      ),
    );
  }
}

