
class Cast {

  List<Actor> actores = new List();

  Cast.fromJsonList( List<dynamic> jsonList) {

    if (jsonList == null) return;

    jsonList.forEach((item) {
      final actor = Actor.fromJsonMap(item);
      actores.add(actor);
     });

  }

}

class Actor {
  bool adult;
  int gender;
  int id;
  String knownForDepartment;
  String name;
  String originalName;
  double popularity;
  String profilePath;
  int castId;
  String character;
  String creditId;
  int order;
  String department;
  String job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {

    adult                = json['adult'];
    gender               = json['gender'];         
    id                   = json['id'];
    knownForDepartment   = json['knownFor_department'];
    name                 = json['name'];
    originalName         = json['original_name'];
    popularity           = json['popularity'];
    profilePath          = json['profile_path'];
    castId               = json['cast_id'];
    character            = json['character'];
    creditId             = json['credit_id'];
    order                = json['order'];
    department           = json['department'];
    job                  = json['job'];

  }

  getPhotoImg() {

    if (profilePath == null) {
      return 'https://i.pinimg.com/originals/5b/00/17/5b0017fa4ba19e7bbed08eac0c6a29db.jpg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }

  }

}
