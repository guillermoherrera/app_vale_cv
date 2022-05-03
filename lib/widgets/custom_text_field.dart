import 'package:flutter/material.dart';
import 'package:app_vale_cv/helpers/utilerias.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    this.icon,
    this.errorEmpty = 'Ingresa este campo',
    this.textType = TextInputType.emailAddress,
    this.checkEmpty = true,
    this.isPassword = false,
    this.checkMaxLength = false,
    this.enable = true,
    this.onlyCharacters = false,
    required this.controller,
    this.maxLength = 100,
    this.onchangeMethod,
    this.enableUpperCase = false,
    this.validacion,
  }) : super(key: key);

  final String label;
  final String errorEmpty;
  final IconData? icon;
  final TextInputType textType;
  final bool checkEmpty;
  final bool isPassword;
  final TextEditingController controller;
  final int maxLength;
  final bool enable;
  final bool checkMaxLength;
  final bool onlyCharacters;
  final bool enableUpperCase;
  final void Function(String)? onchangeMethod;
  final bool Function()? validacion;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool watchPassword = false;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: _decoration(widget.label),
      autocorrect: false,
      inputFormatters: widget.enableUpperCase ? [UpperCaseTextFormatter()] : [],
      keyboardType: widget.textType,
      obscureText: widget.isPassword,
      maxLength: widget.maxLength,
      enabled: widget.enable,
      validator: (val) {
        return _validations(val!);
      },
    );
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
        contentPadding:
            const EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
        prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
        labelText: label,
        fillColor: const Color(0xfff2f2f2),
        filled: true,
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () => setState(() {
                      watchPassword = !watchPassword;
                    }),
                icon: Icon(
                    watchPassword ? Icons.visibility : Icons.visibility_off))
            : null);
  }

  String? _validations(String value) {
    if (widget.onlyCharacters) {
      value = value.replaceAll(RegExp(r"[^\s\w]"), "");
      value = value.replaceAll(" ", "");
    }

    if (widget.checkEmpty && value.isEmpty) return widget.errorEmpty;
    if (widget.checkMaxLength && value.length < widget.maxLength) {
      return 'Completa este campo';
    }
    return null;
  }
}
