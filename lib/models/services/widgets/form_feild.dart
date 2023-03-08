import 'package:flutter/material.dart';

class CreateFormFeild extends StatelessWidget {
  TextEditingController? controller;
  String? Function(String?)? validator;
  final String hint;
  TextInputType? kytype;
  CreateFormFeild(
      {Key? key,
      required this.hint,
      required this.kytype,
      required this.controller,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: kytype,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          // vertical: 10,
          horizontal: 13,
        ),
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        filled: true,
        // hintText: "$_Number",
        hintText: hint,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
      validator: validator,
    );
  }
}
