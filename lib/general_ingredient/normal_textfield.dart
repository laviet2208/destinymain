import 'package:flutter/material.dart';

class normal_textfield extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final VoidCallback event;
  const normal_textfield({super.key, required this.controller, required this.hint, required this.event});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 248, 248, 248),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Color.fromARGB(255, 248, 248, 248), width: 1),
          borderRadius: BorderRadius.circular(800),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1),
          borderRadius: BorderRadius.circular(800),
        ),
        hintText: hint,
        contentPadding: EdgeInsets.only(left: 20, top: 15, bottom: 15),
        hintStyle: TextStyle(color: Color.fromARGB(255, 210, 210, 210), fontSize: 15, fontFamily: 'nuni', fontWeight: FontWeight.bold,), // Hint text color
      ),
      onChanged: (value) {
        event();
      },
      cursorColor: Colors.blue, // Cursor color
    );
  }
}
