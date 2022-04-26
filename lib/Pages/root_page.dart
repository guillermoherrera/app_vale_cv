import 'package:app_vale_cv/Pages/homepage/home_page.dart';
import 'package:app_vale_cv/Pages/login/login_page.dart';
import 'package:flutter/material.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final bool _isLogged = true;
  @override
  Widget build(BuildContext context) {
    return !_isLogged ? const LoginPage() : const HomePage();
  }
}
