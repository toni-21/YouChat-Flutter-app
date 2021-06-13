import 'package:flutter/material.dart';
import '../scoped_models/demo_model.dart';
import '../pages/chat_screen.dart';

class ChatsListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          padding: EdgeInsets.fromLTRB(10, 0, 5, 10),
          scrollDirection: Axis.vertical,
          itemCount: demoChatTileList.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding: EdgeInsets.all(3),
              leading: Stack(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.amber,
                    backgroundImage: AssetImage(demoChatTileList[index].image),
                    radius: 24,
                  ),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: demoChatTileList[index].isActive
                          ? Container(
                              height: 13,
                              width: 13,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border:
                                      Border.all(color: Colors.white, width: 2),
                                  color: Colors.amberAccent),
                            )
                          : Container()),
                ],
              ),
              title: Text(
                demoChatTileList[index].name,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              subtitle: Text(
                demoChatTileList[index].lastMessage,
                style: TextStyle(color: Colors.blueGrey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: Opacity(
                opacity: 0.64,
                child: Text(demoChatTileList[index].time),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ChatScreen(index)));
              },
            );
          }),
    );
  }
}
