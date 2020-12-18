
class Anime {
  int id;
  String title;

  Anime({this.id , this.title});

  Anime.fromJson(Map<String, dynamic> json) {
    Anime(
      id : json["id"],
      title : json["title"],
    );
  }
}