import 'package:flutter_dome/pages/advertisement/splash_screen.dart';
import 'package:flutter_dome/pages/login/login_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:flutter_dome/pages/Toolbar/index.dart';

List<GetPage<dynamic>> pages = [
  GetPage(name: '/', page: () => const SplashScreen()),
  // toolbar
  GetPage(name: '/home', page: () => const Toolbar()),
  // other
  GetPage(name: '/login_mail', page: () => const LoginMail()),
];
