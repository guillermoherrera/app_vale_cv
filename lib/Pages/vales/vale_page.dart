import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/custom_route_transition.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_loading.dart';

class ValePage extends StatefulWidget {
  const ValePage({Key? key}) : super(key: key);

  @override
  State<ValePage> createState() => _ValePageState();
}

class _ValePageState extends State<ValePage> {
  final _customRoute = CustomRouteTransition();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  bool _cargando = true;
  bool _withInfo = false;

  _getInfo() async {
    await Future.delayed(const Duration(seconds: 1));
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
      preferredSize: Size.fromHeight(100),
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
        child: _cargando
            ? const CustomLoading(
                label: 'CARGANDO INFORMACIÓN DE VALE...',
              )
            : _showResult(),
        // ignore: avoid_print
        onRefresh: () async => print('lol'));
  }

  Widget _showResult() {
    return _withInfo ? _listFill() : _noData();
  }

  Widget _noData() {
    return const Center(
        child: Text(
      'SIN INFORMACIÓN',
      style: Constants.textStyleSubTitle,
    ));
  }

  Widget _listFill() {
    return Column(
      children: [
        _FillHeader(),
        _ClienteInfo(),
        _infoGeneral(),
        _EstadoCuenta(),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget _FillHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Table(
        children: [
          _tableRow(
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  '#0000001',
                  style: Constants.textStyleTitle,
                ),
              ),
              Container()),
          _tableRow(
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('VALEDINERO', style: Constants.textStyleParagraph),
                  Text('01/01/01 00:00 AM', style: Constants.textStyleParagraph)
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('ESTATUS', style: Constants.textStyleParagraph),
                  Text('ACTIVO', style: Constants.textStyleParagraph)
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

  // ignore: non_constant_identifier_names
  Widget _ClienteInfo() {
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
                  children: const [
                    Flexible(
                      child: Text(
                        'NOMBRE COMPLETO DEL CLIENTE SELECCIONADO',
                        style: Constants.textStyleSubTitle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Icon(Icons.touch_app,
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
          const Text(
            '8711223344',
            style: Constants.textStyleStandard,
          ),
        ],
      ),
    );
  }

  Widget _infoGeneral() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('INFORMACIÓN GENERAL', style: Constants.textStyleSubTitle),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Table(
              children: [
                _tableRow(
                    const Text('MONTO TOTAL:',
                        style: Constants.textStyleStandard),
                    const Align(
                        alignment: Alignment.centerRight,
                        child: Text('\$1000.00',
                            style: Constants.textStyleStandard))),
                _tableRow(
                    const Text('MOTO PAGOS:',
                        style: Constants.textStyleStandard),
                    const Align(
                        alignment: Alignment.centerRight,
                        child: Text('\$100.00',
                            style: Constants.textStyleStandard))),
                _tableRow(
                    const Text('NO. QUINCENAS:',
                        style: Constants.textStyleStandard),
                    const Align(
                        alignment: Alignment.centerRight,
                        child: Text('12', style: Constants.textStyleStandard)))
              ],
            ),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget _EstadoCuenta() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('ESTADO DE CUENTA', style: Constants.textStyleSubTitle),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Table(
              children: [
                _tableRow(
                    const Text('MONTO TOTAL PAGADO:',
                        style: Constants.textStyleStandard),
                    const Align(
                        alignment: Alignment.centerRight,
                        child: Text('\$0.00',
                            style: Constants.textStyleStandard))),
                _tableRow(
                    const Text('QUINCENA ACTUAL:',
                        style: Constants.textStyleStandard),
                    const Align(
                        alignment: Alignment.centerRight,
                        child:
                            Text('1/12', style: Constants.textStyleStandard))),
              ],
            ),
          )
        ],
      ),
    );
  }
}
