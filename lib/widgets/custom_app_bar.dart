import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({Key? key, this.actions}) : super(key: key);

  final List<Widget>? actions;

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Constants.colorPrimary,
      child: AppBar(
        //automaticallyImplyLeading: false,
        toolbarHeight: 80.0,
        centerTitle: true,
        title: Container(
            margin: const EdgeInsets.only(right: 10.0),
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Constants.colorDefault,
                boxShadow: [
                  BoxShadow(
                      color: Constants.colorDefault,
                      blurRadius: 10.0,
                      offset: Offset(0.0, 0.0)),
                ]),
            child: const Image(
              image: AssetImage(Constants.assetsImagelogo2),
              height: 60,
              //color: Constants.colorDefault,
              fit: BoxFit.contain,
            )),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: widget.actions,
        // leading: const Center(
        //   child: Text(
        //     'v1.0',
        //     style: Constants.textStyleStandardDefault,
        //   ),
        // ),
      ),
    );
  }
}
