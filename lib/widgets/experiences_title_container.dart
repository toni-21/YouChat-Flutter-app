import 'package:flutter/material.dart';

class ExperiencesTitleContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Experiences",
              style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 18.0,
                  fontFamily: 'McLaren',
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.0),
            ),
          ),
          Spacer(),
          IconButton(
              icon: Icon(
                Icons.more_horiz_rounded,
                color: Colors.blueGrey,
              ),
              onPressed: () {}),
        ],
      ),
    );
  }
}
