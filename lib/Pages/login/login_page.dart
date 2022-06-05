import 'package:app_vale_cv/bloc/user/user_bloc.dart';
import 'package:app_vale_cv/helpers/constants.dart';
import 'package:app_vale_cv/widgets/custom_elevated_button.dart';
import 'package:app_vale_cv/widgets/custom_fade_transition.dart';
import 'package:app_vale_cv/widgets/shake_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer';
// ignore: import_of_legacy_library_into_null_safe
import 'package:device_info/device_info.dart';
import 'dart:convert';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_appauth/flutter_appauth.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:app_vale_cv/pages/homepage/home_page.dart';
import 'dart:io';
import '../../widgets/custom_snackbar.dart';
import 'package:flutter/services.dart';

final FlutterAppAuth appAuth = FlutterAppAuth();
const FlutterSecureStorage secureStorage = FlutterSecureStorage();

/// -----------------------------------
///           Auth0 Variables
/// -----------------------------------

//const auth0_domain = 'https://kc.fconfia.com/realms/SistemaCV';
const auth0ClientId = 'uicv';
const auth0RedirectUri = 'com.fconfia.valescv://login-callback';
const auth0Issuer =
    'https://kc.fconfia.com/realms/SistemaCV/protocol/openid-connect/auth';
const auth0Logout =
    'https://kc.fconfia.com/realms/SistemaCV/ConfiaRestID/logout__token_id';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  // final _userController = TextEditingController();
  // final _passController = TextEditingController();
  final _customSnakBar = CustomSnackbar();

  bool isBusy = false;
  bool isLoggedIn = false;
  String errorMessage = '';
  String name = '';
  String email = '';
  String picture = '';
  int distribuidorId = 0;
  int grupoId = 0;
  int personaId = 0;
  int productoId = 0;
  int empresaId = 0;
  String sub = '';
  String sid = '';
  String acesoAppCobranza = '';
  String accespAppVales = '';

  String deviceName = '';
  String deviceVersion = '';
  String identifier = '';

