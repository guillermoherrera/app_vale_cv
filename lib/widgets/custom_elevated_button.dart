import 'package:app_vale_cv/helpers/constants.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton(
      {Key? key,
      required this.label,
      this.borderColor,
      this.primaryColor,
      this.textColor,
      required this.action,
      this.elevation = 0.0})
      : super(key: key);

  final String label;
  final Color? primaryColor;
  final Color? borderColor;
  final Color? textColor;
  final VoidCallback action;
  final double elevation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: (() => action()),
        child: FittedBox(
          child: Text(
            label.toUpperCase(),
            style: TextStyle(
                color: textColor ?? Constants.colorDefaultText,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        style: ElevatedButton.styleFrom(
            primary: primaryColor ?? Constants.colorPrimary,
            //paddingbottom
            textStyle:
                TextStyle(color: textColor ?? Constants.colorDefaultText),
            elevation: elevation,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                    color: borderColor ?? Constants.colorPrimary, width: 2.0)))

        // shape: RoundedRectangleBorder(
        //     borderRadius: BorderRadius.circular(10.0),
        //     side: BorderSide(
        //         color: borderColor ?? Constants.colorPrimary, width: 2.0))),
        );
  }
}
