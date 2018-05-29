import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => new _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final List movies = new List();
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
        appBar: new AppBar(title: new Text("fetch moive")), body: selectBody());
  }

  Widget selectBody() {
    if (isLoading) {
      return new Center(child: const CupertinoActivityIndicator());
    } else {
      return new ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: movies.length,
          itemBuilder: (context, i) {
            final movie = movies[i];
            return new ListTile(
                title: new Text(movie['title']),
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
      print(response.statusCode);
      Map<String, dynamic> body = _jsonDecoder.convert(response.body);
      List subjects = body['subjects'];
      setState(() {
        isLoading = false;
        movies.addAll(subjects);
      });
    }
  }
}
