import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DemoLocalizations {
  DemoLocalizations(this.locale);

  final Locale locale;

  static DemoLocalizations of(BuildContext context) {
    return Localizations.of<DemoLocalizations>(context, DemoLocalizations);
  }

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'app':'Flutter Demo',
      'title': 'Hello World',
      'movie_title': 'fetch movie'
    },
    'zh': {
      'app':'Flutter Demo',
      'title': '哈哈',
      'movie_title': '电影'
    }
  };

  String get title {
    return _localizedValues[locale.languageCode]['title'];
  }

  String get app {
    return _localizedValues[locale.languageCode]['app'];
  }

  String get movieTitle {
    return _localizedValues[locale.languageCode]['movie_title'];
  }
}

class DemoLocalizationsDelegate extends LocalizationsDelegate<DemoLocalizations> {
  const DemoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'zh'].contains(locale.languageCode);

  @override
  Future<DemoLocalizations> load(Locale locale) {
    // Returning a SynchronousFuture here because an async "load" operation
    // isn't needed to produce an instance of DemoLocalizations.
    return new SynchronousFuture<DemoLocalizations>(new DemoLocalizations(locale));
  }

  @override
  bool shouldReload(DemoLocalizationsDelegate old) => false;
}