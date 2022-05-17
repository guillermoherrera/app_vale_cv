import 'package:app_vale_cv/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../helpers/constants.dart';
import 'package:app_vale_cv/widgets/custom_loading.dart';
import 'package:app_vale_cv/widgets/custom_list_tile.dart';
import 'package:app_vale_cv/widgets/animator.dart';
import 'package:app_vale_cv/helpers/custom_route_transition.dart';

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
                  color: Constants.colorDefault, child: _bodyContent()),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('CLIENTES', style: Constants.textStyleSubTitle),
              const Text('ULTIMA ACTUALIZACIÓN',
                  style: Constants.textStyleParagraph),
              Text(DateFormat('dd/MM/yyyy  kk:mm:ss').format(_dateGet),
                  style: Constants.textStyleParagraph),
            ],
          ),
          Column(
            children: [
              const Icon(Icons.person, color: Constants.colorDefaultText),
              Text('${_clientes.length}', style: Constants.textStyleStandard)
            ],
          )
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
                                    .createRutaSlide(Constants.pageCliente));
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

  @override
  bool get wantKeepAlive => true;
}
