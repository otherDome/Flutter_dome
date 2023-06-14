import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class Equipment extends StatefulWidget {
  const Equipment({super.key});
  @override
  State<StatefulWidget> createState() => _Equipment();
}

class _Equipment extends State<Equipment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的设备'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(26, 188, 156, 1),
        leading: IconButton(
          //左侧按钮
          icon: const Icon(Icons.menu),
          onPressed: () {
            logger.i('点击左侧按钮');
          },
        ),
        actions: [
          //右侧按钮
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              logger.i('点击了右侧按钮');
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              logger.i('点击了设置按钮');
            },
          ),
        ],
        elevation: 5, //阴影
        shadowColor: const Color(0xFF444654), //阴影颜色
      ),
      body: const Center(
        child: Text('我的设备逻辑'),
      ),
    );
  }
}
