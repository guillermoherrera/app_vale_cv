import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/custom_route_transition.dart';
import '../../widgets/animator.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/custom_loading.dart';

class DestinoPage extends StatefulWidget {
  const DestinoPage({Key? key}) : super(key: key);

  @override
  State<DestinoPage> createState() => _DestinoPageState();
}

class _DestinoPageState extends State<DestinoPage> {
  final _customRoute = CustomRouteTransition();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  bool _cargando = true;
  bool _withInfo = false;
  List<int> _destinos = [];

  _getData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _withInfo = true;
        _cargando = false;
        _destinos = [1, 2, 3, 4];
      });
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
                label: 'CARGANDO DATOS DE DESTINOS...',
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
        _fillHeader(),
        _fillBody(),
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
                    child: const Text(
                      'NOMBRE COMPLETO DEL CLIENTE SELECCIONADO',
                      style: Constants.textStyleStandard,
                    ),
                  ),
                  Container()),
              _tableRow(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('8711223344', style: Constants.textStyleParagraph),
                    Text('ID #123456', style: Constants.textStyleParagraph)
                  ],
                ),
                const Text('SITUACIÓN \n NORMAL',
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

  Widget _fillBody() {
    return Expanded(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Wrap(
                alignment: WrapAlignment.center,
                children: _destinos.map((box) {
                  return WidgetAnimator(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            _customRoute
                                .createRutaSlide(Constants.pageDestinos));
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
                              box == 1
                                  ? 'SALUD'
                                  : box == 2
                                      ? 'EDUCACIÓN'
                                      : box == 3
                                          ? 'TRABAJO'
                                          : 'OTROS',
                              style: Constants.textStyleSubTitle,
                            ),
                          ),
                          decoration: BoxDecoration(
                              color: Constants.colorDefault,
                              border: Border.all(
                                  color: Constants.colorDefaultText,
                                  width: 3.0),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(25.0)))),
                    ),
                  );
                }).toList())));
  }
}
