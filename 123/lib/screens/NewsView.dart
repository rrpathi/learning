import 'package:NewsPaper/helper/FavoritHelper.dart';
import 'package:NewsPaper/model/FavoriteList.dart';
import 'package:NewsPaper/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsView extends StatefulWidget {
  NewsPaperArgument newspaper;
  NewsView(this.newspaper);
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  WebViewController _controller;
  final _key = UniqueKey();
  bool isFav = false;

  showAlert() {
    _save();
  }

  void _save() async {
    paperFavouriteCheck().then((data) {
      if (data.length > 0) {
        FavoriteHelper.delete(FavoriteList.table, data[0]['id']);
        setState(() {
          isFav = false;
        });
      } else {
        FavoriteList item = FavoriteList(
            paperId: widget.newspaper.id,
            title: widget.newspaper.title,
            image: widget.newspaper.image,
            url: widget.newspaper.url);
        FavoriteHelper.insert(FavoriteList.table, item);
        setState(() {
          isFav = true;
        });
      }
    });
  }

  paperFavouriteCheck() async {
    return await FavoriteHelper.getPaperPresent(
        FavoriteList.table, widget.newspaper.id);
  }

  @override
  void initState() {
    super.initState();
    paperFavouriteCheck().then((data) {
      setState(() {
        if (data.length > 0) {
          isFav = true;
        } else {
          isFav = false;
        }
      });
    });
  }

  Future<void> _handleBack(context) async {
    var status = await _controller.canGoBack();
    if (status) {
      _controller.goBack();
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _handleBack(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppBarColor,
          title: Text(widget.newspaper.title),
          actions: <Widget>[
            IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.yellow : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  showAlert();
                });
              },
            )
          ],
        ),
        body: WebView(
          key: _key,
          initialUrl: widget.newspaper.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller = webViewController;
          },
        ),
      ),
    );
    ;
  }
}

class NewsPaperArgument {
  final String title, url, image;
  final int id;
  NewsPaperArgument(this.id, this.title, this.image, this.url);
}
