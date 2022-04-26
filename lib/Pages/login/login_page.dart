import 'package:app_vale_cv/helpers/constants.dart';
import 'package:app_vale_cv/widgets/custom_elevated_button.dart';
import 'package:app_vale_cv/widgets/custom_text_field.dart';
import 'package:app_vale_cv/widgets/shake_transition.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [_formulario(_height, _width)],
        ));
  }

  Widget _formulario(double height, double width) {
    List<Widget> content = [
      ShakeTransition(
          axis: Axis.vertical,
          duration: const Duration(milliseconds: 3000),
          child: Container(
            margin: EdgeInsets.only(bottom: height / 16),
            child: CustomTextField(
              label: 'Usuario',
              controller: _userController,
              icon: Icons.account_circle,
              enableUpperCase: true,
            ),
          )),
      ShakeTransition(
          axis: Axis.vertical,
          duration: const Duration(milliseconds: 3000),
          child: Container(
            margin: EdgeInsets.only(bottom: height / 16),
            child: CustomTextField(
              label: 'Password',
              controller: _passController,
              icon: Icons.lock,
              isPassword: true,
            ),
          )),
      ShakeTransition(
          axis: Axis.vertical,
          duration: const Duration(milliseconds: 3000),
          child: Container(
            margin: EdgeInsets.only(bottom: height / 16),
            child: CustomElevatedButton(
              label: 'Iniciar Sesión',
              action: () {},
              textColor: Constants.colorDefault,
              primaryColor: Constants.colorAlternative,
              borderColor: Constants.colorPrimary,
            ),
          ))
    ];

    return Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: width / 16),
            child: ListView(children: content)));
  }
}
