import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

final logger = Logger();

class LoginMail extends StatefulWidget {
  const LoginMail({super.key});
  @override
  State<StatefulWidget> createState() => _LoginBody();
}

class _LoginBody extends State<LoginMail> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
