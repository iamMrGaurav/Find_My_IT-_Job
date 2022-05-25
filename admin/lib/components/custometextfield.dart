import 'package:flutter/material.dart';
import 'package:fyp_admin/components/constants.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final TextEditingController? controller;

  const CustomTextField({
    Key? key,
    this.controller,
    this.labelText = "feault",
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool isEye = true;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscuringCharacter: '*',
      obscureText: isEye,
      decoration: kFieldDecoration.copyWith(
        prefixIcon: const Icon(
          Icons.lock,
          color: kPurple,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
        labelText: widget.labelText,
        suffixIcon: IconButton(
          onPressed: () {
            setState(
              () {
                if (isEye) {
                  isEye = false;
                } else {
                  isEye = true;
                }
              },
            );
          },
          icon: isEye
              ? const Icon(
                  Icons.visibility_off,
                  color: kPurple,
                )
              : const Icon(Icons.visibility),
          color: Colors.grey,
        ),
      ),
    );
  }
}
