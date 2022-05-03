import 'package:app_vale_cv/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<UserBloc>(context, listen: false)
                    .add(DeleteUserEvent());
              },
              icon: const Icon(Icons.close))
        ],
      ),
      body: const Center(child: Text('Home')),
    );
  }
}
