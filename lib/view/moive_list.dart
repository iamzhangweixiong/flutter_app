import 'dart:convert';
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
  List movies = new List();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    fetchMovie(context);
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

  void fetchMovie(BuildContext context) async {
    final _jsonDecoder = new JsonDecoder();
    final url = "https://api.douban.com/v2/movie/top250?start=0&count=10";
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
}
