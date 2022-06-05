import 'package:app_vale_cv/bloc/destinos/destinos_bloc.dart';
import 'package:app_vale_cv/widgets/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/solicitud_credito/solicitud_credito_bloc.dart';
import '../../helpers/constants.dart';
import '../../helpers/custom_route_transition.dart';
import '../../providers/api_cv.dart';
import '../../widgets/animator.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_dialog.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shimmer.dart';
import '../../widgets/custom_snackbar.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/shake_transition.dart';

class DestinoPage extends StatefulWidget {
  const DestinoPage({Key? key}) : super(key: key);

  @override
  State<DestinoPage> createState() => _DestinoPageState();
}

class _DestinoPageState extends State<DestinoPage> {
  final _customDialog = CustomDialog();
  final _customRoute = CustomRouteTransition();
  final _customShimmer = CustomShimmer();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final _customSnakBar = CustomSnackbar();
  final formKey = GlobalKey<FormState>();
  final _telefonoCliente = TextEditingController();
  bool _cargando = true;
  int optSelected = 0;
  final _apiCV = ApiCV();
  late SolicitudCreditoState _info;
  bool _solicitando = false;

  _getData() async {
    await Future.delayed(const Duration(seconds: 1));
    SolicitudCreditoState solicitudCredito =
        context.read<SolicitudCreditoBloc>().state;
    await _apiCV.getDestinos(context);
    if (mounted) {
      setState(() {
        _info = solicitudCredito;
        _cargando = false;
      });
    }
  }

  _optSelected(int opt) {
    setState(() {
      optSelected = opt;
    });
  }

  _actulizaTelefono() async {
    if (formKey.currentState?.validate() == true) {
      FocusManager.instance.primaryFocus?.unfocus();
      final solicitudBloc =
          BlocProvider.of<SolicitudCreditoBloc>(context, listen: false);
      solicitudBloc.add(AddTelefono(_telefonoCliente.text));
      _enviarSmsRequest();
    }
  }

