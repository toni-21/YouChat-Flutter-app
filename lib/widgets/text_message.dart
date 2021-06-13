import 'package:flutter/material.dart';
import '../models/message_model.dart';
// import '../scoped_models/demo_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart' show mainModel, MainModel;

class TextMessage extends StatelessWidget {
  final Message message;
  TextMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return ScopedModel(
      model: mainModel,
      child: ScopedModelDescendant<MainModel>(
        builder: (BuildContext context, Widget? child, MainModel model) {
          return Container(
            //margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
                color: Theme.of(context)
                    .primaryColor
                    .withOpacity(message.isSender ? 1 : 0.2),
                borderRadius: BorderRadius.circular(30)),
            child: Text(
              message.text,
              style: TextStyle(
                fontFamily: "OpenSans",
                fontSize: 15,
                letterSpacing: 0.64,
                height: 1.15,
                color: message.isSender ? Colors.white : Color(0xFF1D1D35),
              ),
            ),
          );
        },
      ),
    );
  }
}
