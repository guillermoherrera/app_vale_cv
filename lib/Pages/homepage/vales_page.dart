import 'package:app_vale_cv/bloc/vales/vales_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:app_vale_cv/helpers/constants.dart';
import '../../bloc/solicitud_credito/solicitud_credito_bloc.dart';
import '../../helpers/custom_route_transition.dart';
import '../../providers/api_cv.dart';
import '../../widgets/animator.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/custom_shimmer.dart';

class ValesPages extends StatefulWidget {
  const ValesPages({Key? key}) : super(key: key);

  @override
  State<ValesPages> createState() => _ValesPagesState();
}

class _ValesPagesState extends State<ValesPages>
    with AutomaticKeepAliveClientMixin {
  final _customRoute = CustomRouteTransition();
  final _customShimmer = CustomShimmer();
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  final _apiCV = ApiCV();
  //List<int> _vales = [];
  bool _cargando = true;
  DateTime _dateGet = DateTime.now();
  final moneyF = NumberFormat("#,##0.00", "en_US");

  @override
  void initState() {
    _getVales();
    super.initState();
  }

  _getVales() async {
    await Future.delayed(const Duration(seconds: 1));
    await _apiCV.getVales(context);
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
        onRefresh: () => _getVales());
  }

  Widget _showResult() {
    return BlocBuilder<ValesBloc, ValesState>(builder: (context, state) {
      debugPrint('¿¿ ${state.toString()}');
      if (state.data!.vales.isNotEmpty) {
        return _listFill(state);
      } else {
        return _noData();
      }
    });
    //return _vales.isNotEmpty ? _listFill() : _noData();
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
              'SIN VALES POR MOSTRAR',
              style: Constants.textStyleSubTitle,
            )),
          ),
        ],
      ),
    );
  }

  Widget _listFill(ValesState state) {
    return Column(
      children: [_listFillHeader(state), const Divider(), _listFillBody(state)],
    );
  }

  Widget _listFillHeader(ValesState state) {
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
              const Text('VALES',
                  style: Constants.textStyleSubTitleAlternative),
              const Text('ULTIMA ACTUALIZACIÓN',
                  style: Constants.textStyleParagraph),
              Text(DateFormat('dd/MM/yyyy  kk:mm:ss').format(_dateGet),
                  style: Constants.textStyleParagraph)
            ],
          ),
          Column(
            children: [
              const Icon(Icons.confirmation_number,
                  color: Constants.colorAlternative),
              Text(
                '${state.data?.vales.length}',
                style: Constants.textStyleStandardAlternative,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _listFillBody(ValesState state) {
    return Expanded(
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView.builder(
                itemCount: state.data?.vales.length,
                itemBuilder: (_, index) {
                  if (index == state.data?.vales.length) {
                    return const SizedBox(height: 50.0);
                  }
                  return WidgetAnimator(
                      child: GestureDetector(
                          onTap: () {
                            final solicitudBloc =
                                BlocProvider.of<SolicitudCreditoBloc>(context,
                                    listen: false);
                            solicitudBloc.add(AddCreditoID(
                                state.data?.vales[index]?.creditoId));
                            Navigator.push(
                                context,
                                _customRoute
                                    .createRutaSlide(Constants.pageVale));
                          },
                          child: CustomListTile(
                              title: Text(
                                  '${state.data?.vales[index]?.nombreCliente}',
                                  style: Constants.textStyleStandard),
                              subTitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                      '${state.data?.vales[index]?.fhRegistro}'
                                          .substring(0, 10),
                                      style: Constants.textStyleParagraph),
                                  Text(
                                      '#${state.data?.vales[index]?.creditoId}',
                                      style: Constants.textStyleParagraph),
                                ],
                              ),
                              leading: const Icon(Icons.confirmation_number,
                                  color: Constants.colorDefaultText),
                              trailing: Column(
                                children: [
                                  Text(
                                      '\$${moneyF.format(state.data?.vales[index]?.importe)}',
                                      style: Constants
                                          .textStyleStandardAlternative),
                                  Text(
                                    '${state.data?.vales[index]?.status}',
                                    style: state.data?.vales[index]?.status !=
                                            'Activo'
                                        ? Constants.textStyleParagraphError
                                        : Constants.textStyleParagraph,
                                  ),
                                ],
                              ))));
                })));
  }

  @override
  bool get wantKeepAlive => true;
}
