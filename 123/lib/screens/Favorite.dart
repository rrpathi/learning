import 'package:NewsPaper/components/DrawerView.dart';
import 'package:NewsPaper/helper/FavoritHelper.dart';
import 'package:NewsPaper/model/FavoriteList.dart';
import 'package:NewsPaper/screens/NewsView.dart';
import 'package:NewsPaper/utils/AppImages.dart';
import 'package:flutter/material.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  List<FavoriteList> _favorites = [];
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  List<Widget> get _items => _favorites.map((item) => format(item)).toList();

  Widget format(FavoriteList item) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/news-paper-view',
          arguments: NewsPaperArgument(
              item.paperId, item.title, item.image, item.url)),
      child: Card(
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        semanticContainer: true,
        elevation: 3.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0))),
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
                image: item.image,
                height: 60.0,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                item.title,
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
    );
  }

  void refresh() async {
    List<Map<String, dynamic>> _results =
        await FavoriteHelper.query(FavoriteList.table);
    _favorites = _results.map((item) => FavoriteList.fromMap(item)).toList();
    setState(() {});
  }

  Future<Null> _refresher() async {
    _refreshIndicatorKey.currentState?.show(atTop: false);
    setState(() {
      _favorites.clear();
    });
    await Future.delayed(Duration(seconds: 1));
    refresh();
    print(_items);
    return null;
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 10;
    final double itemWidth = size.width / 2;
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
        backgroundColor: AppBarColor,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                "assert/globe-bg.jpg",
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.1), BlendMode.srcOver)),
        ),
        padding: EdgeInsets.all(5.0),
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refresher,
          child: _items.length > 0
              ? GridView.count(
                  childAspectRatio: (8.0 / 4.0),
                  crossAxisCount: 2,
                  scrollDirection: Axis.vertical,
                  controller: new ScrollController(keepScrollOffset: false),
                  children: _items)
              : Center(child: Text('No Favourite List!!')),
        ),
      ),
      drawer: DrawerView(),
    );
  }
}
