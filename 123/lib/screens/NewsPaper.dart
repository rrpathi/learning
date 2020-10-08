import 'dart:convert';
import 'package:NewsPaper/helper/FavoritHelper.dart';
import 'package:NewsPaper/model/FavoriteList.dart';
import 'package:NewsPaper/screens/NewsView.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../route.dart';

class NewsPaper extends StatefulWidget {
  NewsPaperListArgument newsCountry;
  NewsPaper(this.newsCountry);
  @override
  _NewsPaperState createState() => _NewsPaperState(this.newsCountry);
}

class _NewsPaperState extends State<NewsPaper> {
  List languages = [], newsPapers = [], newsPapersFilter = [];
  String _value;

  NewsPaperListArgument newsCountry;

  _NewsPaperState(this.newsCountry);

  getNewsPaperLists() async {
    try {
      final response =
          await http.get(baseURL + 'news-paper/' + newsCountry.id.toString());
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Authentication Error');
      }
    } catch (e) {
      print("Error: " + e.toString());
      return null;
    }
  }

  getCountryListData() {
    Future.delayed(const Duration(milliseconds: 500), () {
      getNewsPaperLists().then((data) {
        setState(() {
          languages = data['languages'];
          newsPapers = newsPapersFilter = data['newspapers'];
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getCountryListData();
  }

  void _filterSearch(value) {
    setState(() {
      _value = value;
      newsPapers = newsPapersFilter.where((newsPaper) => newsPaper['language_id'] == int.parse(value)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text(widget.newsCountry.name),
        actions: <Widget>[
          Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.deepPurpleAccent,
              ),
              child: DropdownButton<String>(
                hint: Container(
                  child: Text(
                    'Select Language',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                value: _value,
                items: languages.map((language) {
                  return DropdownMenuItem(
                    value: language['id'].toString(),
                    child: Text(
                      language['name'],
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }).toList(),
                onChanged: (String value) => _filterSearch(value),
              ))
        ],
      ),
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assert/globe-bg.jpg",),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.1), BlendMode.srcOver)),
          ),
          padding: EdgeInsets.all(5.0),
          child: GridView.builder(
              physics: AlwaysScrollableScrollPhysics(),
              itemCount: newsPapers.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 8.0 / 4.0,
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/news-paper-view', arguments: NewsPaperArgument(newsPapers[index]['id'], newsPapers[index]['name'], newsPapers[index]['image'], newsPapers[index]['url'])),
                  child: Padding(
                    padding: EdgeInsets.all(0.5),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      color: Colors.transparent,
                      semanticContainer: true,
                      elevation: 3.0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7.0))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                            child: FadeInImage.assetNetwork(
                              placeholder: 'assert/globe.jpg',
                              image: newsPapers[index]['image'],
                              height: 60.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              newsPapers[index]['name'],
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                          )
                        ],
                      ),
                    ),

//                    Card(
//                        semanticContainer: true,
//                        elevation: 3.0,
//                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(7.0))),
//                        child: ListTile(
//                          title: FadeInImage.assetNetwork(
//                            placeholder: 'assert/globe.jpg',
//                            image: newsPapers[index]['image'],
//                            height: 60.0,
//                            fit: BoxFit.fill,
//                            alignment: Alignment.topCenter,
//                          ),
//                          subtitle:Text(
//                            newsPapers[index]['name'],
//                            maxLines: 1,
//                            overflow: TextOverflow.ellipsis,
//                            textAlign: TextAlign.center,
//                            style: TextStyle(
//                                fontSize: 12.0,
//                                fontWeight: FontWeight.bold,
//                                color: Colors.black),
//                          ),
//                        )
//                    ),
                  ),
                );
              })),
    );
  }
}

class NewsPaperListArgument {
  final String name;
  final int id;

  NewsPaperListArgument(this.name, this.id);
}
