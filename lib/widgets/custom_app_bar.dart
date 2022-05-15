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
    return AppBar(
      toolbarHeight: 70.0,
      centerTitle: true,
      title: Column(
        children: const [
          /*Hero(
              tag: 'Logo',
              child:*/
          Image(
            image: AssetImage(Constants.assetsImagelogo),
            height: 60,
            color: Constants.colorDefault,
            fit: BoxFit.contain,
          ) /*)*/,
          Text(
            'v1.0',
            style: Constants.textStyleParagraphDefault,
          )
        ],
      ),
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      actions: widget.actions,
    );
  }
}
