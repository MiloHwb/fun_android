import 'package:flutter/material.dart';
import 'package:fun_android/generated/i18n.dart';

import 'home_page.dart';
import 'project_page.dart';
import 'stucture_page.dart';
import 'user_page.dart';
import 'wechat_account_page.dart';

class TabNavigator extends StatefulWidget {
  TabNavigator({Key key}) : super(key: key);

  @override
  _TabNavigatorState createState() {
    return _TabNavigatorState();
  }
}

class _TabNavigatorState extends State<TabNavigator> {
  DateTime _previousPressed;
  PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          if (_previousPressed == null ||
              DateTime.now().difference(_previousPressed) > Duration(seconds: 1)) {
            //两次点击间隔大于1秒则重新计时
            _previousPressed = DateTime.now();
            return false;
            // return Future.value(false); // 不加async可以这么返回
          }
          return true;
          // return Future.value(true); // 不加async可以这么返回
        },
        child: PageView.builder(
          itemBuilder: (BuildContext context, int index) {
            return pages[index];
          },
          itemCount: pages.length,
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text(S.of(context).tabHome),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text(S.of(context).tabProject),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group_work),
            title: Text(S.of(context).tabProject),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call_split),
            title: Text(S.of(context).tabStructure),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.insert_emoticon),
            title: Text(S.of(context).tabUser),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          _pageController.jumpToPage(index);
        },
      ),
    );
  }
}

List<Widget> pages = [
  HomePage(),
  ProjectPage(),
  WechatAccountPage(),
  StructurePage(),
  UserPage(),
];
