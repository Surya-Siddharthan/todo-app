import 'package:flutter/material.dart';
dynamic blue = Colors.blue[50];
const textInputDecoration = InputDecoration(
  hintText: 'Email',
  fillColor: Color(0xFFE3F2FD),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF42A5F5), width: 2.0)
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.pink, width: 2.0)
  ),
);