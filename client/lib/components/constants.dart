import 'package:flutter/material.dart';

const Color kPurple = Color(0xff5C2D91);
const Color klightpurple = Color(0xff8f26e0);
const Color kTheme = Color(0xfff2edf9);

InputDecoration kFieldDecoration = InputDecoration(
  contentPadding: const EdgeInsets.symmetric(horizontal: 15),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: kPurple, width: 2),
  ),
  prefixIcon: const Icon(
    Icons.person,
    color: kPurple,
  ),
  labelText: "Mobile Number / Email",
  labelStyle: TextStyle(
    color: Colors.grey.shade600,
    fontSize: 16,
  ),
  border: const OutlineInputBorder(),
);
