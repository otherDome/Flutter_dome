import 'package:flutter/material.dart';
import 'dart:math';
import 'package:logger/logger.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vector;

final logger = Logger(); // 日志
Random random = Random(); // 随机数
const double interval = 1.5; //组成圆圈的间隔

class Home extends StatefulWidget {
  //入口文件
  const Home({super.key});
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  bool isMale = true; // 默认为男性
  int numberOfPeople = random.nextInt(300) + 1; // 1-1000随机数
  late AnimationController _controller; // 动画控制器
  late List<Point3D> points; //3D点集合
  double rotationAngle = 0.0; // 旋转角度
  final int rotationDurationInSeconds = 10; //动画时间

  //动画开始
  @override
  void initState() {
    super.initState(); //初始化
    _controller = AnimationController(
      //动画控制器
      duration: Duration(seconds: rotationDurationInSeconds),
      vsync: this,
    )..repeat();

    _controller.repeat();

    //_controller.forward(); // 启动动画
    points = generateSpherePoints(numberOfPeople, radius: 100); // 生成3D点集合
    // 监听动画的变化
    _controller.addListener(() {
      setState(() {
        rotationAngle = _controller.value * 2 * math.pi; // 更新旋转角度
      });
    });
  }

  //动画销毁
  @override
  void dispose() {
    //销毁
    _controller.dispose(); //销毁动画控制器
    super.dispose(); //销毁
  }

  List<Point3D> generateSpherePoints(int numPoints, {double radius = 1.0}) {
    // 生成3D点集合
    final points = <Point3D>[];

    for (int i = 0; i < numPoints; i++) {
      final phi = math.acos(-1 + (2 * i.toDouble()) / numPoints);
      final theta = math.pi * (1 + math.sqrt(5)) * i.toDouble();
      final x = radius * math.cos(theta) * math.sin(phi);
      final y = radius * math.sin(theta) * math.sin(phi);
      final z = radius * math.cos(phi);
      final point3D = Point3D(x, y, z);
      points.add(point3D);
    }

    return points;
  }

  //页面布局
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('玩法探索'),
        centerTitle: true,
        backgroundColor: const Color.fromRGBO(26, 188, 156, 1),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 0.0, horizontal: 15.0),
                  child: Text(
                    '在线人数:${numberOfPeople.toString()}人',
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5.0, horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(isMale ? '男生' : '女生'),
                      Switch(
                        value: isMale,
                        inactiveThumbColor: Colors.pinkAccent,
                        inactiveTrackColor:
                            isMale ? Colors.blue[200] : Colors.pinkAccent[200],
                        activeColor: Colors.blue,
                        onChanged: (bool newValue) {
                          setState(() {
                            isMale = newValue;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 350,
            width: double.infinity,
            child: Container(
              color: Colors.black, // 背景色
              child: CustomPaint(
                painter: SpherePainter(rotationAngle, points),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Point3D {
  double x, y, z;
  Point3D(this.x, this.y, this.z);
}

class SpherePainter extends CustomPainter {
  // 画布
  final double rotationAngle;
  final List<Point3D> points;

  SpherePainter(this.rotationAngle, this.points);
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final isRadius = size.width / 2.7;
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, isRadius, paint);
    const projectionDistance = 1000;
    for (final point3D in points) {
      final rotationMatrix = vector.Matrix4.rotationY(rotationAngle);
      final rotatedPoint = vector.Vector3(point3D.x, point3D.y, point3D.z)
        ..applyMatrix4(rotationMatrix);

      final x = rotatedPoint.x;
      final y = rotatedPoint.y;
      final z = rotatedPoint.z;
      final scale = interval * projectionDistance / (projectionDistance - z);
      final projectedX = center.dx + x * scale;
      final projectedY = center.dy + y * scale;
      final point = Offset(projectedX, projectedY);
      canvas.drawCircle(point, 3, Paint()..color = Colors.red);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
