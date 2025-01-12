import 'package:flutter/material.dart';

Widget defaultFormField ({
  required controller,
  hintText,
  required keyboardType,
  FormFieldValidator? validator,
  ValueChanged<String>? onChanged,
  ValueChanged<String>? onFieldSubmitted,
  bool obscureText = false,
  Widget? suffixIcon,
  String? labelText,
  Widget? prefixIcon,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    validator: validator,
    onChanged: onChanged,
    onFieldSubmitted: onFieldSubmitted,
    obscureText: obscureText,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20.0)
      ),
      suffixIcon: suffixIcon,
      labelText: labelText,
      prefixIcon: prefixIcon,
      hintText: hintText,
    ),
  );
}

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue,
  required VoidCallback? function,
  required Widget widget,
}) {
  return Container(
    width: width,
    height: 50.0,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        20,
      ),
      color: background,
    ),
    child: MaterialButton(
      onPressed: function,
      child: widget,
    ),
  );
}