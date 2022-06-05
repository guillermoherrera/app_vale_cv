import 'package:flutter/material.dart';
import 'package:app_vale_cv/helpers/constants.dart';
import 'package:app_vale_cv/widgets/shake_transition.dart';

class CustomDialog {
  show(BuildContext context,
      {String title = 'TITULO',
      IconData icon = Icons.help_outline,
      String textContent = 'CONTENIDO.',
      Widget form = const SizedBox(),
      String cancelText = 'CANCELAR',
      String continueText = 'CONTINUAR',
      double offset = 500,
      bool willPop = true,
      required VoidCallback action,
      VoidCallback? cancelAction}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return ShakeTransition(
              axis: Axis.vertical,
              duration: const Duration(milliseconds: 3000),
              offset: offset,
              child: WillPopScope(
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        side: const BorderSide(
                            color: Constants.colorPrimary, width: 3.0)),
                    title: Center(
                      child: Text(
                        title.toUpperCase(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    content: SingleChildScrollView(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          icon,
                          color: Constants.colorPrimary,
                          size: 100,
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          textContent.toUpperCase(),
                          textAlign: TextAlign.center,
                          style: Constants.textStyleStandard,
                        ),
                        form
                      ],
                    )),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            cancelAction == null
                                ? Navigator.pop(context)
                                : cancelAction();
                          },
                          child: Text(cancelText.toUpperCase())),
                      TextButton(
                          onPressed: () async {
                            action();
                          },
                          child: Text(continueText.toUpperCase()))
                    ],
                  ),
                  onWillPop: () async => willPop));
        });
  }
}
