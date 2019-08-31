import 'dart:convert';

import 'package:dilomovie/detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'models/mymodel.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<Model> getMeals() async {
    final Response response = await http.get('https://www.themealdb.com/api/json/v1/1/filter.php?c=Seafood');

    if (response.statusCode == 200) {
      return Model.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal mendapatkan data');
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<Model>(
        future: getMeals(),
        builder: (context, snapshoot){
          if(!snapshoot.hasData) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Text("loading")
                ],
              ),
            );
          } else if(snapshoot.hasError) {
            return Text("{$snapshoot.error}");
          }

          return ListView.builder(
              itemCount: snapshoot.data.meals.length,
              itemBuilder: (BuildContext context, int position) {
                var data = snapshoot.data.meals[position];

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
          );
        }
      )
    );

  Widget _createList(Meal data) => Container(
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
            child: Image.network(data.strMealThumb,
            fit: BoxFit.cover)
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(data.strMeal),
//                Text(data.description)
              ],
            )
          )
        ],
      ),
    );
}
