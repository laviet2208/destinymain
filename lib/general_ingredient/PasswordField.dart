import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final VoidCallback onChanged;

  const PasswordField({
    Key? key,
    required this.controller,
    required this.hint,
    required this.onChanged,
  }) : super(key: key);

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 248, 248, 248),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color.fromARGB(255, 248, 248, 248),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(800),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blueAccent,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(800),
        ),
        hintText: widget.hint,
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 210, 210, 210),
          fontSize: 15,
          fontFamily: 'nuni',
          fontWeight: FontWeight.bold,
        ),
        contentPadding: const EdgeInsets.only(left: 20, top: 15, bottom: 15),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() => _obscureText = !_obscureText);
          },
        ),
      ),
      onChanged: (_) => widget.onChanged(),
      cursorColor: Colors.blue,
    );
  }
}
