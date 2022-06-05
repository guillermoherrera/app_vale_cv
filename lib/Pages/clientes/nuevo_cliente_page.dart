import 'package:app_vale_cv/bloc/asentamientos/asentamientos_bloc.dart';
import 'package:app_vale_cv/bloc/cliente/cliente_bloc.dart';
import 'package:app_vale_cv/helpers/utilerias.dart';
import 'package:app_vale_cv/models/cliente.dart';
import 'package:app_vale_cv/widgets/animator.dart';
import 'package:app_vale_cv/widgets/custom_drop_down_button.dart';
import 'package:app_vale_cv/widgets/custom_elevated_button.dart';
import 'package:app_vale_cv/widgets/custom_loading.dart';
import 'package:app_vale_cv/widgets/custom_text_field.dart';
import 'package:app_vale_cv/widgets/shake_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:intl/intl.dart';

import '../../helpers/constants.dart';
import '../../helpers/custom_route_transition.dart';
import '../../models/asentamientos.dart';
import '../../providers/api_cv.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/custom_snackbar.dart';

class NuevoClientePage extends StatefulWidget {
  const NuevoClientePage({Key? key}) : super(key: key);

  @override
  State<NuevoClientePage> createState() => _NuevoClientePageState();
}

class _NuevoClientePageState extends State<NuevoClientePage> {
  final _customSnakBar = CustomSnackbar();
  final _customRoute = CustomRouteTransition();
  final _customDialog = CustomDialog();
  final _apiCV = ApiCV();
  final _utilerias = Utilerias();
  final _formKeyDatos = GlobalKey<FormState>();
  final _curpController = TextEditingController();
  final _nombreController = TextEditingController();
  final _pApellidoController = TextEditingController();
  final _sApellidoController = TextEditingController();
  final _rfcController = TextEditingController();
  final _telefonoController = TextEditingController();
  final _codigoPostalController = TextEditingController();
  final _asentamientoIdController = TextEditingController();
  final _tipoVialidadController = TextEditingController();
  final _nombreVialidadController = TextEditingController();
  final _orientacionVialidadController = TextEditingController();
  final _numExteriorController = TextEditingController();
  final _numInteriorVialodadController = TextEditingController();
  bool _curpVerificada = false;
  bool _capturaDatos = false;
  bool _cargandoCurp = false;
  bool _cargandoCp = false;
  String _coloniaLabel = 'COLONIA, EJIDO, BARRIO, FRACCIONAMIENTO, ETC.';
  String _vialidadLabel = '';
  String _orientacionLabel = '';
  Color estadoColorSelected = Colors.grey.shade600;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _curpController.dispose();
    _nombreController.dispose();
    _pApellidoController.dispose();
    _sApellidoController.dispose();
    _rfcController.dispose();
    _telefonoController.dispose();
    _codigoPostalController.dispose();
    _asentamientoIdController.dispose();
    _tipoVialidadController.dispose();
    _nombreVialidadController.dispose();
    _orientacionVialidadController.dispose();
    _numExteriorController.dispose();
    _numInteriorVialodadController.dispose();
    super.dispose();
  }

  _consultaCurp() async {
    setState(() {
      _cargandoCurp = true;
    });
    if (_curpController.text.length == 18 &&
        _utilerias.checkCurp(context, _curpController.text)) {
      bool result = await _apiCV.consultaCurp(context, _curpController.text);
      if (result) {
        await Future.delayed(const Duration(seconds: 1));
        _confirmarDatos();
        setState(() {
          _cargandoCurp = false;
        });
      } else {
        setState(() {
          _capturaDatos = !result;
          _curpVerificada = !result;
          _cargandoCurp = false;
        });
      }
    } else {
      SnackBar snackBar = _customSnakBar.error(
          msj: 'POR FAVOR ASEGURATE DE CAPTURAR LA CURP CORRECTAMENTE',
          icon: Icons.error);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _cargandoCurp = false;
      });
    }
  }

  _confirmarCurp() {
    if (_curpController.text.length == 18) {
      _customDialog.show(context,
          willPop: false,
          title: 'LA CURP CAPTURADA ES CORRECTA?',
          textContent: 'CURP: ${_curpController.text}',
          cancelText: 'NO',
          continueText: 'SI', action: () {
        Navigator.pop(context);
        _consultaCurp();
      });
    } else {
      SnackBar snackBar = _customSnakBar.error(
          msj: 'POR FAVOR ASEGURATE DE CAPTURAR LA CURP CORRECTAMENTE',
          icon: Icons.error);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  _confirmarDatos() {
    ClienteState state = context.read<ClienteBloc>().state;
    Direccion direccion = state.data!.direcciones?.firstWhere(
        (e) => e.ultimaDireccion == true,
        orElse: () => Direccion());
    _customDialog.show(context,
        willPop: false,
        title: 'ESTOS SON LOS DATOS DEL CLIENTE?',
        textContent:
            'NOMBRE: ${state.data?.persona?.NombreCompleto}\nF.NACIMINETO: ${state.data?.persona?.FechaNacimiento?.substring(0, 10)}\nSEXO: ${state.data?.persona?.SexoID == 'M' ? 'MASCULINO' : state.data?.persona?.SexoID == 'F' ? 'FEMENINO' : 'INDEFINIDO'}\nRFC: ${state.data?.persona?.RFC}\nTELEFONO MOVIL: ${state.data?.persona?.TelefonoMovil}\n\nDIRECCIÓN: ${direccion.vialidadTipo} ${direccion.NombreVialidad} #${direccion.NumeroExterior} ${direccion.NumeroInterior} ${direccion.Asentamiento} ${direccion.CodigoPostal} (${direccion.Ciudad}) ${direccion.Municipio}, ${direccion.Estado}\n',
        cancelText: 'NO',
        continueText: 'SI', action: () {
      Navigator.pop(context);
      setState(() {
        _capturaDatos = false;
        _curpVerificada = true;
      });
      _fillTextFields(state, direccion);
    });
  }

  _fillTextFields(ClienteState state, Direccion direccion) {
    _nombreController.text = '${state.data?.persona?.Nombre}';
    _pApellidoController.text = '${state.data?.persona?.primerApellido}';
    _sApellidoController.text = '${state.data?.persona?.segundoApellido}';
    _rfcController.text = '${state.data?.persona?.RFC}';
    _telefonoController.text = '${state.data?.persona?.TelefonoMovil}';
    _codigoPostalController.text = '${direccion.CodigoPostal}';
    _asentamientoIdController.text = '${direccion.Asentamiento}';
    _tipoVialidadController.text = '${direccion.vialidadTipo}';
    _nombreVialidadController.text = '${direccion.NombreVialidad}';
    _orientacionVialidadController.text =
        '${direccion.orientacionVialidadTipoId}';
    _numExteriorController.text = '${direccion.NumeroExterior}';
    _numInteriorVialodadController.text = '${direccion.NumeroInterior}';
    setState(() {
      _coloniaLabel = '${direccion.Asentamiento}';
      _vialidadLabel = '${direccion.vialidadTipo}';
      _orientacionLabel = '${direccion.orientacionVialidadTipo}';
    });
  }

  _consultaCp() async {
    setState(() {
      _cargandoCp = true;
    });
    if (_codigoPostalController.text.length == 5) {
      FocusManager.instance.primaryFocus?.unfocus();
      Asentamientos res = await _apiCV.getAsentamientos(
          context, int.parse(_codigoPostalController.text));

      SnackBar snackBar = _customSnakBar.message(
          backGroundColor: res.asentamientos.isNotEmpty
              ? Constants.colorDefaultText
              : Constants.colorAlternative,
          msj: '${res.asentamientos.length} ASENTAMIENTOS ENCONTRADOS',
          icon: res.asentamientos.isNotEmpty
              ? Icons.check_circle_outline
              : Icons.error);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _cargandoCp = false;
      });
    } else {
      SnackBar snackBar = _customSnakBar.error(
          msj: 'POR FAVOR ASEGURATE DE CAPTURAR LA CÓDIGO POSTAL CORRECTAMENTE',
          icon: Icons.error);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      setState(() {
        _cargandoCp = false;
      });
    }
  }

  _guardarCliente() async {
    if (_formKeyDatos.currentState!.validate()) {
      _customDialog.show(
        context,
        icon: Icons.check_circle_outline,
        willPop: false,
        title: 'CONFIRMACION ALTA DE CLIENTE',
        textContent:
            'CONFIRMA QUE ANTES DE DAR DE ALTA AL CLIENTE HA REVISADO QUE SUS DATOS SEAN LOS CORRECTOS?',
        cancelText: 'VOLVER',
        continueText: 'SI',
        action: () async {
          Navigator.pop(context);

          SnackBar snackBar = _customSnakBar.success(
              msj: 'CLIENTE REGISTRADO CON EXITO',
              icon: Icons.check_circle,
              msjSub:
                  'EL CLIENTE AHORA ESTA RELACIONADO CON ESTA SOCIA DISTRIBUIDORA.');
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          await Future.delayed(const Duration(seconds: 1));
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      );
    } else {
      SnackBar snackBar = _customSnakBar.error(
          msj:
              'POR FAVOR ASEGURATE QUE TODOS LOS CAMPOS ESTEN CAPTURADOS CORRECTAMENTE',
          icon: Icons.error);
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Constants.colorPrimary,
      body: _body(),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: CustomAppBar(actions: [
        Container(
            margin: const EdgeInsets.only(right: 10.0),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Constants.colorPrimary,
                boxShadow: [
                  BoxShadow(
                    color: Constants.colorDefaultText,
                    blurRadius: 10.0,
                  ),
                ]),
            child: IconButton(
                icon: const Icon(Icons.delete_forever_outlined),
                onPressed: () {
                  _customDialog.show(
                    context,
                    icon: Icons.cleaning_services_rounded,
                    title: 'LIMPIAR FORMULARIO',
                    textContent:
                        'ESTA SEGURO(A) DE LIMPIAR EL FORMULARIO PARA VOLVERLO A CAPTURAR?.',
                    cancelText: 'NO',
                    continueText: 'SI, LIMPIAR',
                    action: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                          context,
                          _customRoute
                              .createRutaSlide(Constants.pageNuevoCliente));
                    },
                  );
                }))
      ]),
    );
  }

  Widget _body() {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                color: Constants.colorDefault,
                child: _bodyContent(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _bodyContent() {
    return BlocBuilder<ClienteBloc, ClienteState>(builder: (context, state) {
      return Column(
        children: [_listFillHeader(), const Divider(), _form(state)],
      );
    });
  }

  Widget _listFillHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      decoration: const BoxDecoration(
          color: Constants.colorDefault,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('NUEVO CLIENTE', style: Constants.textStyleSubTitle),
            ],
          ),
          Column(
            children: const [
              Icon(Icons.person_add, color: Constants.colorDefaultText),
            ],
          )
        ],
      ),
    );
  }

  Widget _form(ClienteState state) {
    return Expanded(
        child: Form(
            key: _formKeyDatos,
            child: SingleChildScrollView(
              child: Column(
                children: _formContent(state),
              ),
            )));
  }

  List<Widget> _formContent(ClienteState state) {
    return [
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            color: Constants.colorDefault,
            border: Border.all(color: Constants.colorDefaultText, width: 1.0),
            borderRadius: const BorderRadius.all(Radius.circular(25.0))),
        child: Column(children: [
          const Text('CURP', style: Constants.textStyleStandard),
          _curp(),
        ]),
      ),
      _curpVerificada
          ? WidgetAnimator(
              child: Container(
                margin: const EdgeInsets.only(top: 1.0, left: 5.0, right: 5.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    color: Constants.colorDefault,
                    border: Border.all(
                        color: Constants.colorDefaultText, width: 1.0),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(25.0))),
                child: Column(children: [
                  const Text('DATOS PERSONALES',
                      style: Constants.textStyleStandard),
                  _formDatos(),
                ]),
              ),
            )
          : Container(),
      _curpVerificada
          ? WidgetAnimator(
              child: Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 1.0, horizontal: 5.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    color: Constants.colorDefault,
                    border: Border.all(
                        color: Constants.colorDefaultText, width: 1.0),
                    borderRadius:
                        const BorderRadius.all(Radius.circular(25.0))),
                child: Column(children: [
                  const Text('DIRECCIÓN', style: Constants.textStyleStandard),
                  _formDireccion(state),
                ]),
              ),
            )
          : Container(),
      _curpVerificada ? _button() : Container()
    ];
  }

  Widget _flexPadding(Widget child, {bool isRight = false, int flex = 0}) {
    return Flexible(
        flex: flex,
        child: Padding(
            child: child,
            padding: EdgeInsets.only(
                top: 0.0,
                right: isRight ? 0.0 : 5.0,
                left: isRight ? 5.0 : 0.0)));
  }

  Widget _curp() {
    return Row(children: [
      _flexPadding(
          CustomTextField(
              label: 'CURP',
              controller: _curpController,
              maxLength: 18,
              enable: !_cargandoCurp && !_curpVerificada,
              checkMaxLength: true,
              enableUpperCase: true,
              textType: TextInputType.visiblePassword),
          flex: 2),
      _flexPadding(
          _cargandoCurp
              ? const CustomLoading(
                  color: Constants.colorAlternative,
                  label: 'VERIFICANDO CURP',
                )
              : _curpVerificada
                  ? Container(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      margin: const EdgeInsets.only(right: 0.0),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.check_circle_outline,
                            size: 30,
                            color: Constants.colorAlternative,
                          ),
                          Text(
                            'VERIFICADO',
                            style: Constants.textStyleStandard,
                          )
                        ],
                      ),
                    )
                  : ShakeTransition(
                      axis: Axis.vertical,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 20.0),
                        margin: const EdgeInsets.only(right: 0.0),
                        child: CustomElevatedButton(
                          elevation: 8.0,
                          borderColor: Constants.colorAlternative,
                          textColor: Constants.colorDefault,
                          primaryColor: Constants.colorAlternative,
                          label: 'VERIFICAR',
                          action: () => _confirmarCurp(),
                        ),
                      )),
          isRight: true,
          flex: 1)
    ]);
  }

  Widget _formDatos() {
    return Column(children: [
      _flexPadding(
        CustomTextField(
          label: 'NOMBRE(S)',
          controller: _nombreController,
          maxLength: 50,
          enableUpperCase: true,
          enable: _capturaDatos,
        ),
      ),
      Row(
        children: [
          _flexPadding(
              CustomTextField(
                label: 'PRIMER APELLIDO',
                controller: _pApellidoController,
                maxLength: 30,
                enableUpperCase: true,
                enable: _capturaDatos,
              ),
              flex: 1),
          _flexPadding(
              CustomTextField(
                label: 'SEGUNDO APELLIDO',
                controller: _sApellidoController,
                maxLength: 30,
                enableUpperCase: true,
                enable: _capturaDatos,
              ),
              flex: 1),
        ],
      ),
      Row(
        children: [
          _flexPadding(
              CustomTextField(
                label: 'RFC',
                controller: _rfcController,
                maxLength: 13,
                enableUpperCase: true,
                enable: _capturaDatos,
                textType: TextInputType.visiblePassword,
              ),
              flex: 1),
          _flexPadding(
              CustomTextField(
                label: 'TELÉFONO',
                controller: _telefonoController,
                maxLength: 10,
                enableUpperCase: true,
                enable: _capturaDatos,
                textType: TextInputType.number,
              ),
              flex: 1),
        ],
      ),
    ]);
  }

  Widget _formDireccion(ClienteState state) {
    Direccion direccion = state.data?.direcciones?.firstWhere(
        (e) => e.ultimaDireccion == true,
        orElse: () => Direccion());
    return Column(
      children: [
        Row(children: [
          _flexPadding(
              CustomTextField(
                label: 'CÓDIGO POSTAL',
                controller: _codigoPostalController,
                maxLength: 5,
                checkMaxLength: true,
                enableUpperCase: true,
                enable: _capturaDatos,
                textType: TextInputType.number,
              ),
              flex: 2),
          _flexPadding(
              !_capturaDatos
                  ? Container(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      margin: const EdgeInsets.only(right: 0.0),
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.check_circle_outline,
                            size: 30,
                            color: Constants.colorAlternative,
                          ),
                          Text(
                            'VERIFICADO',
                            style: Constants.textStyleStandard,
                          )
                        ],
                      ),
                    )
                  : _cargandoCp
                      ? const CustomLoading(
                          color: Constants.colorAlternative,
                          label: 'CONSULTANDO CP',
                        )
                      : ShakeTransition(
                          axis: Axis.vertical,
                          child: Container(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            margin: const EdgeInsets.only(right: 0.0),
                            child: CustomElevatedButton(
                              elevation: 8.0,
                              borderColor: Constants.colorAlternative,
                              textColor: Constants.colorDefault,
                              primaryColor: Constants.colorAlternative,
                              label: 'CONSULTAR',
                              action: () => _consultaCp(),
                            ),
                          )),
              isRight: true,
              flex: 1)
        ]),
        Row(
          children: [
            _flexPadding(_vialidadTipoField(), flex: 4),
            _flexPadding(
                CustomTextField(
                  label: 'NOMBRE CALLE, BLVR, ANDADOR, ETC.)',
                  controller: _nombreVialidadController,
                  maxLength: 50,
                  enableUpperCase: true,
                  enable: _capturaDatos,
                ),
                flex: 8),
          ],
        ),
        Row(
          children: [
            _flexPadding(_orientacionTipoField(), flex: 4),
            BlocBuilder<AsentamientosBloc, AsentamientosState>(
                builder: (context, state) {
              return _flexPadding(
                  _cargandoCp
                      ? const CustomLoading(
                          color: Constants.colorAlternative,
                          label: '',
                        )
                      : _asentamientosField(state),
                  flex: 8);
            }),
          ],
        ),
        Row(
          children: [
            _flexPadding(
                CustomTextField(
                  label: 'No EXTERIOR',
                  controller: _numExteriorController,
                  maxLength: 10,
                  enableUpperCase: true,
                  enable: _capturaDatos,
                ),
                flex: 1),
            _flexPadding(
                CustomTextField(
                  label: 'No INTERIOR',
                  controller: _numInteriorVialodadController,
                  maxLength: 10,
                  enableUpperCase: true,
                  enable: _capturaDatos,
                  checkEmpty: false,
                ),
                flex: 1),
          ],
        ),
        Text(
          // ignore: unnecessary_null_comparison
          direccion == null
              ? ''
              : '(${direccion.Ciudad}) ${direccion.Municipio}, ${direccion.Estado}',
          style: Constants.textStyleParagraph,
        )
      ],
    );
  }

  Widget _vialidadTipoField() {
    List<DropdownMenuItem<int>> items = [
      AsentamientoInfo(AsentamientoID: 1, Asentamiento: 'AMPLIACIÓN'),
      AsentamientoInfo(AsentamientoID: 2, Asentamiento: 'ANDADOR'),
      AsentamientoInfo(AsentamientoID: 3, Asentamiento: 'AVENIDA'),
      AsentamientoInfo(AsentamientoID: 4, Asentamiento: 'BOULEVARD'),
      AsentamientoInfo(AsentamientoID: 5, Asentamiento: 'CALLE'),
      AsentamientoInfo(AsentamientoID: 6, Asentamiento: 'CALLEJON'),
      AsentamientoInfo(AsentamientoID: 7, Asentamiento: 'CALZADA'),
      AsentamientoInfo(AsentamientoID: 8, Asentamiento: 'PERIFÉRICO'),
      AsentamientoInfo(AsentamientoID: 9, Asentamiento: 'PRIVADA'),
      AsentamientoInfo(AsentamientoID: 10, Asentamiento: 'PROLONGACION'),
    ]
        .map((f) => DropdownMenuItem<int>(
            child: Text('${f.Asentamiento}'), value: f.AsentamientoID))
        .toList();

    return CustomDropDownButton(
        label: _vialidadLabel,
        items: items,
        fieldController: _tipoVialidadController);
  }

  Widget _orientacionTipoField() {
    List<DropdownMenuItem<int>> items = [
      AsentamientoInfo(AsentamientoID: 1, Asentamiento: 'N/A'),
      AsentamientoInfo(AsentamientoID: 2, Asentamiento: 'NORTE'),
      AsentamientoInfo(AsentamientoID: 3, Asentamiento: 'SUR'),
      AsentamientoInfo(AsentamientoID: 4, Asentamiento: 'ESTE'),
      AsentamientoInfo(AsentamientoID: 5, Asentamiento: 'OESTE'),
    ]
        .map((f) => DropdownMenuItem<int>(
            child: Text('${f.Asentamiento}'), value: f.AsentamientoID))
        .toList();

    return CustomDropDownButton(
        label: _orientacionLabel,
        items: items,
        fieldController: _tipoVialidadController);
  }

  Widget _asentamientosField(AsentamientosState state) {
    // [
    //   AsentamientoInfo(AsentamientoID: 1, Asentamiento: 'lol'),
    //   AsentamientoInfo(AsentamientoID: 2, Asentamiento: 'cat')
    // ]
    List<DropdownMenuItem<int>> items = state.data!.asentamientos
        .map((f) => DropdownMenuItem<int>(
            child: Text('${f.Asentamiento}'), value: f.AsentamientoID))
        .toList();

    return CustomDropDownButton(
        label: _coloniaLabel,
        items: items,
        fieldController: _asentamientoIdController);
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
            child: CustomElevatedButton(
                action: () => _guardarCliente(),
                borderColor: Constants.colorAlternative,
                primaryColor: Constants.colorAlternative,
                textColor: Colors.white,
                label:
                    'GUARDAR CLIENTE' //'${!_enviando ? 'Guardar' : 'Enviando ...'}'
                ),
          )),
    );
  }
}
