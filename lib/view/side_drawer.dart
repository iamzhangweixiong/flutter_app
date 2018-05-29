import 'package:flutter/material.dart';
import 'package:flutter_app/localization/demo_localizations.dart';
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
              child: new Center(child: new Text("Header")),
              decoration: new BoxDecoration(color: Colors.blue)),
          new ListTile(
              title: new Text(DemoLocalizations.of(context).movieTitle),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    new MaterialPageRoute(builder: (context) {
                  return new MovieList();
                }));
              }),
          new ListTile(
              title: new Text(DemoLocalizations.of(context).closeItem),
              onTap: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
