import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('玩法探索'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(26, 188, 156, 1),
        elevation: 5, //阴影
        shadowColor: const Color(0xFF444654), //阴影颜色
      ),
      body: const Center(
        child: Text('这里是个星球'),
      ),
    );
  }
}
