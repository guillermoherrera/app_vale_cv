import 'package:app_vale_cv/bloc/plazos/plazos_bloc.dart';
import 'package:app_vale_cv/models/plazos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../bloc/solicitud_credito/solicitud_credito_bloc.dart';
import '../../helpers/constants.dart';
import '../../helpers/custom_route_transition.dart';
import '../../providers/api_cv.dart';
import '../../widgets/animator.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
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
  int _optionSelected = 0;
  int _importeSelected = 0;
  String _tipoPlazo = '';
  final _apiCV = ApiCV();
  Plazos _dataPlazos = Plazos();
  final List<Importe> _importes = [];
  late SolicitudCreditoState _info;
  final moneyF = NumberFormat("#,##0.00", "en_US");

  _getData() async {
    await Future.delayed(const Duration(seconds: 1));
    SolicitudCreditoState solicitudCredito =
        context.read<SolicitudCreditoBloc>().state;
    _dataPlazos = await _apiCV.getPlazosImporte(context);
    if (_dataPlazos.plazos.isNotEmpty)
      // ignore: curly_braces_in_flow_control_structures
      _optSelected(_dataPlazos.plazos[0].plazo);
    if (mounted) {
      setState(() {
        _info = solicitudCredito;
        _cargando = false;
      });
    }
  }

  _optSelected(int opt) {
    _importes.clear();
    Plazo plazo = _dataPlazos.plazos.firstWhere((e) => e.plazo == opt);
    _tipoPlazo = plazo.tipoPlazos![0]['tipoPlazoId'];
    for (var item in plazo.tipoPlazos![0]['importes']) {
      _importes.add(Importe(
          importe: item['importe'] / 1,
          importePagoPlazo: item['importePagoPlazo'] / 1));
    }

    if (_importes.isNotEmpty)
      // ignore: curly_braces_in_flow_control_structures
      _impSelected(_importeSelected);

    setState(() {
      _optionSelected = opt;
    });
  }

  _impSelected(int index) {
    int impSel = index > _importes.length - 1 ? 0 : index;
    setState(() {
      _importeSelected = impSel;
    });
  }

  _setData() {
    debugPrint(_optionSelected.toString());
    debugPrint(_importes[_importeSelected].importe.toString());
    debugPrint(_tipoPlazo);
    final solicitudBloc =
        BlocProvider.of<SolicitudCreditoBloc>(context, listen: false);
    solicitudBloc.add(AddPlazoImporte(
        _importes[_importeSelected].importe, _optionSelected, _tipoPlazo));
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
    return BlocBuilder<PlazosBloc, PlazosState>(builder: (context, state) {
      if (state.data!.plazos.isNotEmpty) {
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
              'SIN PLAZOS DISPONIBLES PARA ESTE CLIENTE',
              style: Constants.textStyleSubTitle,
              textAlign: TextAlign.center,
            )),
          ),
        ],
      ),
    );
  }

  Widget _listFill(PlazosState state) {
    return Column(
      children: [
        _fillHeader(),
        _fillBody(state),
        _optionSelected > -1 ? _button() : Container()
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
        _importes.isEmpty
            ? Container()
            : Column(
                children: [
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Constants.colorDefault,
                                boxShadow: [
                                  BoxShadow(
                                      color: _importeSelected == 0
                                          ? Constants.colorDefault
                                          : Constants.colorDefaultText,
                                      blurRadius: 10.0,
                                      offset: const Offset(2.0, 5.0)),
                                ]),
                            child: _importeSelected == 0
                                ? IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.remove,
                                        color: Constants.colorDefaultText))
                                : IconButton(
                                    onPressed: () {
                                      _impSelected(_importeSelected - 1);
                                    },
                                    icon: const Icon(Icons.remove,
                                        color: Constants.colorDefaultText))),
                        Text(
                          '\$${moneyF.format(_importes[_importeSelected].importe)}',
                          style: Constants.textStyleHeaderAlternative,
                          textAlign: TextAlign.center,
                        ),
                        Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Constants.colorDefault,
                                boxShadow: [
                                  BoxShadow(
                                      color: _importeSelected + 1 ==
                                              _importes.length
                                          ? Constants.colorDefault
                                          : Constants.colorDefaultText,
                                      blurRadius: 10.0,
                                      offset: const Offset(2.0, 5.0))
                                ]),
                            child: _importeSelected + 1 == _importes.length
                                ? IconButton(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add,
                                        color: Constants.colorDefaultText))
                                : IconButton(
                                    onPressed: () {
                                      _impSelected(_importeSelected + 1);
                                    },
                                    icon: const Icon(Icons.add,
                                        color: Constants.colorDefaultText))),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25.0, vertical: 5.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'PAGO POR PLAZO:',
                            style: Constants.textStyleSubTitle,
                          ),
                          Text(
                            '\$${moneyF.format(_importes[_importeSelected].importePagoPlazo)}',
                            style: Constants.textStyleSubTitleAlternative,
                          )
                        ]),
                  ),
                  const Divider(),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: const Text(
                      'PLAZOS',
                      style: Constants.textStyleSubTitle,
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
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

  Widget _fillBody(PlazosState state) {
    return Expanded(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: Wrap(
                alignment: WrapAlignment.center,
                children: state.data!.plazos.map((box) {
                  return WidgetAnimator(
                    child: GestureDetector(
                      onTap: () {
                        _optSelected(box.plazo);
                      },
                      child: Container(
                          margin: const EdgeInsets.all(10),
                          //color: Constants.colorDefault,
                          alignment: Alignment.center,
                          height: 100,
                          width: 100,
                          child: Text(
                            '${box.plazo}',
                            style: _optionSelected == box.plazo
                                ? Constants.textStyleSubTitleAlternative
                                : Constants.textStyleSubTitle,
                          ),
                          decoration: BoxDecoration(
                              color: Constants.colorDefault,
                              boxShadow: [
                                BoxShadow(
                                  color: _optionSelected == box.plazo
                                      ? Constants.colorAlternative
                                      : Constants.colorDefaultText,
                                  offset: const Offset(2.0, 5.0),
                                  blurRadius: 7.0,
                                ),
                              ],
                              border: Border.all(
                                  color: _optionSelected == box.plazo
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
            child: CustomElevatedButton(
                action: () {
                  _setData();
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
