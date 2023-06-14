import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class My extends StatefulWidget {
  const My({super.key});
  @override
  State<StatefulWidget> createState() => _My();
}

class _My extends State<My> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('个人中心'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(26, 188, 156, 1),
        actions: [
          //右侧按钮
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
        child: Text('我的个人中心逻辑'),
      ),
    );
  }
}
