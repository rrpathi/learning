import 'package:NewsPaper/screens/About.dart';
import 'package:NewsPaper/screens/Favorite.dart';
import 'package:NewsPaper/screens/Home.dart';
import 'package:NewsPaper/screens/NewsPaper.dart';
import 'package:NewsPaper/screens/NewsView.dart';
import 'package:flutter/material.dart';

final baseURL = "http://newspaper.mohan.work/api/";

final routes = {
  '/home': (BuildContext context) => new Home(),
  '/favorite': (BuildContext context) => new Favorite(),
  '/about': (BuildContext context) => new About(),
  '/news-paper': (BuildContext context) => new NewsPaper(ModalRoute.of(context).settings.arguments),
  '/news-paper-view': (BuildContext context) => new NewsView(ModalRoute.of(context).settings.arguments),
};