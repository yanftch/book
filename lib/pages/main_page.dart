import 'package:flutter/material.dart';
import 'package:book/styles.dart' show Styles;
import 'package:book/screens.dart';

/// 主页
///
class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final List<Widget> pages = [
    HomePage(),
    GankHomePage(),
    TimeMainPage(),
    ThirdPage(),
    MinePage()
  ];

  final List<BottomNavigationBarItem> _bottomTabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: Icon(Icons.home),
        title: Text("首页"),
        backgroundColor: Styles.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(Icons.chat),
        title: Text("GANK"),
        backgroundColor: Styles.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(Icons.timelapse),
        title: Text("时光"),
        backgroundColor: Styles.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(Icons.video_library),
        title: Text("third"),
        backgroundColor: Styles.colorPrimary),
    BottomNavigationBarItem(
        icon: Icon(Icons.account_circle),
        title: Text("mine"),
        backgroundColor: Styles.colorPrimary),
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: PageView(
          physics: NeverScrollableScrollPhysics(), // 禁用左右滑动
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: _bottomTabs,
          onTap: _onTap,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
        ),
      );

  void _onTap(int index) => _pageController.animateToPage(index,
      duration: const Duration(milliseconds: 300), curve: Curves.ease);

  void _onPageChanged(int index) => setState(() {
        this._currentIndex = index;
      });
}
