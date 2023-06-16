import 'package:flutter/material.dart';
import 'dart:math';
import 'package:logger/logger.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math.dart' as vector;

final logger = Logger(); // 日志
Random random = Random(); // 随机数
const double interval = 1.5; //组成圆圈的间隔
bool isMale = true; // 默认为男性 random.nextInt(80)
//背部的小点部分平滑动画
double frontAvatarRadius = 4.0;
double backAvatarRadius = 2.0;

//虚拟数据
final List<Map<String, dynamic>> dataList = [
  {"name": "John", "id": 1},
  {"name": "Alice", "id": 2},
  {"name": "Bob", "id": 3},
  {"name": "Emily", "id": 4},
  {"name": "Tom", "id": 5},
  {"name": "Sarah", "id": 6},
  {"name": "Michael", "id": 7},
  {"name": "Emma", "id": 8},
  {"name": "David", "id": 9},
  {"name": "Olivia", "id": 10},
  {"name": "James", "id": 11},
  {"name": "Sophia", "id": 12},
  {"name": "William", "id": 13},
  {"name": "Ava", "id": 14},
  {"name": "Benjamin", "id": 15},
  {"name": "Isabella", "id": 16},
  {"name": "Mason", "id": 17},
  {"name": "Mia", "id": 18},
  {"name": "Ethan", "id": 19},
  {"name": "Charlotte", "id": 20},
  {"name": "Alexander", "id": 21},
  {"name": "Amelia", "id": 22},
  {"name": "Daniel", "id": 23},
  {"name": "Harper", "id": 24},
  {"name": "Matthew", "id": 25},
  {"name": "Ella", "id": 26},
  {"name": "Henry", "id": 27},
  {"name": "Victoria", "id": 28},
  {"name": "Joseph", "id": 29},
  {"name": "Grace", "id": 30},
  {"name": "Samuel", "id": 31},
  {"name": "Chloe", "id": 32},
  {"name": "Gabriel", "id": 33},
  {"name": "Penelope", "id": 34},
  {"name": "Anthony", "id": 35},
  {"name": "Lily", "id": 36},
  {"name": "Andrew", "id": 37},
  {"name": "Avery", "id": 38},
  {"name": "Christopher", "id": 39},
  {"name": "Sofia", "id": 40},
  {"name": "David", "id": 41},
  {"name": "Madison", "id": 42},
  {"name": "Samuel", "id": 43},
  {"name": "Abigail", "id": 44},
  {"name": "James", "id": 45},
  {"name": "Evelyn", "id": 46},
  {"name": "Joseph", "id": 47},
  {"name": "Elizabeth", "id": 48},
  {"name": "Alexander", "id": 49},
  {"name": "Scarlett", "id": 50},
];

class Home extends StatefulWidget {
  //入口文件
  const Home({super.key});
  @override
  State<StatefulWidget> createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  //表单部分

  int numberOfPeople = dataList.length; // 1-1000随机数   在线人数
  //球星球部分
  late AnimationController _controller; // 动画控制器
  late List<Point3D> points; //3D点集合
  double rotationAngleX = 0.0; // X轴旋转角度
  double rotationAngleY = 0.0; // Y轴旋转角度
  double rotationAngleZ = 0.0; // Z轴旋转角度
  final int rotationDurationInSeconds = 100; //动画时间

  //动画开始球体旋转
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
        rotationAngleY = _controller.value * 2 * math.pi; // 更新旋转角度
      });
    });
  }

  //动画销毁球体旋转
  @override
  void dispose() {
    //销毁
    _controller.dispose(); //销毁动画控制器
    super.dispose(); //销毁
  }

  //背部的小点平滑动画

  // 生成3D点集合
  List<Point3D> generateSpherePoints(int numPoints, {double radius = 1.0}) {
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
              child: Listener(
                onPointerMove: (event) {
                  setState(() {
                    rotationAngleX +=
                        event.delta.dy * 0.01; // 根据鼠标垂直移动改变 X 轴旋转角度
                    rotationAngleY +=
                        event.delta.dx * 0.01; // 根据鼠标水平移动改变 Y 轴旋转角度
                    rotationAngleZ +=
                        event.delta.dx * 0.01; // 根据鼠标水平移动改变 Z 轴旋转角度
                  });
                },
                child: CustomPaint(
                  painter: SpherePainter(
                      points, rotationAngleX, rotationAngleY, rotationAngleZ),
                ),
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
  final double rotationAngleX;
  final double rotationAngleY;
  final double rotationAngleZ;
  final List<Point3D> points;

  SpherePainter(this.points, this.rotationAngleX, this.rotationAngleY,
      this.rotationAngleZ);
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final isRadius = size.width / 2.7;
    final paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, isRadius, paint);
    const projectionDistance = 1000;
    for (int index = 0; index < points.length; index++) {
      final point3D = points[index];
      final rotationMatrixX = vector.Matrix4.rotationX(rotationAngleX);
      final rotationMatrixY = vector.Matrix4.rotationY(rotationAngleY);
      final rotationMatrixZ = vector.Matrix4.rotationZ(rotationAngleZ);
      final rotationMatrix =
          rotationMatrixZ * rotationMatrixY * rotationMatrixX;
      final rotatedPoint = vector.Vector3(point3D.x, point3D.y, point3D.z)
        ..applyMatrix4(rotationMatrix);

      final x = rotatedPoint.x;
      final y = rotatedPoint.y;
      final z = rotatedPoint.z;
      final scale = interval * projectionDistance / (projectionDistance - z);
      final projectedX = center.dx + x * scale;
      final projectedY = center.dy + y * scale;
      final point = Offset(projectedX, projectedY);
      double circleRadius = 4;
      // z > 0 || x > 10 || y > 50 ? frontAvatarRadius : backAvatarRadius;
      // 渲染圆形头像
      final avatarPaint = Paint()
        ..color = isMale ? Colors.blue : const Color(0xFFFF4081);
      final avatarRadius = circleRadius;
      canvas.drawCircle(point, avatarRadius, avatarPaint);

      // 渲染昵称文本
      String nickname = dataList[index]["name"];
      const textStyle = TextStyle(color: Colors.white, fontSize: 9);
      final textSpan = TextSpan(text: nickname, style: textStyle);
      final textPainter =
          TextPainter(text: textSpan, textDirection: TextDirection.ltr);
      textPainter.layout();
      final textOffset =
          Offset(point.dx - textPainter.width / 2, point.dy + circleRadius + 8);
      textPainter.paint(canvas, textOffset);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
