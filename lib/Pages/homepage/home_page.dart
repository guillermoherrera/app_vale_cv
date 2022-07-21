import 'package:app_vale_cv/helpers/constants.dart';
import 'package:app_vale_cv/pages/homepage/clientes_page.dart';
import 'package:app_vale_cv/pages/homepage/inicio_page.dart';
import 'package:app_vale_cv/pages/homepage/vales_page.dart';
import 'package:app_vale_cv/providers/api_cv.dart';

import 'package:app_vale_cv/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../helpers/custom_route_transition.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_snackbar.dart';
import 'drawer_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _customRoute = CustomRouteTransition();
  final _customSnakBar = CustomSnackbar();

  final secureStorage = const FlutterSecureStorage();
  final _apiCV = ApiCV();
  TabController? _tabController;
  int tabIndex = 0;

  @override
  void initState() {
    _getInfo();
    _tabController = TabController(length: 3, vsync: this);
    _tabController?.addListener(() {
      setState(() {
        tabIndex = _tabController!.index;
      });
    });
    super.initState();
  }

  _getInfo() async {
    Future.delayed(Duration.zero, () {
      if (mounted) {
        SnackBar snackBar = _customSnakBar.message(
            msj: 'CARGANDO DATOS POR FAVOR ESPERE...',
            icon: Icons.watch_later,
            backGroundColor: Constants.colorAlternative,
            loading: true,
            time: const Duration(seconds: 2));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
    await _apiCV.getDvinfo(context);
    await _apiCV.getDvLineas(context);
    await _apiCV.getDvSaldos(context);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const DrawerPage(),
        appBar: _appBar(),
        backgroundColor: Constants.colorSecondary,
        body: SafeArea(
          child: Column(
            children: [
              Material(
                elevation: 0.0,
                child: Container(
                  color: Constants.colorDefault,
                  child: TabBar(
                    controller: _tabController,
                    labelStyle: Constants.textStyleParagraphDefault,
                    labelColor: Constants.colorAlternative,
                    unselectedLabelColor: Constants.colorSecondary,
                    tabs: _tabs(),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: _tabsView(),
                  //physics: const NeverScrollableScrollPhysics(),
                ),
              ),
            ],
          ),
        ),
        // bottomNavigationBar: Material(
        //   elevation: 20.0,
        //   child: Container(
        //     color: Constants.colorDefault,
        //     child: TabBar(
        //       controller: _tabController,
        //       labelStyle: Constants.textStyleParagraphDefault,
        //       labelColor: Constants.colorAlternative,
        //       unselectedLabelColor: Constants.colorSecondary,
        //       tabs: _tabs(),
        //     ),
        //   ),
        // ),
      ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: CustomAppBar(
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 10.0),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Constants.colorSecondary,
                  boxShadow: [
                    BoxShadow(
                        color: Constants.colorDefault,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 0.0)),
                  ]),
              child: tabIndex == 0
                  ? IconButton(
                      icon: const Icon(Icons.manage_accounts_sharp),
                      onPressed: () => _scaffoldKey.currentState?.openDrawer())
                  : tabIndex == 1
                      ? IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                _customRoute.createRutaSlide(
                                    Constants.pageClientesVale));
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Constants.colorDefault,
                          ))
                      : IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                _customRoute.createRutaSlide(
                                    Constants.pageNuevoCliente));
                          },
                          icon: const Icon(
                            Icons.person_add,
                            color: Constants.colorDefault,
                          )))
        ],
      ),
    );
  }

  List<Widget> _tabs() {
    return [
      const Tab(icon: Icon(Icons.home), text: 'INICIO'),
      const Tab(icon: Icon(Icons.monetization_on), text: 'VALES'),
      const Tab(icon: Icon(Icons.group), text: 'CLIENTES'),
    ];
  }

  List<Widget> _tabsView() {
    return [
      const InicioPage(),
      const ValesPages(),
      const ClientesPage(),
    ];
  }
}
