import 'package:flutter/material.dart';
import 'package:fmij/components/constants.dart';

class NormalTextfield extends StatefulWidget {
  final String labelText;
  final Icon prefixIcon;
  final TextInputType keboardType;
  final TextEditingController? controller;

  // final InputDecoration decoration;
  const NormalTextfield({
    Key? key,
    this.controller,
    this.prefixIcon = const Icon(Icons.person),
    this.labelText = "Email",
    this.keboardType = TextInputType.emailAddress,
    // required this.decoration,
  }) : super(key: key);

  @override
  State<NormalTextfield> createState() => _NormalTextfieldState();
}

class _NormalTextfieldState extends State<NormalTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      keyboardType: widget.keboardType,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: kPurple, width: 2),
        ),
        labelText: widget.labelText,
        labelStyle: TextStyle(
          color: Colors.grey.shade500,
          fontSize: 14,
        ),
        border: const OutlineInputBorder(),
      ),
    );
  }
}
