import 'package:app_vale_cv/bloc/user/user_bloc.dart';
import 'package:app_vale_cv/helpers/constants.dart';
import 'package:app_vale_cv/pages/homepage/clientes_page.dart';
import 'package:app_vale_cv/pages/homepage/inicio_page.dart';
import 'package:app_vale_cv/pages/homepage/vales_page.dart';
import 'package:app_vale_cv/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/custom_route_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final _customRoute = CustomRouteTransition();
  TabController? _tabController;
  int tabIndex = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    _tabController?.addListener(() {
      setState(() {
        tabIndex = _tabController!.index;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: Constants.colorPrimary,
      body: TabBarView(
        controller: _tabController,
        children: _tabsView(),
        //physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Material(
        elevation: 20.0,
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
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: CustomAppBar(
        actions: [
          tabIndex == 0
              ? IconButton(
                  onPressed: () {
                    BlocProvider.of<UserBloc>(context, listen: false)
                        .add(DeleteUserEvent());
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Constants.colorDefault,
                  ))
              : tabIndex == 1
                  ? IconButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            _customRoute
                                .createRutaSlide(Constants.pageDesembolso));
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Constants.colorDefault,
                      ))
                  : IconButton(
                      onPressed: () {
                        BlocProvider.of<UserBloc>(context, listen: false)
                            .add(DeleteUserEvent());
                      },
                      icon: const Icon(
                        Icons.person_add,
                        color: Constants.colorDefault,
                      ))
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
