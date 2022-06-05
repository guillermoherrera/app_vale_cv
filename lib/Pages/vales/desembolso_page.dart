import 'package:app_vale_cv/bloc/desembolsos/desembolsos_bloc.dart';
import 'package:app_vale_cv/widgets/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/solicitud_credito/solicitud_credito_bloc.dart';
import '../../helpers/constants.dart';
import '../../helpers/custom_route_transition.dart';
import '../../providers/api_cv.dart';
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
  int optSelected = -1;
  final _apiCV = ApiCV();
  late SolicitudCreditoState _info;

  _getData() async {
    await Future.delayed(const Duration(seconds: 1));
    SolicitudCreditoState solicitudCredito =
        context.read<SolicitudCreditoBloc>().state;
    await _apiCV.getDesembolsosTipos(context);
    if (mounted) {
      setState(() {
        _info = solicitudCredito;
        _cargando = false;
      });
    }
  }

  _optSelected(int opt) {
    final solicitudBloc =
        BlocProvider.of<SolicitudCreditoBloc>(context, listen: false);
    solicitudBloc.add(AddDesembolsoID(opt));
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
        child: _cargando ? _customShimmer.listTiles() : _showResult(),
        // ignore: avoid_print
        onRefresh: () async => _getData());
  }

  Widget _showResult() {
    return BlocBuilder<DesembolsosBloc, DesembolsosState>(
        builder: (context, state) {
      if (state.data!.desembolsos.isNotEmpty) {
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
              'SIN DESEMBOLSOS DISPONIBLES PARA ESTE CLIENTE',
              style: Constants.textStyleSubTitle,
              textAlign: TextAlign.center,
            )),
          ),
        ],
      ),
    );
  }

  Widget _listFill(DesembolsosState state) {
    return Column(
      children: [
        _fillHeader(),
        _fillBody(state),
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

  Widget _fillBody(DesembolsosState state) {
    return Expanded(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
                itemCount: state.data?.desembolsos.length,
                itemBuilder: (_, index) {
                  if (index == state.data?.desembolsos.length) {
                    return const SizedBox(height: 50.0);
                  }
                  return WidgetAnimator(
                      child: GestureDetector(
                          onTap: () {
                            _optSelected(state
                                .data?.desembolsos[index].desembolsoTipoId);
                          },
                          child: CustomListTile(
                              title: Text(
                                  '${state.data?.desembolsos[index].desembolsoTipoDesc}',
                                  style: optSelected ==
                                          state.data?.desembolsos[index]
                                              .desembolsoTipoId
                                      ? Constants.textStyleSubTitleAlternative
                                      : Constants.textStyleSubTitle),
                              subTitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${state.data?.desembolsos[index].nombreBanco == '' ? '' : state.data?.desembolsos[index].nombreBanco}',
                                      style: optSelected ==
                                              state.data?.desembolsos[index]
                                                  .desembolsoTipoId
                                          ? Constants
                                              .textStyleParagraphAlternative
                                          : Constants.textStyleParagraph),
                                  Text(
                                      '${state.data?.desembolsos[index].numeroTarjeta == '' ? '' : state.data?.desembolsos[index].numeroTarjeta}',
                                      style: optSelected ==
                                              state.data?.desembolsos[index]
                                                  .desembolsoTipoId
                                          ? Constants
                                              .textStyleParagraphAlternative
                                          : Constants.textStyleParagraph),
                                ],
                              ),
                              leading: Icon(Icons.credit_card,
                                  color: optSelected ==
                                          state.data?.desembolsos[index]
                                              .desembolsoTipoId
                                      ? Constants.colorAlternative
                                      : Constants.colorDefaultText),
                              trailing: optSelected ==
                                      state.data?.desembolsos[index]
                                          .desembolsoTipoId
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
