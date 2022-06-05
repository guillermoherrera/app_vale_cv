import 'package:app_vale_cv/bloc/historial/historial_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/solicitud_credito/solicitud_credito_bloc.dart';
import '../../helpers/constants.dart';
import '../../helpers/custom_route_transition.dart';
import '../../providers/api_cv.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_shimmer.dart';
import '../../widgets/shake_transition.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({Key? key}) : super(key: key);

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  final _customRoute = CustomRouteTransition();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final _customShimmer = CustomShimmer();
  bool _cargando = true;
  final _apiCV = ApiCV();
  late SolicitudCreditoState _info;
  final moneyF = NumberFormat("#,##0.00", "en_US");

  _getInfo() async {
    await Future.delayed(const Duration(seconds: 1));
    SolicitudCreditoState solicitudCredito =
        context.read<SolicitudCreditoBloc>().state;
    await _apiCV.getHistorialCliente(context);
    if (mounted) {
      setState(() {
        _info = solicitudCredito;
        _cargando = false;
      });
    }
  }

  @override
  void initState() {
    _getInfo();
    super.initState();
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
        child: _cargando ? _customShimmer.infoVale() : _showResult(),
        onRefresh: () async => _getInfo());
  }

  Widget _showResult() {
    return BlocBuilder<HistorialBloc, HistorialState>(
        builder: (context, state) {
      if (state.data!.creditos.isNotEmpty) {
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
              'SIN HISTORIAL POR MOSTRAR',
              style: Constants.textStyleSubTitle,
            )),
          ),
        ],
      ),
    );
  }

  Widget _listFill(HistorialState state) {
    return Column(
      children: [_fillHeader(), _fillBody(state), _fillBodyP(state), _button()],
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
            'HISTORIAL',
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

  Widget _fillBody(HistorialState state) {
    return Expanded(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
                itemCount: state.data?.creditos.length,
                itemBuilder: (_, index) {
                  if (index == state.data?.creditos.length) {
                    return const SizedBox(height: 50.0);
                  }

                  return Column(
                    children: [
                      const Divider(),
                      Table(children: [
                        _tableRow(
                          const Text('VALE',
                              style: Constants.textStyleStandard),
                          Text('${state.data?.creditos[index].numVale}',
                              style: Constants.textStyleStandard),
                        ),
                        _tableRow(
                          const Text('FECHA INICIO',
                              style: Constants.textStyleStandard),
                          Text(
                              '${state.data?.creditos[index].fInicio.substring(0, 10)}',
                              style: Constants.textStyleStandard),
                        ),
                        _tableRow(
                          const Text('IMPORTE PRESTADO',
                              style: Constants.textStyleStandard),
                          Text(
                              '\$${moneyF.format(state.data?.creditos[index].importe)}',
                              style: Constants.textStyleStandard),
                        ),
                        _tableRow(
                          const Text('FECHA FIN',
                              style: Constants.textStyleStandard),
                          Text(
                              '${state.data?.creditos[index].fFinal.substring(0, 10)}',
                              style: Constants.textStyleStandard),
                        ),
                        _tableRow(
                          const Text('SALDO PENDIENTE',
                              style: Constants.textStyleStandard),
                          Text(
                              '\$${moneyF.format(state.data?.creditos[index].saldoPendiente)}',
                              style: Constants.textStyleStandard),
                        ),
                      ]),
                    ],
                  );
                })));
  }

  Widget _fillBodyP(HistorialState state) {
    // ignore: prefer_is_empty
    if (state.data?.creditoPendiente.length == 0) return const SizedBox();
    return Expanded(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
                itemCount: state.data?.creditoPendiente.length,
                itemBuilder: (_, index) {
                  if (index == state.data?.creditoPendiente.length) {
                    return const SizedBox(height: 50.0);
                  }

                  return Column(
                    children: [
                      const Divider(),
                      Table(children: [
                        _tableRow(
                          const Text('VALE',
                              style: Constants.textStyleStandard),
                          Text('${state.data?.creditoPendiente[index].numVale}',
                              style: Constants.textStyleStandard),
                        ),
                        _tableRow(
                          const Text('FECHA INICIO',
                              style: Constants.textStyleStandard),
                          Text('${state.data?.creditoPendiente[index].fInicio}',
                              style: Constants.textStyleStandard),
                        ),
                        _tableRow(
                          const Text('IMPORTE PRESTADO',
                              style: Constants.textStyleStandard),
                          Text(
                              '\$${state.data?.creditoPendiente[index].importe}',
                              style: Constants.textStyleStandard),
                        ),
                        _tableRow(
                          const Text('FECHA FIN',
                              style: Constants.textStyleStandard),
                          Text('${state.data?.creditoPendiente[index].fFinal}',
                              style: Constants.textStyleStandard),
                        ),
                        _tableRow(
                          const Text('SALDO PENDIENTE',
                              style: Constants.textStyleStandard),
                          Text(
                              '\$${state.data?.creditoPendiente[index].saldoPendiente}',
                              style: Constants.textStyleStandard),
                        ),
                      ]),
                    ],
                  );
                })));
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
                action: () {
                  Navigator.push(context,
                      _customRoute.createRutaSlide(Constants.pageDesembolso));
                },
                borderColor: Constants.colorAlternative,
                primaryColor: Constants.colorAlternative,
                textColor: Colors.white,
                label:
                    'SIGUIENTE' //'${!_enviando ? 'Guardar' : 'Enviando ...'}'
                ),
          )),
    );
  }
}
