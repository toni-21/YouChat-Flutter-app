import 'package:flutter/material.dart';
import '../models/message_model.dart';

class AudioMessage extends StatelessWidget {
  final Message message;
  AudioMessage(this.message);
  @override
  Widget build(BuildContext context) {
    return Container(
      //margin: EdgeInsets.only(top: 20),
      width: MediaQuery.of(context).size.width * 0.55,
      //height: 30,
      padding: EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 8,
      ),
      decoration: BoxDecoration(
          color: Theme.of(context)
              .primaryColor
              .withOpacity(message.isSender ? 1 : 0.2),
          borderRadius: BorderRadius.circular(30)),
      child: Row(children: [
        Icon(
          Icons.play_arrow,
          color:
              message.isSender ? Colors.white : Theme.of(context).primaryColor,
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 2,
                  color: message.isSender
                      ? Colors.white
                      : Theme.of(context).primaryColor.withOpacity(0.5),
                ),
                Positioned(
                  left: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                        color: message.isSender
                            ? Colors.white
                            : Theme.of(context).primaryColor,
                        shape: BoxShape.circle),
                  ),
                )
              ],
            ),
          ),
        ),
        Text("0:35",
            style: TextStyle(
              color: message.isSender ? Colors.white : null,
              fontSize: 12,
            )),
      ]),
    );
  }
}
