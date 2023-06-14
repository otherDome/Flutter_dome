import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('sol 星球效果'),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: CustomPaint(
                    painter: CanvasWeb(_animationController),
                  ),
                ),
                Positioned(
                  top: 300,
                  width: double.infinity,
                  height: 300,
                  child: Container(
                    color: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: const Text(
                      '我的个人中心逻辑',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CanvasWeb extends CustomPainter {
  final Animation<double> animation;

  CanvasWeb(this.animation) : super(repaint: animation);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = Colors.black,
    );
    // 执行绘制逻辑
    // 在这里实现类似CAVS的动画效果
  }

  @override
  bool shouldRepaint(CanvasWeb oldDelegate) => false;
}
