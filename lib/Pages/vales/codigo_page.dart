import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'dart:async';

import '../../bloc/solicitud_credito/solicitud_credito_bloc.dart';
import '../../helpers/constants.dart';
import '../../providers/api_cv.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/shake_transition.dart';

class CodigoPage extends StatefulWidget {
  const CodigoPage({Key? key}) : super(key: key);

  @override
  State<CodigoPage> createState() => _CodigoPageState();
}

class _CodigoPageState extends State<CodigoPage> {
  TextEditingController textEditingController = TextEditingController();
  StreamController<ErrorAnimationType>? errorController;
  final _customSnakBar = CustomSnackbar();
  final _apiCV = ApiCV();
  bool hasError = false;
  String currentText = "";
  final formKey = GlobalKey<FormState>();
  late SolicitudCreditoState _info;
  bool _solicitando = false;

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    _initialConfig();
    super.initState();
  }

  _initialConfig() async {
    SolicitudCreditoState solicitudCredito =
        context.read<SolicitudCreditoBloc>().state;
    setState(() {
      _info = solicitudCredito;
    });
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        SnackBar snackBar = _customSnakBar.message(
            msj:
                'ATENCIÓN:\n\nSE HA ENVIADO UN SMS AL TELÉFONO CONFIRMADO CON EL CÓDIGO DE CONFIRMACIÓN.\n\n\n\n',
            icon: Icons.error,
            backGroundColor: Constants.colorDefaultText,
            time: const Duration(seconds: 5));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      backgroundColor: Constants.colorPrimary,
      body: _body(),
    );
  }

  PreferredSize _appBar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(80),
      child: CustomAppBar(),
    );
  }

  Widget _body() {
    return Column(
      children: [_encabezado(), _resumen()],
    );
  }

  Widget _encabezado() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: const Icon(Icons.password_outlined,
                color: Constants.colorPrimary, size: 150),
            decoration: const BoxDecoration(
                color: Constants.colorDefault, shape: BoxShape.circle),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: const FittedBox(
              child: Text(
                'CÓDIGO ENVIADO',
                style: Constants.textStyleSubTitleDefault,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _resumen() {
    return Expanded(
        child: Container(
            color: Constants.colorDefault,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [_datos(), _codigo(), _button()],
            )));
  }

  Widget _datos() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          const Text('HEMOS ENVIADO TU CÓDIGO AL',
              style: Constants.textStyleSubTitle),
          Text(_info.data!.clienteTelefono, style: Constants.textStyleSubTitle),
        ],
      ),
    );
  }

  Widget _codigo() {
    return Expanded(
      child: Column(
        children: [
          Form(
            key: formKey,
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 0),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: const TextStyle(
                    color: Constants.colorPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 7,
                  blinkWhenObscuring: true,
                  animationType: AnimationType.fade,
                  validator: (v) {
                    if (v!.length < 7) {
                      return "INGRESA TODOS LOS CARACTERES DEL CÓDIGO";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    selectedColor: Constants.colorAlternative,
                    inactiveColor: Constants.colorPrimary,
                    disabledColor: Constants.colorSecondary,
                    activeColor: Constants.colorPrimary,
                    inactiveFillColor: Constants.colorDefault,
                    errorBorderColor: Colors.red,
                    selectedFillColor: Constants.colorDefault,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Constants.colorDefault,
                  ),
                  cursorColor: Constants.colorDefaultText,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  keyboardType: TextInputType.visiblePassword,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Constants.colorDefaultText,
                      blurRadius: 5,
                    )
                  ],
                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  onChanged: (value) {
                    debugPrint(value);
                    setState(() {
                      currentText = value;
                    });
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    return true;
                  },
                )),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Text(
              hasError
                  ? "\n*ERROR EN LA CAPTURA\n\n *POR FAVOR CONFIRMA EL CÓDIGO ENVIADO POR SMS."
                  : "",
              style: const TextStyle(
                  color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
            ),
          ),
        ],
      ),
    );
  }

  Widget _button() {
    return ShakeTransition(
      child: Container(
          decoration: const BoxDecoration(
              color: Constants.colorAlternative,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              )),
          width: double.infinity,
          height: 50,
          child: ShakeTransition(
            axis: Axis.vertical,
            offset: 140.0,
            duration: const Duration(milliseconds: 3000),
            child: _solicitando
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'VERIFICANDO... ',
                        style: TextStyle(
                            color: Constants.colorDefault,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                      CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                        Constants.colorDefault,
                      )),
                    ],
                  )
                : CustomElevatedButton(
                    action: () async {
                      bool validate = formKey.currentState!.validate();
                      if (validate)
                        // ignore: curly_braces_in_flow_control_structures
                        setState(() {
                          _solicitando = true;
                        });
                      bool res = !validate
                          ? validate
                          : await _apiCV.confirmarCodigo(context, currentText);
                      if (!res) {
                        errorController!.add(ErrorAnimationType
                            .shake); // Triggering error shake animation
                        setState(() {
                          hasError = true;
                          _solicitando = false;
                        });
                      } else {
                        setState(() {
                          hasError = false;
                          _solicitando = false;
                        });
                        SnackBar snackBar = _customSnakBar.success(
                            msj: 'CRÉDITO EXITOSO',
                            icon: Icons.check_circle,
                            msjSub:
                                'LA SOLICITUD DEL CRÉDITO SE HA COMPLETADO CORRECTAMENTE.');
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        await Future.delayed(const Duration(seconds: 1));
                        Navigator.of(context)
                            .popUntil((route) => route.isFirst);
                      }
                    },
                    borderColor: Constants.colorAlternative,
                    primaryColor: Constants.colorAlternative,
                    textColor: Colors.white,
                    label:
                        'CONFIRMAR' //'${!_enviando ? 'Guardar' : 'Enviando ...'}'
                    ),
          )),
    );
  }
}
