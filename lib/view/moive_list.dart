import 'dart:async';
import 'dart:convert';
import 'dart:isolate';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/localization/demo_localizations.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => new _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final url = "https://api.douban.com/v2/movie/top250?start=0&count=10";
  List movies = new List();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
//    scheduleMicrotask(() {
      fetchMovie2();
//    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
            title: new Text(DemoLocalizations.of(context).movieTitle)),
        body: selectBody());
  }

  Widget selectBody() {
    if (isLoading) {
      return new Center(child: CircularProgressIndicator());
    } else {
      return new ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: movies.length,
          itemBuilder: (context, i) {
            final movie = movies[i];
            final imageUrl = movie['images']['small'];
            return new ListTile(
                title: new Text(movie['title']),
                trailing: new CachedNetworkImage(
                    imageUrl: imageUrl,
                    width: 60.0,
                    height: 60.0,
                    placeholder: new CupertinoActivityIndicator(),
                    errorWidget: new Icon(Icons.error)),
                subtitle: new Text(movie['original_title']));
          });
    }
  }

  void fetchMovie() async {
    final _jsonDecoder = new JsonDecoder();
    print(url);
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      Map<String, dynamic> body = _jsonDecoder.convert(response.body);
      List subjects = body['subjects'];
      setState(() {
        isLoading = false;
        movies.addAll(subjects);
      });
    }
  }

  /// use Isolate
  void fetchMovie2() async {
    ReceivePort receivePort = new ReceivePort();

    Isolate isolate = await Isolate.spawn(dataLoader, receivePort.sendPort);

    SendPort sendPort = await receivePort.first;

    Map<String, dynamic> body = await sendReceive(sendPort, url);
    List subjects = body['subjects'];

    setState(() {
      isLoading = false;
      movies.addAll(subjects);
    });

    isolate.kill(priority: Isolate.immediate);
  }

// the entry point for the isolate
  static dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    ReceivePort port = new ReceivePort();

    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);

    await for (var msg in port) {
      String data = msg[0];
      SendPort replyTo = msg[1];

      String dataURL = data;
      http.Response response = await http.get(dataURL);
      // Lots of JSON to parse
      replyTo.send(JSON.decode(response.body));
    }
  }

  Future sendReceive(SendPort port, msg) {
    ReceivePort response = new ReceivePort();
    port.send([msg, response.sendPort]);
    return response.first;
  }
}
