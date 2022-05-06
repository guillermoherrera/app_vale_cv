import 'package:app_vale_cv/helpers/constants.dart';
import 'package:flutter/material.dart';

class ValesPages extends StatefulWidget {
  const ValesPages({Key? key}) : super(key: key);

  @override
  State<ValesPages> createState() => _ValesPagesState();
}

class _ValesPagesState extends State<ValesPages> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
              child: Container(
                color: Constants.colorDefault,
                child: const Center(
                    child: Text(
                  'VALES',
                  style: Constants.textStyleSubTitle,
                )),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
