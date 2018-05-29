import 'package:flutter/material.dart';

class MovieList extends StatefulWidget {
    final List movies;

    MovieList(this.movies)

    @override
    _MovieListState createState() => new _MovieListState(movies);
}

class _MovieListState extends State<MovieList> {
    final List movies;

    _MovieListState(this.movies)

    @override
    Widget build(BuildContext context) {
        return new Scaffold(
            appBar: new AppBar(title: new Text("fetch moive")),
            body: new ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: movies.length,
                itemBuilder: (context, i) {
                    final movie = movies[i];
                    return new ListTile(
                        title: new Text(movie['title']),
                        subtitle: new Text(movie['original_title']));
                }));
    }

}