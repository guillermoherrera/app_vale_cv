import 'package:app_vale_cv/widgets/shake_transition.dart';
import 'package:flutter/material.dart';

import '../../helpers/constants.dart';
import '../../widgets/custom_app_bar.dart';

class ClientePage extends StatefulWidget {
  const ClientePage({Key? key}) : super(key: key);

  @override
  State<ClientePage> createState() => _ClientePageState();
}

class _ClientePageState extends State<ClientePage>
    with SingleTickerProviderStateMixin {
  bool isOpened = false;
  late AnimationController _animationController;
  late Animation<Color?> _animateColor;
  late Animation<double> _animateIcon;
  late Animation<double> _translateButton;
  final Curve _curve = Curves.easeOut;
  final double _fabHeight = 56.0;

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);

    _animateColor = ColorTween(
            begin: Constants.colorDefaultText, end: Constants.colorDefaultText)
        .animate(CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.0, 1.0, curve: Curves.linear)));
    _translateButton = Tween<double>(begin: _fabHeight, end: -14.0).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Interval(0.0, 0.75, curve: _curve)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Constants.colorPrimary,
      body: _body(),
      floatingActionButton: ShakeTransition(
          axis: Axis.vertical,
          duration: const Duration(seconds: 2),
          child: _floatingBtn()),
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
      children: [_encabezado(), _resumen()],
    );
  }

  Widget _encabezado() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            child: const Icon(Icons.person,
                color: Constants.colorPrimary, size: 100),
            decoration: const BoxDecoration(
                color: Colors.black, shape: BoxShape.circle),
          ),
          Container(
            margin: const EdgeInsets.all(10.0),
            child: const FittedBox(
              child: Text(
                'NOMBRE COMPLETO DEL CLIENTE SELECCIONADO',
                style: Constants.textStyleSubTitleDefault,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _resumen() {
    return Expanded(
        child: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            color: Constants.colorDefault,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [_datos(), _historial()],
            )));
  }

  Widget _datos() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('DATOS DE CONTACTO', style: Constants.textStyleSubTitle),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Table(
            children: [
              _tableRow(
                  const Text('TELEFONO:', style: Constants.textStyleStandard),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text('871-1223344',
                          style: Constants.textStyleStandard))),
              _tableRow(
                  const Text('DIRECCIÓN:', style: Constants.textStyleStandard),
                  const Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                          'TAMAZULA #393 PARQUE INDUSTRIAL 35078 GOMEZ PALACIO, DURANGO. MÉXICO',
                          style: Constants.textStyleStandard,
                          textAlign: TextAlign.end)))
            ],
          ),
        )
      ],
    );
  }

  Widget _historial() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('HISTORIAL DE PAGOS', style: Constants.textStyleSubTitle),
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Table(
            children: [
              _tableRowWithCenter(
                  const Align(
                      alignment: Alignment.center,
                      child: Text('# DE VALE',
                          style: Constants.textStyleSubTitle)),
                  const Align(
                      alignment: Alignment.center,
                      child:
                          Text('IMPORTE', style: Constants.textStyleSubTitle)),
                  const Align(
                      alignment: Alignment.center,
                      child:
                          Text('ESTADO', style: Constants.textStyleSubTitle))),
              _tableRowWithCenter(
                const Text('#000000002', style: Constants.textStyleStandard),
                const Align(
                    alignment: Alignment.centerRight,
                    child:
                        Text('\$1000.00', style: Constants.textStyleStandard)),
                const Align(
                    alignment: Alignment.center,
                    child: Text('ACTIVO', style: Constants.textStyleStandard)),
              ),
              _tableRowWithCenter(
                const Text('#000000001', style: Constants.textStyleStandard),
                const Align(
                    alignment: Alignment.centerRight,
                    child:
                        Text('\$1000.00', style: Constants.textStyleStandard)),
                const Align(
                    alignment: Alignment.center,
                    child: Text('INACTIVO',
                        style: Constants.textStyleStandardError)),
              )
            ],
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

  TableRow _tableRowWithCenter(Widget _left, Widget _center, Widget _right) {
    return TableRow(children: [
      Container(
        child: _left,
        padding: const EdgeInsets.all(5.0),
      ),
      Container(
        child: Align(
          child: _center,
          alignment: Alignment.centerRight,
        ),
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

  Widget _floatingBtn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform(
          transform:
              Matrix4.translationValues(0.0, _translateButton.value * 3.0, 0.0),
          child: _block(),
        ),
        Transform(
          transform:
              Matrix4.translationValues(0.0, _translateButton.value * 2.0, 0.0),
          child: _whats(),
        ),
        Transform(
          transform:
              Matrix4.translationValues(0.0, _translateButton.value * 1.0, 0.0),
          child: _call(),
        ),
        _toggle()
      ],
    );
  }

  Widget _toggle() {
    return FloatingActionButton(
      heroTag: 'btnToggle',
      onPressed: animate,
      backgroundColor: _animateColor.value,
      tooltip: 'ACCIONES',
      child: AnimatedIcon(
        icon: AnimatedIcons.menu_close,
        progress: _animateIcon,
      ),
    );
  }

  Widget _block() {
    return FloatingActionButton(
        heroTag: 'btnBlock',
        onPressed: () {},
        tooltip: 'BLOQUEAR CLIENTE',
        child: const Icon(
          Icons.block,
          color: Colors.red,
        ),
        backgroundColor: Constants.colorDefaultText);
  }

  Widget _whats() {
    return FloatingActionButton(
        heroTag: 'btnWhats',
        onPressed: () {},
        tooltip: 'ENVIAR WHATS',
        child: const Icon(Icons.whatsapp),
        backgroundColor: Constants.colorDefaultText);
  }

  Widget _call() {
    return FloatingActionButton(
        heroTag: 'btnCall',
        onPressed: () {},
        tooltip: 'LLAMAR',
        child: const Icon(Icons.call),
        backgroundColor: Constants.colorDefaultText);
  }
}
