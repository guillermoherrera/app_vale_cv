import 'package:app_vale_cv/helpers/constants.dart';
import 'package:flutter/material.dart';

class CustomDropDownButton extends StatefulWidget {
  const CustomDropDownButton(
      {Key? key,
      required this.label,
      required this.items,
      required this.fieldController})
      : super(key: key);

  final String label;
  final List<DropdownMenuItem<int>> items;
  final TextEditingController fieldController;

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {
  int? _dropDownValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: DropdownButton<int>(
            items: widget.items,
            onChanged: MediaQuery.of(context).viewInsets.bottom == 0
                ? (estadoSel) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() {
                      _dropDownValue = estadoSel;
                      widget.fieldController.text = estadoSel.toString();
                    });
                  }
                : null,
            value: _dropDownValue,
            isExpanded: true,
            underline: Container(color: Colors.grey),
            hint: Text(widget.label.toUpperCase(),
                style: TextStyle(color: Colors.grey.shade600)),
          )),
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      margin: const EdgeInsets.only(bottom: 20.0),
      height: 50.0,
      decoration: BoxDecoration(
        color: const Color(0xfff2f2f2),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
            color: Colors.grey.shade400, style: BorderStyle.solid, width: 1),
      ),
    );
    ;
  }
}
