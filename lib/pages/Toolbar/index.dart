import 'package:flutter/material.dart';
import 'package:flutter_dome/pages/Toolbar/home/index.dart';
import 'package:flutter_dome/pages/Toolbar/equipment/index.dart';
import 'package:flutter_dome/pages/Toolbar/my/index.dart';

class Toolbar extends StatefulWidget {
  const Toolbar({super.key});

  @override
  State<Toolbar> createState() => _ToolbarState();
}

class _ToolbarState extends State<Toolbar> {
  int cuttentIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [Home(), Equipment(), My()],
      ),
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color.fromRGBO(26, 188, 156, 1),
          unselectedItemColor: const Color.fromRGBO(204, 204, 204, .9),
          currentIndex: cuttentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              cuttentIndex = index;
              _pageController.jumpToPage(index);
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: '搜索',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.devices),
              label: '设备',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: '我的',
            ),
          ]),
    );
  }
}
