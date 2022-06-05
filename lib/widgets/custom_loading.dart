import 'package:app_vale_cv/helpers/constants.dart';
import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading(
      {Key? key, this.label = '', this.color = Constants.colorPrimary})
      : super(key: key);
  final String? label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(color!),
          ),
          Text(
            label!,
            style: Constants.textStyleStandard,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
