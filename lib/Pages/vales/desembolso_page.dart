import 'package:app_vale_cv/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/custom_route_transition.dart';
import '../../widgets/animator.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/custom_shimmer.dart';
import '../../widgets/shake_transition.dart';

class DesembolsoPage extends StatefulWidget {
  const DesembolsoPage({Key? key}) : super(key: key);

  @override
  State<DesembolsoPage> createState() => _DesembolsoPageState();
}

class _DesembolsoPageState extends State<DesembolsoPage> {
  final _customRoute = CustomRouteTransition();
  final _customShimmer = CustomShimmer();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  bool _cargando = true;
  bool _withInfo = false;
  List<int> _desembolsos = [];
  int optSelected = -1;

  _getData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _withInfo = true;
        _cargando = false;
        _desembolsos = [1, 2, 3];
      });
    }
  }

  _optSelected(int opt) {
    setState(() {
      optSelected = opt;
    });
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
        child: _cargando ? _customShimmer.listTiles() : _showResult(),
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
        optSelected > -1 ? _button() : Container()
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
            'SELECCIONA EL TIPO DE DESEMBOLSO',
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
            child: ListView.builder(
                itemCount: _desembolsos.length,
                itemBuilder: (_, index) {
                  if (index == _desembolsos.length) {
                    return const SizedBox(height: 50.0);
                  }
                  return WidgetAnimator(
                      child: GestureDetector(
                          onTap: () {
                            _optSelected(index);
                          },
                          child: CustomListTile(
                              title: Text(
                                  index == 0
                                      ? 'DEPOSITO BANCARIO'
                                      : 'FOLIO DIGITAL',
                                  style: optSelected == index
                                      ? Constants.textStyleSubTitleAlternative
                                      : Constants.textStyleSubTitle),
                              subTitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(index == 0 ? 'BANAMEX' : '',
                                      style: optSelected == index
                                          ? Constants
                                              .textStyleParagraphAlternative
                                          : Constants.textStyleParagraph),
                                  Text(
                                      index == 0
                                          ? '**** **** **** 1234'
                                          : 'EN SUCURSAL',
                                      style: optSelected == index
                                          ? Constants
                                              .textStyleParagraphAlternative
                                          : Constants.textStyleParagraph),
                                ],
                              ),
                              leading: Icon(Icons.credit_card,
                                  color: optSelected == index
                                      ? Constants.colorAlternative
                                      : Constants.colorDefaultText),
                              trailing: optSelected == index
                                  ? const Icon(
                                      Icons.check_box_outlined,
                                      color: Constants.colorAlternative,
                                    )
                                  : const Icon(
                                      Icons.check_box_outline_blank,
                                      color: Constants.colorDefaultText,
                                    ))));
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
                      _customRoute.createRutaSlide(Constants.pagePlazos));
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
