import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextField extends StatefulWidget {
  final TextEditingController ctrl;
  final String labelText;
  final String? Function(String?) validator;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool obscureText;

  const InputTextField({Key? key, required this.ctrl, required this.labelText, required this.validator, this.inputType, this.inputFormatters, this.maxLength = 30, this.obscureText = false}) : super(key: key);

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {

  var style = const TextStyle(color: Colors.black, fontSize: 15.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
          controller: widget.ctrl,
          style: style,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
              labelText: widget.labelText),
          keyboardType: widget.inputType,
          inputFormatters: widget.inputFormatters,
          maxLength: widget.maxLength,
          validator: widget.validator

      ),
    );
  }
}
