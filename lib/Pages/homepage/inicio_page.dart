import 'package:flutter/material.dart';

import '../../helpers/constants.dart';

class InicioPage extends StatefulWidget {
  const InicioPage({Key? key}) : super(key: key);

  @override
  State<InicioPage> createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_colocaGana(), _miSaldo(), _saldoDetalle()],
    );
  }

  Widget _colocaGana() {
    return Container(
      width: double.infinity,
      height: 100.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: Constants.colorDefaultText.withOpacity(0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 15.0),
                  child: const Text('COLOCA Y GANA',
                      style: Constants.textStyleSubTitleDefault)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Stack(
                  children: const [
                    LinearProgressIndicator(
                      color: Constants.colorPrimary,
                      backgroundColor: Constants.colorDefault,
                      minHeight: 30.0,
                      value: .50,
                    ),
                    Align(
                      child:
                          Text("\$1000.00", style: Constants.textStyleSubTitle),
                      alignment: Alignment.center,
                    ),
                  ],
                ),
              ),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 15.0),
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: Text('META \$2000.00',
                        style: Constants.textStyleParagraph),
                  )),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(
                      vertical: 1.0, horizontal: 15.0),
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                        '*VIGENCIA DEL 01 DE SEPTIEMBRE AL 01 DE NOVIEMBRE DEL 2022',
                        style: Constants.textStyleParagraph),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _miSaldo() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: Table(
        children: [
          _tableRow(
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10.0),
                child: const Text(
                  'MI SALDO',
                  style: Constants.textStyleTitleDefault,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: const [
                  Text('ULTIMA ACTUALIZACIÓN',
                      style: Constants.textStyleParagraph),
                  Text('01/01/01 00:00 AM', style: Constants.textStyleParagraph)
                ],
              )),
          _tableRow(
              const Text('SALDO ACTUAL',
                  overflow: TextOverflow.ellipsis,
                  style: Constants.textStyleSubTitle),
              const Text('\$1000.00', style: Constants.textStyleSubTitle)),
          _tableRow(
              const Text('LINEA DISPONIBLE',
                  overflow: TextOverflow.ellipsis,
                  style: Constants.textStyleSubTitle),
              const Text('\$19000.00', style: Constants.textStyleSubTitle)),
          _tableRow(
              const Text('LINEA OTORGADA',
                  overflow: TextOverflow.ellipsis,
                  style: Constants.textStyleSubTitle),
              const Text('\$20000.00', style: Constants.textStyleSubTitle)),
          _tableRow(
              const Text('MONEDERO CONFIA SHOP',
                  overflow: TextOverflow.ellipsis,
                  style: Constants.textStyleSubTitle),
              const Text('\$100.00', style: Constants.textStyleSubTitle)),
          _tableRow(
              const Text('SALDO COVID', style: Constants.textStyleSubTitle),
              const Text('\$0.00', style: Constants.textStyleSubTitle)),
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

  Widget _saldoDetalle() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20.0),
      height: 240.0,
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (_, int index) => _cardSaldo(index)),
          ),
        ],
      ),
    );
  }

  Widget _cardSaldo(int index) {
    return Container(
      width: 240.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Container(
          color: Constants.colorDefaultText.withOpacity(0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 15.0),
                  child: Text('PRODUCTO ${index + 1}',
                      style: Constants.textStyleSubTitleDefault)),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                      '\$${index == 0 ? '9000.00' : index == 1 ? '5000.00' : '5000.00'}',
                      style: Constants.textStyleTitle)),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: const Text('DISPONIBLE',
                      style: Constants.textStyleSubTitle)),
              const Divider(color: Constants.colorDefault),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Text(
                      '\$${index == 0 ? '10000.00' : index == 1 ? '5000.00' : '5000.00'}',
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
                  child: Text(
                      '\$${index == 0 ? '1000.00' : index == 1 ? '0.00' : '0.00'}',
                      style: Constants.textStyleSubTitle)),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: const Text('UTILIZADO',
                      style: Constants.textStyleParagraph)),
            ],
          ),
        ),
      ),
    );
  }
}
