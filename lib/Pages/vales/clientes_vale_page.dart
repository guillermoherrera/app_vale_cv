import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../helpers/constants.dart';
import '../../helpers/custom_route_transition.dart';
import '../../widgets/animator.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/custom_shimmer.dart';

class ClientesValePage extends StatefulWidget {
  const ClientesValePage({Key? key}) : super(key: key);

  @override
  State<ClientesValePage> createState() => _ClientesValePageState();
}

class _ClientesValePageState extends State<ClientesValePage> {
  final _customRoute = CustomRouteTransition();
  final _customShimmer = CustomShimmer();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  List<int> _clientes = [];
  bool _cargando = true;
  DateTime _dateGet = DateTime.now();

  @override
  void initState() {
    _getClientes();
    super.initState();
  }

  _getClientes() async {
    _clientes.clear();
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      setState(() {
        _clientes = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
        _cargando = false;
        _dateGet = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _appBar(),
        backgroundColor: Constants.colorPrimary,
        body: Column(
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
                      color: Constants.colorDefault, child: _bodyContent()),
                ),
              ),
            ),
          ],
        ));
  }

  PreferredSize _appBar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: CustomAppBar(),
    );
  }

  Widget _bodyContent() {
    return RefreshIndicator(
        key: _refreshKey,
        child: _cargando ? _customShimmer.listTiles() : _showResult(),
        onRefresh: () => _getClientes());
  }

  Widget _showResult() {
    return _clientes.isNotEmpty ? _listFill() : _noData();
  }

  Widget _noData() {
    return const Center(
        child: Text(
      'Sin clientes',
      style: Constants.textStyleSubTitle,
    ));
  }

  Widget _listFill() {
    return Column(
      children: [_listFillHeader(), const Divider(), _listFillBody()],
    );
  }

  Widget _listFillHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      decoration: const BoxDecoration(
          color: Constants.colorDefault,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          )),
      child: Column(
        children: [
          const Text('NUEVO VALE', style: Constants.textStyleSubTitle),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('CLIENTES', style: Constants.textStyleStandard),
                  const Text('ULTIMA ACTUALIZACIÓN',
                      style: Constants.textStyleParagraph),
                  Text(DateFormat('dd/MM/yyyy  kk:mm:ss').format(_dateGet),
                      style: Constants.textStyleParagraph),
                ],
              ),
              Column(
                children: [
                  const Icon(Icons.person, color: Constants.colorDefaultText),
                  Text('${_clientes.length}',
                      style: Constants.textStyleStandard)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _listFillBody() {
    return Expanded(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
                itemCount: _clientes.length,
                itemBuilder: (_, index) {
                  if (index == _clientes.length) {
                    return const SizedBox(height: 50.0);
                  }
                  return WidgetAnimator(
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                _customRoute
                                    .createRutaSlide(Constants.pageDesembolso));
                          },
                          child: CustomListTile(
                              title: Text(
                                  'NOMBRE COMPLETO DEL CLIENTE ${index + 1}',
                                  style: Constants.textStyleStandard),
                              subTitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('871-234567${index + 1}',
                                      style: Constants.textStyleParagraph),
                                  Text('ID CLIENTE ${index + 1}',
                                      style: Constants.textStyleParagraph),
                                ],
                              ),
                              leading: const Icon(Icons.person,
                                  color: Constants.colorDefaultText),
                              trailing: index % 3 != 0
                                  ? const Text(
                                      'SITUACIÓN\nNORMAL',
                                      style: Constants.textStyleParagraph,
                                    )
                                  : const Text('BLOQUEADO',
                                      style:
                                          Constants.textStyleParagraphError))));
                })));
  }
}
