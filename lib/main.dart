import 'package:dilomovie/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'models/mymodel.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // https://pastebin.com/Mbr7rzpE

  @override
  Widget build(BuildContext context) {
    List<Model> myData = [Model("Spiderman 1", "Hellow spiderman 1"),
      Model("Spiderman 2", "Hellow spiderman 2"),
      Model("Spiderman 3", "Hellow spiderman 3"),
      Model("Spiderman 4", "Hellow spiderman 4"),
      Model("Spiderman 5", "Hellow spiderman 5"),
      Model("Spiderman 6", "Hellow spiderman 6"),
      Model("Spiderman 7", "Hellow spiderman 7")];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: myData.length,
        itemBuilder: (BuildContext context, int position) {
          var data = myData[position];

          return GestureDetector(
            child: _createList(data),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return Detail(data: data);
                }
              ));
            }
          );
        }
      )
    );
  }

  Widget _createList(Model data) {
    return Container(
      margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 10.0, left: 10.0),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.blue
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 120.0,
            height: 180.0,
            child: Image.asset('assets/images/spiderman_movie.jpg',
            fit: BoxFit.cover)
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(data.title),
                Text(data.description)
              ],
            )
          )
        ],
      ),
    );
  }
}
