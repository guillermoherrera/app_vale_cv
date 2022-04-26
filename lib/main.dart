import 'package:flutter/material.dart';

import 'package:app_vale_cv/Pages/root_page.dart';
import 'package:app_vale_cv/helpers/constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Vale CV',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Constants.colorPrimary),
      initialRoute: Constants.pageRoot,
      routes: {Constants.pageRoot: (BuildContext context) => const RootPage()},
    );
  }
}
