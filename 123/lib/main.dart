import 'package:NewsPaper/helper/FavoritHelper.dart';
import 'package:NewsPaper/route.dart';
import 'package:NewsPaper/screens/SplashScreen.dart';
import 'package:flutter/material.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FavoriteHelper.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home:SplashScreen(),
      routes: routes,
    );
  }
}

