import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter_app/view/side_drawer.dart';

class MainPage extends StatefulWidget {
  @override
  createState() => new MainPageState();
}

class MainPageState extends State<MainPage> with WidgetsBindingObserver {
  final _suggestions = <WordPair>[];
  final _saved = new Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: new SideDrawer(),
      appBar: new AppBar(title: new Text("Flutter"), actions: <Widget>[
        new IconButton(icon: new Icon(Icons.list), onPressed: _pushSaved)
      ]),
      body: _buildSuggestions(),
    );
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

  Widget _buildSuggestions() {
    return new ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 30,
        itemBuilder: (context, i) {
          if (i.isOdd) return new Divider();
          final index = i ~/ 2;
          if (index >= _suggestions.length) {
            _suggestions.addAll(generateWordPairs().take(10));
          }
          return _buildRow(_suggestions[index]);
        });
  }

  Widget _buildRow(WordPair pair) {
    final alreadySaved = _saved.contains(pair);
    return new ListTile(
        title: new Text(pair.asPascalCase, style: _biggerFont),
        trailing: new Icon(
            alreadySaved ? Icons.favorite : Icons.favorite_border,
            color: alreadySaved ? Colors.red : null),
        onTap: () {
          setState(() {
            alreadySaved ? _saved.remove(pair) : _saved.add(pair);
          });
        });
  }

  void _pushSaved() {
    Navigator.of(context).push(new MaterialPageRoute(
      builder: (context) {
        final tiles = _saved.map((pair) {
          return new ListTile(
              title: new Text(pair.asPascalCase, style: _biggerFont));
        });
        final divided =
            ListTile.divideTiles(context: context, tiles: tiles).toList();
        return new Scaffold(
            appBar: new AppBar(title: new Text("Saved Suggestions")),
            body: new ListView(children: divided));
      },
    ));
  }


}
