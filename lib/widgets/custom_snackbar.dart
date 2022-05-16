import 'package:app_vale_cv/helpers/constants.dart';
import 'package:flutter/material.dart';

class CustomSnackbar {
  success(String msj,
      [IconData? icon = Icons.error_outline,
      Duration? time = const Duration(seconds: 4),
      SnackBarAction? action]) {
    return SnackBar(
        backgroundColor: Constants.colorDefaultText,
        duration: time!,
        content: Row(
          children: [
            Icon(
              icon,
              color: Constants.colorDefault,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Wrap(
                children: [
                  Text(
                    msj.toUpperCase(),
                    style: Constants.textStyleStandardDefault,
                  )
                ],
              ),
            )
          ],
        ));
  }

  error(String msj,
      [IconData? icon = Icons.error_outline,
      Duration? time = const Duration(seconds: 4),
      SnackBarAction? action]) {
    return SnackBar(
        backgroundColor: Colors.pink,
        duration: time!,
        content: Row(
          children: [
            Icon(
              icon,
              color: Constants.colorDefault,
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Wrap(
                children: [
                  Text(
                    msj.toUpperCase(),
                    style: Constants.textStyleStandardDefault,
                  )
                ],
              ),
            )
          ],
        ));
  }

  message(String msj,
      [String? msjSub = '',
      Color? color = Constants.colorPrimary,
      IconData? icon = Icons.message_outlined,
      Duration? time = const Duration(seconds: 4),
      SnackBarAction? action]) {
    return SnackBar(
      backgroundColor: color,
      duration: time!,
      content: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onVerticalDragStart: (_) => debugPrint("no can do!"),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 100, color: Constants.colorDefault),
            const SizedBox(
              height: 20.0,
            ),
            Wrap(
              children: [
                Text(
                  msj.toUpperCase(),
                  style: Constants.textStyleTitleDefault,
                  textAlign: TextAlign.center,
                )
              ],
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              msjSub!.toUpperCase(),
              textAlign: TextAlign.start,
              style: Constants.textStyleStandardDefault,
            ),
          ],
        ),
      ),
    );
  }
}
