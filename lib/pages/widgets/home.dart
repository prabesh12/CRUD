import 'package:api_practice/pages/post/create_post.dart';
import 'package:api_practice/pages/post/post_screen.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    const CreatePost(),
    const PostPage(),
  ];

  void _onItemTapped(int index) {
    _selectIndex = index;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(child: _widgetOptions[_selectIndex]),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectIndex,
          onTap: _onItemTapped,
          backgroundColor: Colors.blue,
          showSelectedLabels: true,
          unselectedItemColor: Colors.white,
          elevation: 10,
          showUnselectedLabels: true,
          selectedItemColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.post_add,
                  color: Colors.white,
                ),
                label: "Add Post"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.show_chart_sharp,
                color: Colors.white,
              ),
              label: "Show Post",
            ),
          ]),
    );
  }
}
