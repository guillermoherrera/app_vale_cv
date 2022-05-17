import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../helpers/custom_route_transition.dart';
import '../../widgets/animator.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/custom_loading.dart';
import '../../widgets/custom_shimmer.dart';
import '../../widgets/shake_transition.dart';

class PlazosPage extends StatefulWidget {
  const PlazosPage({Key? key}) : super(key: key);

  @override
  State<PlazosPage> createState() => _PlazosPageState();
}

class _PlazosPageState extends State<PlazosPage> {
  final _customRoute = CustomRouteTransition();
  final _customShimmer = CustomShimmer();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  bool _cargando = true;
  bool _withInfo = false;
  List<int> _plazos = [];
  int optSelected = -1;

  _getData() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _withInfo = true;
        _cargando = false;
        _plazos = [0, 1, 2, 3, 4];
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
        child: _cargando ? _customShimmer.listWrap() : _showResult(),
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
            'CALCULA TU VALE',
            style: Constants.textStyleTitle,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: const Text(
            '\$1000.00',
            style: Constants.textStyleTitle,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'PAGO QUINCENAL:',
                  style: Constants.textStyleSubTitle,
                ),
                Text(
                  '\$125.00',
                  style: Constants.textStyleSubTitle,
                )
              ]),
        ),
        const Divider(),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: const Text(
            'QUINCENAS',
            style: Constants.textStyleSubTitle,
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
                children: _plazos.map((box) {
                  return WidgetAnimator(
                    child: GestureDetector(
                      onTap: () {
                        _optSelected(box);
                      },
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          //color: Constants.colorDefault,
                          alignment: Alignment.center,
                          height: 100,
                          width: 100,
                          child: Text(
                            '${box * 2 + 4}',
                            style: optSelected == box
                                ? Constants.textStyleSubTitleAlternative
                                : Constants.textStyleSubTitle,
                          ),
                          decoration: BoxDecoration(
                              color: Constants.colorDefault,
                              border: Border.all(
                                  color: optSelected == box
                                      ? Constants.colorAlternative
                                      : Constants.colorDefaultText,
                                  width: 3.0),
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
            child: CustomElevatedButton(
                action: () {
                  Navigator.push(context,
                      _customRoute.createRutaSlide(Constants.pageDestinos));
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
