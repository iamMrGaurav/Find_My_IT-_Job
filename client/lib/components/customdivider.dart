import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomerDivider extends StatelessWidget {
  final String text;
  const CustomerDivider({
    Key? key,
    this.text = "Sign in Using",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 2,
            height: 10,
            endIndent: 10,
            indent: 50,
          ),
        ),
        Text(
          text,
          style: GoogleFonts.roboto(color: Colors.grey.shade800),
        ),
        const Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 2,
            height: 10,
            endIndent: 50,
            indent: 10,
          ),
        ),

        // Icon(),
      ],
    );
  }
}
