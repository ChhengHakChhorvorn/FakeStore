import 'package:flutter/material.dart';

showSnackBar({required BuildContext context, required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
        backgroundColor: Colors.deepPurple.shade100,
        content: Text(
          message,
          style: TextStyle(color: Colors.black),
        )),
  );
}
