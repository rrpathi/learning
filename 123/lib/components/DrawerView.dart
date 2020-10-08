import 'package:NewsPaper/utils/AppImages.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';


class DrawerView extends StatefulWidget {
  @override
  _DrawerViewState createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // column holds all the widgets in the drawer
      child: Column(
        children: <Widget>[
          Expanded(
            // ListView contains a group of widgets that scroll inside the drawer
            child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    color: AppBarColor,
                  ),
                  accountEmail: Text('News Paper',
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.27,
                      ),
                  ),
                  currentAccountPicture: ClipOval(
                    child: Image.network(
                      'https://thumbs.dreamstime.com/b/breaking-news-live-tv-label-logo-vector-template-design-illustration-166710271.jpg',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Home"),
                  leading: Icon(Icons.home),
                  onTap: ()=> Navigator.pushNamed(context, '/home'),
                ),
                ListTile(
                  title: Text("Favorite"),
                  leading: Icon(Icons.favorite),
                  onTap: ()=> Navigator.pushNamed(context, '/favorite'),
                ),
                ListTile(
                  title: Text("Share"),
                  leading: Icon(Icons.share),
                  onTap: ()=>_onShare(context),
                ),
                ListTile(
                  title: Text("Rate Us"),
                  leading: Icon(Icons.rate_review),
                  onTap: ()=>launch('https://play.google.com/store/apps/developer?id=Hellojokers&hl=en'),
                ),
              ],
            ),
          ),
          // This container holds the align
          Container(
            // This align moves the children to the bottom
              child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Container(
                      child: Column(
                        children: <Widget>[
                          Divider(),
                          ListTile(
                              leading: Icon(Icons.help),
                              title: Text('About Us'),
                              onTap: ()=> Navigator.pushNamed(context, '/about'),
                          ),
                          Text('1.0 V'),
                          SizedBox(height: 8.0,),
                        ],
                      )
                  )
              )
          )
        ],
      ),
    );
  }

  _onShare(BuildContext context) async {
      await Share.share('check out my website https://example.com');
  }
}
