import 'package:app_vale_cv/bloc/clientes/clientes_bloc.dart';
import 'package:app_vale_cv/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../helpers/constants.dart';
import 'package:app_vale_cv/widgets/custom_list_tile.dart';
import 'package:app_vale_cv/widgets/animator.dart';
import 'package:app_vale_cv/helpers/custom_route_transition.dart';

import '../../providers/api_cv.dart';

class ClientesPage extends StatefulWidget {
  const ClientesPage({Key? key}) : super(key: key);

  @override
  State<ClientesPage> createState() => _ClientesPageState();
}

class _ClientesPageState extends State<ClientesPage>
    with AutomaticKeepAliveClientMixin {
  final _customRoute = CustomRouteTransition();
  final _customShimmer = CustomShimmer();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  //List<int> _clientes = [];
  bool _cargando = true;
  DateTime _dateGet = DateTime.now();
  final _apiCV = ApiCV();

  @override
  void initState() {
    _getClientes();
    super.initState();
  }

  _getClientes() async {
    await Future.delayed(const Duration(seconds: 1));
    await _apiCV.getClientes(context);
    if (mounted) {
      setState(() {
        _cargando = false;
        _dateGet = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  color: Constants.colorSecondary, child: _bodyContent()),
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
        onRefresh: () => _getClientes());
  }

  Widget _showResult() {
    return BlocBuilder<ClientesBloc, ClientesState>(builder: (context, state) {
      if (state.data!.clientes.isNotEmpty) {
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
              'SIN CLIENTES POR MOSTRAR',
              style: Constants.textStyleSubTitle,
            )),
          ),
        ],
      ),
    );
  }

  Widget _listFill(ClientesState state) {
    return Column(
      children: [_listFillHeader(state), const Divider(), _listFillBody(state)],
    );
  }

  Widget _listFillHeader(ClientesState state) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      decoration: const BoxDecoration(
          color: Constants.colorSecondary,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('CLIENTES', style: Constants.textStyleSubTitleDefault),
              const Text('ULTIMA ACTUALIZACIÓN',
                  style: Constants.textStyleParagraphDefault),
              Text(DateFormat('dd/MM/yyyy  kk:mm:ss').format(_dateGet),
                  style: Constants.textStyleParagraphDefault),
            ],
          ),
          Column(
            children: [
              const Icon(Icons.person, color: Constants.colorDefault),
              Text('${state.data?.clientes.length}',
                  style: Constants.textStyleStandardDefault)
            ],
          )
        ],
      ),
    );
  }

  Widget _listFillBody(ClientesState state) {
    return Expanded(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
                itemCount: state.data?.clientes.length,
                itemBuilder: (_, index) {
                  if (index == state.data?.clientes.length) {
                    return const SizedBox(height: 50.0);
                  }
                  return WidgetAnimator(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                _customRoute
                                    .createRutaSlide(Constants.pageCliente));
                          },
                          child: CustomListTile(
                              title: Text(
                                  '${state.data?.clientes[index]?.primerNombre} ${state.data?.clientes[index]?.segundoNombre} ${state.data?.clientes[index]?.primerApellido} ${state.data?.clientes[index]?.segundoApellido} ',
                                  style: Constants.textStyleStandard),
                              subTitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${state.data?.clientes[index]?.telefono}',
                                      style: Constants.textStyleParagraph),
                                  Text(
                                      '#${state.data?.clientes[index]?.clienteId}',
                                      style: Constants.textStyleParagraph),
                                ],
                              ),
                              leading: const Icon(Icons.person,
                                  color: Constants.colorDefaultText),
                              trailing: Text(
                                '${state.data?.clientes[index]?.estatusDesc}',
                                style:
                                    state.data?.clientes[index]?.estatusId != 1
                                        ? Constants.textStyleParagraphError
                                        : Constants.textStyleParagraph,
                              ))));
                })));
  }

  @override
  bool get wantKeepAlive => true;
}
