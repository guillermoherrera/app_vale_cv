import 'package:app_vale_cv/bloc/user/user_bloc.dart';
import 'package:app_vale_cv/helpers/constants.dart';
import 'package:app_vale_cv/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
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
      body: const Center(child: Text('')),
      bottomNavigationBar: Container(
        color: Constants.colorDefault,
        child: TabBar(
          controller: _tabController,
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
          labelColor: Constants.colorAlternative,
          unselectedLabelColor: Constants.colorSecondary,
          tabs: _tabs(),
        ),
      ),
    );
  }

  PreferredSize _appBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(100),
      child: CustomAppBar(
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<UserBloc>(context, listen: false)
                    .add(DeleteUserEvent());
              },
              icon: const Icon(
                Icons.logout,
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
}