  _enviarSmsRequest() async {
    if (_solicitando)
      // ignore: curly_braces_in_flow_control_structures
      ScaffoldMessenger.of(context).showSnackBar(_customSnakBar.message(
          msj: 'LA SOLICITUD ESTA EN PROCESO, POR FAVOR ESPERE...',
          icon: Icons.watch_later_outlined));
    setState(() {
      _solicitando = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    bool res = await _apiCV.enviarSMSCredito(context);
    if (res) {
      Navigator.pop(context);
      Navigator.push(
          context, _customRoute.createRutaSlide(Constants.pageCodigo));
    }
    setState(() {
      _solicitando = false;
    });
  }

  _solicitar() async {
    setState(() {
      _solicitando = true;
    });
    await Future.delayed(const Duration(seconds: 1));
    bool res = await _apiCV.solicitarCredito(context);
    setState(() {
      _solicitando = false;
    });
    if (res) {
      _customDialog.show(context,
          title: 'ENVÍO SMS',
          willPop: false,
          textContent:
              'SE ENVIARÁ UN MENSAJE DE TEXTO CON EL CÓDIGO DE CONFIRMACIÓN AL NÚMERO:\n\n ${_info.data!.clienteTelefono}\n\n ¿ES CORRECTO EL TELÉFONO DEL CLIENTE?',
          cancelText: 'NO',
          continueText: 'SI, ENVIAR SMS',
          cancelAction: () => _usarOtroTelefono(),
          action: () => _enviarSmsRequest());
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
    return RefreshIndicator(
        key: _refreshKey,
        child: _cargando ? _customShimmer.listWrap() : _showResult(),
        // ignore: avoid_print
        onRefresh: () async => print('lol'));
  }

  Widget _showResult() {
    return BlocBuilder<DestinosBloc, DestinosState>(builder: (context, state) {
      if (state.data!.destinos.isNotEmpty) {
        return _listFill(state);
      } else {
        return _noData();
      }
    });
  }

  Widget _noData() {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: const [
          SizedBox(
            height: 600.0,
            child: Center(
                child: Text(
              'SIN DESTINOS PARA ESTE CLIENTE',
              style: Constants.textStyleSubTitle,
              textAlign: TextAlign.center,
            )),
          ),
        ],
      ),
    );
  }

  Widget _listFill(DestinosState state) {
    return Column(
      children: [
        _fillHeader(),
        _fillBody(state),
        optSelected > 0 ? _button() : Container()
      ],
    );
  }

  Widget _fillHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Table(
            children: [
              _tableRow(
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Text(
                      '${_info.data?.clienteNombre}',
                      style: Constants.textStyleStandard,
                    ),
                  ),
                  Container()),
              _tableRow(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${_info.data?.clienteTelefono}',
                        style: Constants.textStyleParagraph),
                    Text('#${_info.data?.clienteID}',
                        style: Constants.textStyleParagraph)
                  ],
                ),
                Text('${_info.data?.clienteEstatusDesc}',
                    style: Constants.textStyleParagraph),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: const Text(
            'SELECCIONA EL MOTIVO DEL PRESTAMO',
            style: Constants.textStyleTitle,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  TableRow _tableRow(Widget _left, Widget _right) {
    return TableRow(children: [
      Container(
        child: _left,
        padding: const EdgeInsets.all(5.0),
      ),
      Container(
        child: Align(
          child: _right,
          alignment: Alignment.centerRight,
        ),
        padding: const EdgeInsets.all(5.0),
      ),
    ]);
  }

  Widget _fillBody(DestinosState state) {
    return Expanded(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Wrap(
                alignment: WrapAlignment.center,
                children: state.data!.destinos.map((box) {
                  return WidgetAnimator(
                    child: GestureDetector(
                      onTap: () {
                        _optSelected(box.motivoTipoId);
                      },
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.all(3),
                          //color: Constants.colorDefault,
                          alignment: Alignment.center,
                          height: 100,
                          width: 100,
                          child: FittedBox(
                            child: Text(
                              '${box.motivoTipoDesc}',
                              style: optSelected == box.motivoTipoId
                                  ? Constants.textStyleSubTitleAlternative
                                  : Constants.textStyleSubTitle,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Constants.colorDefault,
                              boxShadow: [
                                BoxShadow(
                                  color: optSelected == box.motivoTipoId
                                      ? Constants.colorAlternative
                                      : Constants.colorDefaultText,
                                  offset: const Offset(2.0, 5.0),
                                  blurRadius: 7.0,
                                ),
                              ],
                              border: Border.all(
                                  color: optSelected == box.motivoTipoId
                                      ? Constants.colorAlternative
                                      : Constants.colorDefaultText,
                                  width: 1.0),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(25.0)))),
                    ),
                  );
                }).toList())));
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
                        'SOLICITANDO... ',
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
                    action: () => _solicitar(),
                    borderColor: Constants.colorAlternative,
                    primaryColor: Constants.colorAlternative,
                    textColor: Constants.colorDefault,
                    label: 'SOLICITAR'),
          )),
    );
  }

  void _usarOtroTelefono() {
    Navigator.pop(context);
    _customDialog.show(context,
        willPop: false,
        title: 'ENVÍO SMS',
        offset: 50,
        textContent:
            'INGRESA EL NÚMERO DE TELÉFONO DEL CLIENTE PARA PODER VALIDAR EL CRÉDITO SOLICITADO\n\n',
        cancelText: 'CANCELAR',
        continueText: 'ENVIAR SMS',
        form: _form(),
        action: () => _actulizaTelefono());
  }

  Widget _form() {
    return Form(
        key: formKey,
        child: CustomTextField(
          label: 'INGRESA AQUI EL NÚMERO DE TELÉFONO',
          controller: _telefonoCliente,
          icon: Icons.phone_iphone,
          maxLength: 10,
          textType: TextInputType.number,
          checkMaxLength: true,
        ));
  }
}
