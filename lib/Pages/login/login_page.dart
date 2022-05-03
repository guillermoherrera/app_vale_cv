import 'package:app_vale_cv/bloc/user/user_bloc.dart';
import 'package:app_vale_cv/helpers/constants.dart';
import 'package:app_vale_cv/models/user.dart';
import 'package:app_vale_cv/widgets/custom_elevated_button.dart';
import 'package:app_vale_cv/widgets/custom_fade_transition.dart';
import 'package:app_vale_cv/widgets/custom_text_field.dart';
import 'package:app_vale_cv/widgets/shake_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  void _loginSubmit(UserBloc userBloc) {
    final user = User(nombre: 'Angel Confia', numeroDv: "000001");
    userBloc.add(ActivateUserEvent(user));
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context, listen: false);
    final _height = MediaQuery.of(context).size.height;
    final _width = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            _fondo(_height),
            Container(color: Constants.colorPrimary.withOpacity(0.7)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _logo(_height),
                _formulario(_height, _width, userBloc),
              ],
            )
          ],
        ));
  }

  Widget _fondo(double height) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Image(
          image: const AssetImage(Constants.assetsFondologin),
          height: height / 4.4,
          fit: BoxFit.cover),
    );
  }

  Widget _logo(double height) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: height / 16),
        color: Colors.transparent,
        width: double.infinity,
        child: CustomFadeTransition(
          tweenBegin: 1.0,
          duration: const Duration(milliseconds: 30000),
          child: Column(
            children: [
              Hero(
                  tag: 'LogoLogin',
                  child: Image(
                      image: const AssetImage(Constants.assetsImagelogo),
                      color: Constants.colorDefault,
                      height: height / 4.4,
                      fit: BoxFit.contain)),
              const Text(
                'v1.0.0',
                style: Constants.textStyleSubTitleDefault,
              )
            ],
          ),
        ));
  }

  Widget _formulario(double height, double width, UserBloc userBloc) {
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
              action: () => _loginSubmit(userBloc),
              textColor: Constants.colorDefault,
              primaryColor: Constants.colorAlternative,
              borderColor: Constants.colorAlternative,
            ),
          ))
    ];

    return Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: width / 16),
            child: Column(children: content)));
  }
}
