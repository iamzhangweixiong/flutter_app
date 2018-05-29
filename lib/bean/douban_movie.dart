
class MovieBean {
  int count;
  int start;
  int total;
  String title;
  List<SubjectsBean> subjects;

  MovieBean.fromJson(Map json)
      : count = json['count'],
        start = json['start'],
        total = json['total'],
        title = json['title'],
        subjects = json['subjects'] as List<SubjectsBean>;
}

class SubjectsBean {
  RatingBean rating;
  String title;
  int collect_count;
  String original_title;
  String subtype;
  String year;
  ImagesBean images;
  String alt;
  String id;
  List<String> genres;
  List<CastsBean> casts;
  List<DirectorsBean> directors;

  SubjectsBean.fromJson(Map json)
      : title = json['title'],
        rating = new RatingBean.fromJson(json['rating']),
        images = new ImagesBean.fromJson(json['images']),
        collect_count = json['collect_count'],
        original_title = json['original_title'],
        subtype = json['subtype'],
        year = json['year'],
        alt = json['alt'],
        genres = json['genres'] as List<String>,
        casts = json['casts'] as List<CastsBean>,
        directors = json['directors'] as List<DirectorsBean>,
        id = json['id'];
}

class RatingBean {
  int max;
  double average;
  String stars;
  int min;

  RatingBean.fromJson(Map json)
      : max = json['max'],
        average = json['average'],
        min = json['min'],
        stars = json['stars'];
}

class ImagesBean {
  String small;
  String large;
  String medium;

  ImagesBean.fromJson(Map json)
      : small = json['small'],
        large = json['large'],
        medium = json['medium'];
}

class CastsBean {
  String alt;
  AvatarsBean avatars;
  String name;
  String id;

  CastsBean.fromJson(Map json)
      : alt = json['alt'],
        avatars = new AvatarsBean.fromJson(json['avatars']),
        name = json['name'],
        id = json['id'];
}

class AvatarsBean {
  String small;
  String large;
  String medium;

  AvatarsBean.fromJson(Map json)
      : small = json['small'],
        large = json['large'],
        medium = json['medium'];
}

class DirectorsBean {
  String alt;
  AvatarsBeanX avatars;
  String name;
  String id;

  DirectorsBean.fromJson(Map json)
      : alt = json['alt'],
        avatars = new AvatarsBeanX.fromJson(json['avatars']),
        name = json['name'],
        id = json['id'];
}

class AvatarsBeanX {
  String small;
  String large;
  String medium;

  AvatarsBeanX.fromJson(Map json)
      : small = json['small'],
        large = json['large'],
        medium = json['medium'];
}
