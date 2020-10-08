import 'dart:convert';
import 'package:NewsPaper/components/DrawerView.dart';
import 'package:NewsPaper/route.dart';
import 'package:NewsPaper/screens/NewsPaper.dart';
import 'package:NewsPaper/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController _sc = new ScrollController();
  DateTime currentBackPressTime;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool isLoading = false;
  List countries = [];
  List countries1 = [];
  int page = 1;

  getCountryLists() async {
    try {
      final response =
          await http.get(baseURL + 'countries?page=' + page.toString());
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
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      Future.delayed(const Duration(milliseconds: 500), () {
        getCountryLists().then((data) {
          setState(() {
            isLoading = false;
            countries.addAll(data['countries']['data']);
            page = page + 1;
          });
        });
      });
    }
  }

  Future<Null> _refresh() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    setState(() {
      countries.clear();
      page = 1;
    });
    await Future.delayed(Duration(seconds: 1));
    getCountryLists().then((data) {
      setState(() {
        isLoading = false;
        countries.addAll(data['countries']['data']);
        page = page + 1;
      });
    });
    return null;
  }

  @override
  void initState() {
    this.getCountryListData();
    super.initState();
    _sc.addListener(() {
      if (_sc.position.pixels == _sc.position.maxScrollExtent) {
        getCountryListData();
      }
    });
  }

  @override
  void dispose() {
    _sc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("News App"),
        backgroundColor: AppBarColor,
      ),
      body: WillPopScope(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assert/globe-bg.jpg"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.1), BlendMode.srcOver)),
            ),
            child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: _refresh,
              child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: GridView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _sc,
                      itemCount: countries.length + 1,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 8.0 / 4.0,
                        crossAxisCount: 2,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == countries.length) {
                          return _buildProgressIndicator();
                        } else {
                          return GestureDetector(
                            onTap: () => Navigator.pushNamed(
                                context, '/news-paper',
                                arguments: NewsPaperListArgument(
                                    countries[index]['name'],
                                    countries[index]['id'])),
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              color: Colors.transparent,
//                          semanticContainer: true,
                              elevation: 3.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(7.0))),
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
                                      image: countries[index]['image'],
                                      height: 60.0,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      countries[index]['name'],
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 15.0,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                      })),
            ),
          ),
          onWillPop: onWillPop),
      drawer: DrawerView(), //this will just add the Navigation Drawer Icon
    );
  }

  Future<bool> onWillPop() {
    return showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => new AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            content: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Icon(
                  Icons.exit_to_app,
                  color: Colors.deepPurple,
                  size: 25.0,
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    "Do you want to exit this App",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17.0,
                        color: Colors.black),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No', style: TextStyle(color: Colors.deepPurple, fontSize: 17.0)),
              ),
              new FlatButton(
                onPressed: () {
//                  Navigator.pop(context, true);
                  Navigator.of(context).pop(true);
                },
                child: new Text('Yes', style: TextStyle(color: Colors.deepPurple, fontSize: 17.0)),
              ),
            ],
          ),
        ) ??
        false;
  }

  Widget _buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: isLoading ? 1.0 : 00,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
