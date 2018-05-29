import 'package:flutter/material.dart';
import 'package:flutter_app/localization/demo_localizations.dart';
import 'package:flutter_app/view/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        localizationsDelegates: [
          const DemoLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        supportedLocales: [
          const Locale('zh', 'CH'),
          const Locale('en', 'US') // English
        ],
        onGenerateTitle: (context) {
          return DemoLocalizations.of(context).title;
        },
        theme: new ThemeData(primaryColor: Colors.white),
        home: new Home());
  }
}
