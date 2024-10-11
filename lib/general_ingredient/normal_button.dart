import 'package:flutter/material.dart';

class normal_button extends StatelessWidget {
  final Color backgroundColor;
  final Color overlayColor;
  final double borderRadius;
  final double padding;
  final String content;
  final Color contentColor;
  final VoidCallback event;
  const normal_button({super.key, required this.backgroundColor, required this.overlayColor, required this.borderRadius, required this.content, required this.event, required this.contentColor, required this.padding});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: padding, right: padding),
      child: SizedBox(
        width: double.infinity,
        child: TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll<Color>(backgroundColor),
            overlayColor: WidgetStatePropertyAll<Color>(overlayColor),
            shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius), // Adjust the radius as needed
              ),
            ),
          ),
          onPressed: event,
          child: Padding(
            padding: const EdgeInsets.only(top: 7, bottom: 7),
            child: Text(
              content,
              style: TextStyle(
                fontFamily: 'nuni',
                color: contentColor,
                fontSize: width/22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
