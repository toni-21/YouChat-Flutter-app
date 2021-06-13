import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final Size size;
  final Function() press;
  final String text;
  final Color color;
  RoundedButton(
      {required this.size,
      required this.press,
      required this.text,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.8,
      margin: EdgeInsets.symmetric(vertical: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: TextButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(
                EdgeInsets.symmetric(horizontal: 36, vertical: 14.5),
              ),
              backgroundColor: MaterialStateProperty.all(color)),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500
            ),
          ),
        ),
      ),
    );
  }
}
