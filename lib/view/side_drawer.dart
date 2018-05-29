import 'package:flutter/material.dart';
import 'package:flutter_app/view/moive_list.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SideDrawer extends StatefulWidget {
  @override
  _SideDrawerState createState() => new _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: new ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          new DrawerHeader(
              child: new Text('Drawer Header'),
              decoration: new BoxDecoration(color: Colors.blue)),
          new ListTile(
              title: new Text('close'),
              onTap: () {
                Navigator.pop(context);
              }),
          new ListTile(
              title: new Text('fetch movie'),
              onTap: () {
                fetchMovie(context);
              })
        ],
      ),
    );
  }

  void fetchMovie(BuildContext context) async {
    final _jsonDecoder = new JsonDecoder();
    final url = "https://api.douban.com/v2/movie/top250?start=0&count=10";
    print(url);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      print(response.statusCode);
      Map<String, dynamic> body = _jsonDecoder.convert(response.body);
      List subjects = body['subjects'];
      _pushMovie(context, subjects);
    }
  }

  void _pushMovie(BuildContext context, List subject) {
    Navigator.pop(context);
    Navigator.push(context, new MaterialPageRoute(builder: (context) {
      return new MovieList(subject);
    }));
  }
}
