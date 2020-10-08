import 'package:NewsPaper/model/Model.dart';

class FavoriteList extends Model{
  static String table = 'favorites';

  int id;
  int paperId;
  String title;
  String image;
  String url;

  FavoriteList({this.id,this.paperId, this.title,this.image,this.url});

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      'paper_id': paperId,
      'title': title,
      'image': image,
      'url': url,
    };
    if (id != null) { map['id'] = id; }
    return map;
  }

  static FavoriteList fromMap(Map<String, dynamic> map) {
    return FavoriteList(
      id : map['id'],
      paperId : map['paper_id'],
      title : map['title'],
      image : map['image'],
      url : map['url']
    );
  }
}