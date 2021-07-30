import 'package:flutter/material.dart';

/// 带图标的输入框
class InputWidget extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? hintText;
  final IconData? iconData;
  final bool obscureText;

  const InputWidget({
    Key? key,
    this.controller,
    this.onChanged,
    this.hintText,
    this.iconData,
    this.obscureText: false,
  }) : super(key: key);

  @override
  _InputWidgetState createState() => _InputWidgetState();
}

class _InputWidgetState extends State<InputWidget> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        icon: widget.iconData == null ? null : Icon(widget.iconData),
      ),
    );
  }
}
