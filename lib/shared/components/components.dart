import 'package:flutter/material.dart';

Widget defaultFormField ({
  required controller,
  required hintText,
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
  double radius = 20.0,
  required VoidCallback? function,
  required String text,
}) {
  return Container(
    width: width,
    height: 50.0,
    child: MaterialButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(
        radius,
      ),
      color: background,
    ),
  );
}