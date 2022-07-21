import 'package:app_vale_cv/bloc/dv_lineas/dv_lineas_bloc.dart';
import 'package:app_vale_cv/bloc/dv_saldos/dv_saldos_bloc.dart';
import 'package:app_vale_cv/models/dv_lineas.dart';
import 'package:app_vale_cv/widgets/animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:app_vale_cv/widgets/custom_elevated_button.dart';
import '../../helpers/constants.dart';
import '../../helpers/custom_route_transition.dart';
import '../../providers/api_cv.dart';
import '../../widgets/custom_card_swiper.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage>
    with AutomaticKeepAliveClientMixin {
  final _customRoute = CustomRouteTransition();
  final _refreshKey = GlobalKey<RefreshIndicatorState>();
  final _apiCV = ApiCV();
  DateTime _dateGet = DateTime.now();
  final moneyF = NumberFormat("#,##0.00", "en_US");

  _getData() async {
    await _apiCV.getDvinfo(context);
    await _apiCV.getDvLineas(context);
    await _apiCV.getDvSaldos(context);
    if (mounted) {
      setState(() {
        _dateGet = DateTime.now();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      key: _refreshKey,
      onRefresh: () => _getData(),
      child: SingleChildScrollView(child:
          BlocBuilder<DvLineaBloc, DvLineasState>(builder: (context, state) {
        return Column(
          children: [
            //_colocaGana(),
            _cardSaldo2(),
            //_saldoDetalle(state),
            _miSaldo(state),
            _nuevoCredito(state),
            BlocBuilder<DvSaldoBloc, DvSaldosState>(
                builder: (context, stateSaldos) {
              return _resumenRelacion(stateSaldos);
            }),
            _relacion(state)
          ],
        );
      })),
    );
  }

  // Widget _colocaGana() {
  //   return Container(
  //     width: double.infinity,
  //     height: 100.0,
  //     margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
  //     child: ClipRRect(
  //       borderRadius: BorderRadius.circular(20.0),
  //       child: Container(
  //         color: Constants.colorDefaultText.withOpacity(0.2),
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             Container(
  //                 margin: const EdgeInsets.symmetric(
  //                     vertical: 8.0, horizontal: 15.0),
  //                 child: const Text('COLOCA Y GANA',
  //                     style: Constants.textStyleSubTitleDefault)),
  //             Container(
  //               padding: const EdgeInsets.symmetric(horizontal: 15.0),
  //               child: Stack(
  //                 children: const [
  //                   LinearProgressIndicator(
  //                     color: Constants.colorPrimary,
  //                     backgroundColor: Constants.colorDefault,
  //                     minHeight: 30.0,
  //                     value: .50,
  //                   ),
  //                   Align(
  //                     child:
  //                         Text("\$1000.00", style: Constants.textStyleSubTitle),
  //                     alignment: Alignment.center,
  //                   ),
  //                 ],
  //               ),
  //             ),
  //             Container(
  //                 width: double.infinity,
  //                 margin: const EdgeInsets.symmetric(
  //                     vertical: 1.0, horizontal: 15.0),
  //                 child: const Align(
  //                   alignment: Alignment.bottomRight,
  //                   child: Text('META \$2000.00',
  //                       style: Constants.textStyleParagraph),
  //                 )),
  //             Container(
  //                 width: double.infinity,
  //                 margin: const EdgeInsets.symmetric(
  //                     vertical: 1.0, horizontal: 15.0),
  //                 child: const Align(
  //                   alignment: Alignment.bottomRight,
  //                   child: Text(
  //                       '*VIGENCIA DEL 01 DE SEPTIEMBRE AL 01 DE NOVIEMBRE DEL 2022',
  //                       style: Constants.textStyleParagraph),
  //                 )),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _miSaldo(DvLineasState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Table(
        children: [
          _tableRow(
              Container() /* Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  'MI SALDO',
                  style: Constants.textStyleTitleDefault,
                ),
              )*/
              ,
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  child:
                      Container() /* Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('ULTIMA ACTUALIZACIÓN',
                        style: Constants.textStyleParagraphDefault),
                    Text(DateFormat('dd/MM/yyyy  kk:mm:ss').format(_dateGet),
                        style: Constants.textStyleParagraphDefault)
                  ],
                ),*/
                  )),
          _tableRow(
              const Text('SALDO ACTUAL',
                  overflow: TextOverflow.ellipsis,
                  style: Constants.textStyleSubTitleDefault),
              Text('\$${moneyF.format(state.data?.saldoActualTotal)}',
                  style: Constants.textStyleSubTitleDefault)),
          _tableRow(
              const Text('LINEA DISPONIBLE',
                  overflow: TextOverflow.ellipsis,
                  style: Constants.textStyleSubTitleDefault),
              Text('\$${moneyF.format(state.data?.disponibleTotal)}',
                  style: Constants.textStyleSubTitleDefault)),
          _tableRow(
              const Text('LINEA OTORGADA',
                  overflow: TextOverflow.ellipsis,
                  style: Constants.textStyleSubTitleDefault),
              Text('\$${moneyF.format(state.data?.limiteTotal)}',
                  style: Constants.textStyleSubTitleDefault)),
          // _tableRow(
          //     const Text('MONEDERO CONFIA SHOP',
          //         overflow: TextOverflow.ellipsis,
          //         style: Constants.textStyleSubTitle),
          //     const Text('\$100.00', style: Constants.textStyleSubTitle)),
          // _tableRow(
          //     const Text('SALDO COVID', style: Constants.textStyleSubTitle),
          //     const Text('\$0.00', style: Constants.textStyleSubTitle)),
        ],
      ),
    );
  }

  TableRow _tableRow(Widget _left, Widget _right) {
    return TableRow(children: [
      _left,
      Align(
        child: _right,
        alignment: Alignment.centerRight,
      ),
    ]);
  }

  Widget _saldoDetalle(DvLineasState state) {
    // ignore: prefer_is_empty
    return state.data?.detalle.length == 0
        ? Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            child: _cardSaldo(DvLineasDetalle()),
            height: 240.0)
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 20.0),
            height: 240.0,
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: state.data?.detalle.length,
                      itemBuilder: (_, int index) =>
                          _cardSaldo(state.data?.detalle[index])),
                ),
              ],
            ),
          );
  }

  Widget _cardSaldo2() {
    return CardSwiper(
      movies: [Container(), Container(), Container()],
    );
  }

  Widget _cardSaldo(DvLineasDetalle? item) {
    return WidgetAnimator(
      child: Container(
        width: 240.0,
        margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Constants.colorPrimary,
          boxShadow: const [
            BoxShadow(
              color: Constants.colorDefaultText,
              offset: Offset(2.0, 5.0), //(x,y)
              blurRadius: 10.0,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Container(
            color: Constants.colorPrimary,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 15.0),
                    child: Text('${item?.caption}',
                        style: Constants.textStyleSubTitleDefault)),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text('\$${moneyF.format(item?.disponible)}',
                        style: Constants.textStyleTitle)),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: const Text('DISPONIBLE',
                        style: Constants.textStyleSubTitle)),
                const Divider(color: Constants.colorDefault),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text('\$${moneyF.format(item?.limite)}',
                        style: Constants.textStyleSubTitle)),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: const Text('LIMITE DE CRÉDITO',
                        style: Constants.textStyleParagraph)),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text('\$${moneyF.format(item?.colocacion)}',
                        style: Constants.textStyleSubTitle)),
                Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: const Text('UTILIZADO',
                        style: Constants.textStyleParagraph)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nuevoCredito(DvLineasState state) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30.0),
        topRight: Radius.circular(30.0),
        bottomRight: Radius.circular(30.0),
        bottomLeft: Radius.circular(30.0),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        color: Constants.colorSecondary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('NUEVO VALE DIGITAL',
                style: Constants.textStyleTitleDefault),
            const Text('OTORGA UN NUEVO VALE A TUS CLIENTES',
                style: Constants.textStyleParagraphDefault),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomElevatedButton(
                  label: (state.data?.atraso ==
                          true) //<<-- REGRESAR (state.data?.atraso == false)
                      ? 'NUEVO VALE'
                      : 'NO DISPONIBLE',
                  action: () {
                    if (state.data?.atraso ==
                        true) //<<-- REGRESAR (state.data?.atraso == false)
                      // ignore: curly_braces_in_flow_control_structures
                      Navigator.push(
                          context,
                          _customRoute
                              .createRutaSlide(Constants.pageClientesVale));
                  },
                  primaryColor: Constants.colorDefault,
                  textColor: Constants.colorSecondary,
                  borderColor: Constants.colorSecondary,
                ),
                // CustomElevatedButton(
                //   label: 'CONFIASHOP',
                //   action: () {},
                //   primaryColor: Constants.colorAlternative,
                //   textColor: Constants.colorDefault,
                //   borderColor: Constants.colorDefault,
                // )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _resumenRelacion(DvSaldosState state) {
    return WidgetAnimator(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            child: state.data?.detalleLineaCredito == null
                ? Container(
                    child: const Center(
                      child: Text(
                        '',
                        style: Constants.textStyleSubTitle,
                      ),
                    ),
                    width: double.infinity,
                    height: 100.0,
                    color: Constants.colorSecondary,
                  )
                : Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 10.0),
                    color: Constants.colorSecondary,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('GANA MAS PAGANDO ANTES',
                            style: Constants.textStyleSubTitleDefault),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Table(
                            children: [
                              _tableRow(
                                  const Text('FECHA PAGO',
                                      style:
                                          Constants.textStyleStandardDefault),
                                  Text(
                                      '${state.data?.bonificaciones?[0].fechaPago}',
                                      style: Constants.textStyleStandard)),
                              _tableRow(
                                  const Text('TASA PORCENTAJE',
                                      style:
                                          Constants.textStyleStandardDefault),
                                  Text(
                                      '${state.data?.bonificaciones?[0].porcentaje}%',
                                      style:
                                          Constants.textStyleStandardDefault)),
                              _tableRow(
                                  const Text('BONIFICACIÓN',
                                      style:
                                          Constants.textStyleStandardDefault),
                                  Text(
                                      '\$${moneyF.format(state.data?.bonificaciones?[0].bonificacion)}',
                                      style:
                                          Constants.textStyleStandardDefault)),
                            ],
                          ),
                        ),
                        // const Text('SALDO COVID', style: Constants.textStyleSubTitle),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 5.0, vertical: 5.0),
                        //   child: Table(
                        //     children: [
                        //       _tableRow(
                        //           const Text('FECHA CIERRE',
                        //               style: Constants.textStyleStandard),
                        //           const Text('01/01/2001',
                        //               style: Constants.textStyleStandard)),
                        //       _tableRow(
                        //           const Text('IMPORTE',
                        //               style: Constants.textStyleStandard),
                        //           const Text('\$0.00%',
                        //               style: Constants.textStyleStandard)),
                        //       _tableRow(
                        //           const Text('SALDO',
                        //               style: Constants.textStyleStandard),
                        //           const Text('\$0.00',
                        //               style: Constants.textStyleStandard)),
                        //     ],
                        //   ),
                        // ),
                        const Text('ÚLTIMA RELACIÓN',
                            style: Constants.textStyleSubTitleDefault),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Table(
                            children: [
                              _tableRow(
                                  Text(
                                      '${state.data?.relaciones?[0].fechaCorte.substring(0, 10)}',
                                      style:
                                          Constants.textStyleStandardDefault),
                                  Text(
                                      '\$${moneyF.format(state.data?.relaciones?[0].saldoActual)}',
                                      style:
                                          Constants.textStyleStandardDefault))
                            ],
                          ),
                        ),
                        const Text('PRESTAMO PERSONAL',
                            style: Constants.textStyleSubTitleDefault),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5.0, vertical: 5.0),
                          child: Table(
                            children: [
                              _tableRow(
                                  const Text('SALDO ACTUAL',
                                      style:
                                          Constants.textStyleStandardDefault),
                                  Text(
                                      '\$${moneyF.format(state.data?.detallePrestamoPersonal?.saldoActualPrestamoPersonal)}',
                                      style:
                                          Constants.textStyleStandardDefault)),
                              _tableRow(
                                  const Text('ABONO QUINCENAL',
                                      style:
                                          Constants.textStyleStandardDefault),
                                  Text(
                                      '\$${moneyF.format(state.data?.detallePrestamoPersonal?.saldoAbonadoPrestamoPersonal)}',
                                      style:
                                          Constants.textStyleStandardDefault)),
                              _tableRow(
                                  const Text('SALDO VENCIDO',
                                      style:
                                          Constants.textStyleStandardDefault),
                                  Text(
                                      '\$${moneyF.format(state.data?.detallePrestamoPersonal?.saldoAtrasadoPrestamoPersonal)}',
                                      style:
                                          Constants.textStyleStandardDefault))
                            ],
                          ),
                        ),
                        Center(
                          child: Text(
                            'ÚLTIMA ACTIALIZACION ${DateFormat('dd/MM/yyyy  kk:mm:ss').format(_dateGet)}',
                            style: Constants.textStyleParagraph,
                          ),
                        )
                      ],
                    ),
                  )),
      ),
    );
  }

  Widget _relacion(DvLineasState state) {
    return ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
          color: Constants.colorSecondary,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: const [
                  Icon(
                    Icons.info_outline,
                    color: Constants.colorDefault,
                  ),
                  Text(
                    'RELACIÓN DE COBRO',
                    style: Constants.textStyleSubTitleDefault,
                  )
                ],
              ),
              const Text(
                'DESCARGA TU RELACIÓN DE COBRA AQUÍ',
                style: Constants.textStyleParagraphDefault,
              ),
              Center(
                child: CustomElevatedButton(
                  label: state.data?.atraso == true
                      ? 'NO DISPONIBLE'
                      : 'DESCARGAR',
                  action: () {},
                  primaryColor: Constants.colorDefault,
                  textColor: Constants.colorSecondary,
                  borderColor: Constants.colorSecondary,
                ),
              ),
            ],
          ),
        ));
  }

  @override
  bool get wantKeepAlive => true;
}
