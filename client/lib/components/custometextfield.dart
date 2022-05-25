import 'package:flutter/material.dart';
import 'package:fmij/components/constants.dart';

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

class CustomeJobPostField extends StatelessWidget {
  final String labelText;
  final Icon suffixIcon;
  final TextInputType input;
  final TextEditingController? controller;

  const CustomeJobPostField({
    Key? key,
    required this.controller,
    this.labelText = "email",
    this.suffixIcon = const Icon(Icons.person),
    required this.input,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xffF0EEFA),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: klightpurple,
              ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: TextField(
            keyboardType: input,
            controller: controller,
            decoration: InputDecoration(
              hintText: labelText,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ),
    );
  }
}

class DescriptionField extends StatelessWidget {
  final String labelText;
  final Icon suffixIcon;
  final TextEditingController? controllerField;

  const DescriptionField({
    Key? key,
    required this.controllerField,
    required this.labelText,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kTheme,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: klightpurple,
              ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: TextField(
            controller: controllerField,
            maxLines: 5,
            decoration: InputDecoration(
              hintText: labelText,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              suffixIcon: suffixIcon,
            ),
          ),
        ),
      ),
    );
  }
}
