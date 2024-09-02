// ignore_for_file: file_names

import 'package:em_church_client/style/color.dart';
import 'package:flutter/material.dart';

class CustTextField extends StatefulWidget {
  final String text;
  final IconData? iconData;
  final TextEditingController? controller;
  final Function(String)? onChange;
  final FocusNode? focusNode;
  final bool? hideText;
  final bool? passwordVisible;
  final String? errorText;
  const CustTextField(
      {super.key,
      required this.text,
      this.iconData,
      this.controller,
      this.onChange,
      this.focusNode,
      this.hideText,
      this.passwordVisible,
      this.errorText});

  @override
  State<CustTextField> createState() => _CustTextFieldState();
}

class _CustTextFieldState extends State<CustTextField> {
  bool _passwordVisible = false;
  CustColors custColors = CustColors();
  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: widget.focusNode,
      controller: widget.controller,
      obscureText: (widget.hideText == true && !_passwordVisible),
      decoration: InputDecoration(
        suffixIcon: widget.hideText == true
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : null,
        hintStyle: const TextStyle(color: Colors.grey),
        labelText: widget.text,
        prefixIcon: widget.iconData != null ? Icon(widget.iconData) : null,
        border: const OutlineInputBorder(),
        errorText: widget.errorText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: custColors.mainColor[0],
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onChanged: widget.onChange,
    );
  }
}
