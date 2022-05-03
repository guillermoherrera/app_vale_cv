import 'package:app_vale_cv/Pages/homepage/home_page.dart';
import 'package:app_vale_cv/Pages/login/login_page.dart';
import 'package:app_vale_cv/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      return state.existUser ? const HomePage() : const LoginPage();
    });
    //return !_isLogged ? const LoginPage() : const HomePage();
  }
}
