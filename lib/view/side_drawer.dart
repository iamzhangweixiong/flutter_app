import 'package:flutter/material.dart';
import 'package:flutter_app/view/moive_list.dart';

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
                Navigator.pop(context);
                Navigator.push(context, new MaterialPageRoute(builder: (context) {
                  return new MovieList();
                }));
              })
        ],
      ),
    );
  }
}