/*   void _loginSubmit(UserBloc userBloc) {
    bool validate = _formKey.currentState!.validate();
    if (validate) {
      final user = User(nombre: 'Angel Confia', numeroDv: "000001");
      userBloc.add(ActivateUserEvent(user));
    }
  } */

  Map<String, dynamic> _parseIdToken(String idToken) {
    final parts = idToken.split(r'.');
    assert(parts.length == 3);

    return jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1]))));
  }

  Future<void> _deviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        setState(() {
          deviceName = build.model;
          deviceVersion = build.version.toString();
          identifier = build.androidId;
        });
        log('Android ${build.model}');
        log('Android ${build.version.toString()}');
        log('Android ${build.androidId}');
        //Secure storage
        await secureStorage.write(key: 'deviceName', value: deviceName);
        await secureStorage.write(key: 'deviceVersion', value: deviceVersion);
        await secureStorage.write(key: 'identifier', value: identifier);

        String identificador = await secureStorage.read(key: 'identifier');
        log('Android $identificador');
        //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        setState(() {
          deviceName = data.name;
          deviceVersion = data.systemVersion;
          identifier = data.identifierForVendor;
        }); //UUID for iOS
        log('iOS ${data.name}');
        log('iOS ${data.systemVersion}');
        log('iOS ${data.identifierForVendor}');
        //Secure storage
        await secureStorage.write(key: 'deviceName', value: deviceName);
        await secureStorage.write(key: 'deviceVersion', value: deviceVersion);
        await secureStorage.write(key: 'identifier', value: identifier);
      }
    } on PlatformException {
      debugPrint('Failed to get platform version');
    }
  }

  Future<void> _loginAction() async {
    setState(() {
      isBusy = true;
      errorMessage = '';
    });

    try {
      final AuthorizationTokenResponse result =
          await appAuth.authorizeAndExchangeCode(
        AuthorizationTokenRequest(
          auth0ClientId,
          auth0RedirectUri,
          issuer: 'https://kc.fconfia.com/realms/SistemaCV',
          scopes: ['openid', 'profile', 'offline_access'],
          // promptValues: ['login']
        ),
      );
      //Result to string to parse

      final idToken = _parseIdToken(result.idToken);
      // final profile = await getUserDetails(result.accessToken);

      await secureStorage.write(
          key: 'refresh_token', value: result.refreshToken);
      await secureStorage.write(key: 'access_token', value: result.accessToken);

      //Log reefreshToken
      log('refreshToken: ${result.refreshToken}');
      _deviceDetails();
      setState(() {
        isBusy = false;
        isLoggedIn = true;
        name = idToken['name'];
        distribuidorId = idToken['DistribuidorID'];
        grupoId = idToken['GrupoID'];
        personaId = idToken['PersonaID'];
        productoId = idToken['ProductoId'];
        empresaId = idToken['empresaId'];
        email = idToken['email'];
        sub = idToken['sub'];
        sid = idToken['sid'];
        acesoAppCobranza = idToken['AccesoAppCobranza'].toString();
        accespAppVales = idToken['AccesoAppVales'].toString();
      });

      await secureStorage.write(
          key: 'DistribuidorID', value: distribuidorId.toString());
      await secureStorage.write(key: 'GrupoID', value: grupoId.toString());
      await secureStorage.write(key: 'PersonaID', value: personaId.toString());
      await secureStorage.write(
          key: 'ProductoId', value: productoId.toString());
      await secureStorage.write(key: 'empresaId', value: empresaId.toString());
      await secureStorage.write(key: 'sub', value: sub);
      await secureStorage.write(key: 'sid', value: sid);
      await secureStorage.write(
          key: 'AccesoAppCobranza', value: acesoAppCobranza.toString());
      await secureStorage.write(
          key: 'AccesoAppVales', value: accespAppVales.toString());

      //Validar si tiene accespAppVales
      if (accespAppVales == 'true') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        _logout();
        //ignore: deprecated_member_use
        _scaffoldKey.currentState!.showSnackBar(const SnackBar(
          content: Text('No tiene permisos para acceder a la aplicación.'),
        ));
      }
    } catch (e) {
      // ignore: deprecated_member_use
      _scaffoldKey.currentState!.showSnackBar(const SnackBar(
        content: Text('Ocurrió un error al iniciar sesión.'),
      ));
      setState(() {
        isBusy = false;
        isLoggedIn = false;
        errorMessage = e.toString();
      });
    }
  }

  Future<void> _logout() async {
    //Alert with confirmation

    // final paramters = {
    //   'sub': '${await secureStorage.read(key: 'sub')}',
    //   'sid': '${await secureStorage.read(key: 'sid')}',
    // };
    final msg = jsonEncode({
      'sup': await secureStorage.read(key: 'sub'),
      'sid': await secureStorage.read(key: 'sid'),
    });

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    final response = await http.post(
        Uri.parse(
          auth0Logout,
        ),
        body: msg,
        headers: headers);

    if (response.statusCode == 200) {
      secureStorage.deleteAll();
    } else {
      log(response.body.toString());
      if (mounted) {
        SnackBar snackBar =
            _customSnakBar.error(msj: 'Ocurrió un error al cerrar sesión.');
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    }
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
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
          tweenBegin: 0.0,
          duration: const Duration(milliseconds: 3000),
          child: Column(
            children: [
              Hero(
                  tag: 'LogoLogin',
                  child: Image(
                      image: const AssetImage(Constants.assetsImagelogo2),
                      //color: Constants.colorDefault,
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
      // ShakeTransition(
      //     axis: Axis.vertical,
      //     duration: const Duration(milliseconds: 3000),
      //     child: Container(
      //       margin: EdgeInsets.only(bottom: height / 16),
      //       child: CustomTextField(
      //         label: 'Usuario',
      //         controller: _userController,
      //         icon: Icons.account_circle,
      //         enableUpperCase: true,
      //       ),
      //     )),
      // ShakeTransition(
      //     axis: Axis.vertical,
      //     duration: const Duration(milliseconds: 3000),
      //     child: Container(
      //       margin: EdgeInsets.only(bottom: height / 16),
      //       child: CustomTextField(
      //         label: 'Password',
      //         controller: _passController,
      //         icon: Icons.lock,
      //         isPassword: true,
      //         action: () => _loginSubmit(userBloc),
      //       ),
      //     )),
      ShakeTransition(
          axis: Axis.vertical,
          duration: const Duration(milliseconds: 3000),
          child: Container(
              //Two buttons
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: height / 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isBusy
                      ? const CircularProgressIndicator()
                      : CustomElevatedButton(
                          label: 'Iniciar Sesión',
                          action: () => _loginAction(),
                          //padding bottom
                          textColor: Constants.colorDefault,
                          primaryColor: Constants.colorAlternative,
                          borderColor: Constants.colorAlternative,
                        ),
                  //spacer
                  SizedBox(height: height / 50),
                  CustomElevatedButton(
                    label: 'Activar',
                    action: () => /* _loginAction() */ {},
                    textColor: Constants.colorDefault,
                    primaryColor: Constants.colorAlternative,
                    borderColor: Constants.colorAlternative,
                  ),
                ],
              ))),

      /*  isBusy
                  ? CircularProgressIndicator()
                  : CustomElevatedButton(
                      label: 'Iniciar Sesión',
                      action: () => _loginAction(),
                      textColor: Constants.colorDefault,
                      primaryColor: Constants.colorAlternative,
                      borderColor: Constants.colorAlternative,
                    ))), */
    ];

    return Form(
        key: _formKey,
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: width / 16),
            child: Column(children: content)));
  }

  @override
  void initState() {
    initAction();
    super.initState();
  }

  void initAction() async {
    /* setState(() {
      isBusy = true;
    }); */
    _deviceDetails();
    final storedRefreshToken = await secureStorage.read(key: 'refresh_token');
    log('storedRefreshToken: $storedRefreshToken');
    // ignore: unnecessary_null_comparison
    if (storedRefreshToken == null) {
      setState(() {
        isBusy = false;
      });
    } else {
      try {
        /*    Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        ); */
        final response = await appAuth.token(TokenRequest(
          auth0ClientId,
          auth0RedirectUri,
          issuer: auth0Issuer,
          refreshToken: storedRefreshToken,
        ));
        log("PASO PETICION");
        final idToken = _parseIdToken(response.idToken);
        //final profile = await getUserDetails(response.accessToken);
        secureStorage.write(key: 'refresh_token', value: response.refreshToken);

        setState(() {
          isBusy = false;
          isLoggedIn = true;
          name = idToken['name'];
          //picture = profile['picture'];
        });
      } catch (e, s) {
        debugPrint('error on refresh token: $e - stack: $s');
        // logoutAction();
      }
    }
  }
}
