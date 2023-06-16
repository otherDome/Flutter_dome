import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  Future<String> fetchAdData() {
    return Future.delayed(const Duration(seconds: 1), () => '广告内容');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: fetchAdData(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: Text('加载中...'),
            ),
          );
        } else {
          Future.delayed(const Duration(seconds: 3), () {
            Navigator.pushReplacementNamed(context, '/home');
          });

          return Scaffold(
            body: Center(
              child: Text(snapshot.data ?? '广告内容'),
            ),
          );
        }
      },
    );
  }
}
