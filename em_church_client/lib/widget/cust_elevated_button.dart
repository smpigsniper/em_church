import 'package:em_church_client/style/color.dart';
import 'package:em_church_client/style/font_size.dart';
import 'package:flutter/material.dart';

class CustElevatedButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final FocusNode? focusNode;
  const CustElevatedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.focusNode,
  });

  @override
  State<CustElevatedButton> createState() => _CustElevatedButtonState();
}

class _CustElevatedButtonState extends State<CustElevatedButton> {
  final CustColors _custColors = CustColors();
  final CustFontSize _custFontSize = CustFontSize();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      focusNode: widget.focusNode,
      onPressed: widget.onPressed,
      child: Text(
        widget.text,
        style: TextStyle(
          color: _custColors.mainColor[1],
          fontSize: _custFontSize.mainFontSize[6],
        ),
      ),
    );
  }
}
