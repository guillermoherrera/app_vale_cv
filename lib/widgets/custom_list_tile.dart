import 'package:app_vale_cv/helpers/constants.dart';
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.leading,
      required this.trailing})
      : super(key: key);

  final Widget title;
  final Widget subTitle;
  final Widget? leading;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shadowColor: Constants.colorDefaultText,
        elevation: 10.0,
        color: Constants.colorDefault,
        child: ListTile(
          title: title,
          subtitle: subTitle,
          leading: leading == null
              ? null
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [leading!]),
          trailing: trailing == null
              ? null
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [trailing!]),
          isThreeLine: true,
        ),
      ),
    );
  }
}
