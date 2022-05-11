import 'package:app_vale_cv/helpers/constants.dart';
import 'package:flutter/material.dart';

import '../../widgets/animator.dart';
import '../../widgets/custom_list_tile.dart';
import '../../widgets/custom_loading.dart';

class ValesPages extends StatefulWidget {
  const ValesPages({Key? key}) : super(key: key);

  @override
  State<ValesPages> createState() => _ValesPagesState();
}

class _ValesPagesState extends State<ValesPages> {
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  List<int> _vales = [];
  bool _cargando = true;

  @override
  void initState() {
    _getVales();
    super.initState();
  }

  _getVales() async {
    _vales.clear();
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      setState(() {
        _vales = [1, 2];
        _cargando = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
        child: _cargando
            ? const CustomLoading(
                label: 'CARGANDO VALES...',
              )
            : _showResult(),
        onRefresh: () => _getVales());
  }

  Widget _showResult() {
    return _vales.isNotEmpty ? _listFill() : _noData();
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
            children: const [
              Text('VALES', style: Constants.textStyleSubTitle),
              Text('REGISTRADOS', style: Constants.textStyleParagraph)
            ],
          ),
          Column(
            children: [
              const Icon(Icons.person, color: Constants.colorDefaultText),
              Text('${_vales.length}', style: Constants.textStyleStandard)
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
                itemCount: _vales.length,
                itemBuilder: (_, index) {
                  if (index == _vales.length) {
                    return const SizedBox(height: 50.0);
                  }
                  return WidgetAnimator(
                      child: GestureDetector(
                          onTap: () {
                            // ignore: avoid_print
                            print('print');
                          },
                          child: CustomListTile(
                              title: Text('NOMBRE CLIENTE ${index + 1}',
                                  style: Constants.textStyleStandard),
                              subTitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('01/01/2001 00:0${index + 1} am',
                                      style: Constants.textStyleParagraph),
                                ],
                              ),
                              leading: const Icon(Icons.confirmation_number,
                                  color: Constants.colorDefaultText),
                              trailing: index == 0
                                  ? const Text(
                                      'ACTIVO',
                                      style: Constants.textStyleParagraph,
                                    )
                                  : const Text('INACTIVO',
                                      style:
                                          Constants.textStyleParagraphError))));
                })));
  }
}
