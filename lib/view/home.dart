import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_app/localization/demo_localizations.dart';
import 'package:flutter_app/view/side_drawer.dart';
import 'package:image_picker/image_picker.dart';

class Home extends StatefulWidget {
  @override
  createState() => new HomeState();
}

class HomeState extends State<Home> with WidgetsBindingObserver {
  File _image;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: new SideDrawer(),
        appBar: new AppBar(title: new Text(DemoLocalizations.of(context).app)),
        body: new Center(
            child: new Column(children: <Widget>[
          new Center(
              child: _image == null
                  ? new Text("no image")
                  : new Image.file(_image, width: 200.0, height: 200.0)),
          new Center(
              child: new RaisedButton.icon(
                  icon: Icon(Icons.add),
                  label: new Text("Button"),
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  }))
        ])));
  }

  Future getImage(ImageSource imageSource) async {
    var image = await ImagePicker.pickImage(source: imageSource);
    setState(() {
      _image = image;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.inactive:
        print('Lifecycle --> inactive');
        break;
      case AppLifecycleState.paused:
        print('Lifecycle --> paused');
        break;
      case AppLifecycleState.resumed:
        print('Lifecycle --> resumed');
        break;
      case AppLifecycleState.suspending:
        print('Lifecycle --> suspending');
        break;
    }
  }
}
