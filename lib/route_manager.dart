import 'package:flutter_dome/pages/login/login_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:flutter_dome/pages/Toolbar/index.dart';

List<GetPage<dynamic>> pages = [
  // toolbar
  GetPage(name: '/', page: () => const Toolbar()),
  // other
  GetPage(name: '/login_mail', page: () => const LoginMail()),
];
