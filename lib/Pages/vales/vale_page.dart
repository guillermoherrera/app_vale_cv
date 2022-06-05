import 'package:app_vale_cv/bloc/vale_detalle/vale_detalle_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../helpers/constants.dart';
import '../../helpers/custom_route_transition.dart';
import '../../providers/api_cv.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_shimmer.dart';

class ValePage extends StatefulWidget {
  const ValePage({Key? key}) : super(key: key);

  @override
  State<ValePage> createState() => _ValePageState();
}

class _ValePageState extends State<ValePage> {
  final _customRoute = CustomRouteTransition();
  final _customShimmer = CustomShimmer();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  bool _cargando = true;
  bool _withInfo = false;
  final _apiCV = ApiCV();
  final moneyF = NumberFormat("#,##0.00", "en_US");

  _getInfo() async {
    await Future.delayed(const Duration(seconds: 1));
    await _apiCV.getValeDetalle(context);
    if (mounted) {
      setState(() {
        _withInfo = true;
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
        // ignore: avoid_print
        onRefresh: () async => print('lol'));
  }

  Widget _showResult() {
    return BlocBuilder<ValeDetalleBloc, ValeDetalleState>(
        builder: (context, state) {
      debugPrint('¿¿ ${state.toString()}');
      if (state.data!.noCredito > 0) {
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
              'LA INFORMACIÓN NO PUDO CARGARSE',
              style: Constants.textStyleSubTitle,
              textAlign: TextAlign.center,
            )),
          ),
        ],
      ),
    );
  }

  Widget _listFill(ValeDetalleState state) {
    return Column(
      children: [
        _fillHeader(state),
        _clienteInfo(state),
        _infoGeneral(state),
        _estadoCuenta(state),
      ],
    );
  }

  Widget _fillHeader(ValeDetalleState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Table(
        children: [
          _tableRow(
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  '#${state.data!.folio}',
                  style: Constants.textStyleTitleAlternative,
                ),
              ),
              Container()),
          _tableRow(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('VALEDINERO', style: Constants.textStyleParagraph),
                  Text(state.data!.fechaCredito.substring(0, 10),
                      style: Constants.textStyleParagraph)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ESTATUS', style: Constants.textStyleParagraph),
                  Text(state.data!.status, style: Constants.textStyleParagraph)
                ],
              )),
        ],
      ),
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

  Widget _clienteInfo(ValeDetalleState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Expanded(
              flex: 8,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      _customRoute.createRutaSlide(Constants.pageCliente));
                },
                child: Row(
                  children: [
                    Flexible(
                      child: Text(
                        state.data!.nombreCliente,
                        style: Constants.textStyleSubTitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Icon(Icons.touch_app,
                        color: Constants.colorDefaultText, size: 18)
                  ],
                ),
              ),
            ),
            Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Icon(Icons.call),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(const CircleBorder()),
                      backgroundColor: MaterialStateProperty.all(
                          Constants.colorDefaultText)),
                )),
          ]),
          Text(
            state.data!.telefono,
            style: Constants.textStyleStandard,
          ),
        ],
      ),
    );
  }

  Widget _infoGeneral(ValeDetalleState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('INFORMACIÓN GENERAL',
              style: Constants.textStyleSubTitleAlternative),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Table(
              children: [
                _tableRow(
                    const Text('MONTO TOTAL:',
                        style: Constants.textStyleStandard),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text('\$${moneyF.format(state.data!.monto)}',
                            style: Constants.textStyleStandard))),
                _tableRow(
                    const Text('MOTO PAGOS:',
                        style: Constants.textStyleStandard),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text('\$${moneyF.format(state.data!.montoPago)}',
                            style: Constants.textStyleStandard))),
                _tableRow(
                    const Text('NO. PLAZOS:',
                        style: Constants.textStyleStandard),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text('${state.data!.plazos}',
                            style: Constants.textStyleStandard)))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _estadoCuenta(ValeDetalleState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ESTADO DE CUENTA',
              style: Constants.textStyleSubTitleAlternative),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Table(
              children: [
                _tableRow(
                    const Text('MONTO TOTAL PAGADO:',
                        style: Constants.textStyleStandard),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            '\$${moneyF.format(state.data!.saldoPagado)}',
                            style: Constants.textStyleStandard))),
                _tableRow(
                    const Text('QUINCENA ACTUAL:',
                        style: Constants.textStyleStandard),
                    Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            '${state.data!.plazoActual}/${state.data!.plazos}',
                            style: Constants.textStyleStandard))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
