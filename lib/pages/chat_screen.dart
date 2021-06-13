import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart' show mainModel, MainModel;
import '../models/message_model.dart';
import '../scoped_models/demo_model.dart';
import '../widgets/text_message.dart';
import '../widgets/audio_message.dart';
import '../widgets/video_message.dart';

class ChatScreen extends StatefulWidget {
  final int index;
  ChatScreen(this.index);

  @override
  State<StatefulWidget> createState() {
    return _ChatScreenState();
  }
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController _postEditingController = TextEditingController();
  String? postMessage;
  bool aboutToPost = false;

  Widget _messageContent(Message message) {
    switch (message.messageType) {
      case MessageType.Text:
        return TextMessage(message);
      case MessageType.Audio:
        return AudioMessage(message);
      // case MessageType.Image:
      //   return TextMessage(message);
      case MessageType.Video:
        return VideoMessage(message);
      default:
        return SizedBox();
    }
  }

  @override
  void initState() {
    super.initState();
   mainModel.connect();}


  @override
  void dispose() {
    mainModel.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String _profileImage = demoChatTileList[widget.index].image;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: <Widget>[
            CupertinoNavigationBarBackButton(
              color: Theme.of(context).accentColor,
            ),
            CircleAvatar(
              backgroundImage: AssetImage(_profileImage),
            ),
            SizedBox(width: 15),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    demoChatTileList[widget.index].name,
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    demoChatTileList[widget.index].time,
                    style: TextStyle(fontSize: 12),
                  ),
                ])
          ],
        ),
        actions: [
          IconButton(
              icon: Icon(
                Icons.local_phone,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {}),
          IconButton(
              icon: Icon(
                Icons.videocam,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {}),
          SizedBox(width: 10)
        ],
      ),
      body: ScopedModel(
        model: mainModel,
        child: ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget? child, MainModel model) {
          return Column(children: <Widget>[
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.messageList.length,
                  itemBuilder: (BuildContext context, int index) {
                    var message = model.messageList[index];
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: message.isSender
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        children: [
                          if (!message.isSender) ...[
                            CircleAvatar(
                                radius: 12,
                                backgroundImage: AssetImage(_profileImage)),
                          ],
                          SizedBox(width: 50),
                          Flexible(
                            fit: FlexFit.loose,
                            child: _messageContent(message),
                          ),
                          if (message.isSender) ...[
                            Container(
                              margin: EdgeInsets.only(left: 8),
                              //padding: EdgeInsets.all(2),
                              height: 12,
                              width: 12,
                              decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                shape: BoxShape.circle,
                              ),
                              child:
                                  message.messageStatus == MessageStatus.NotSent
                                      ? Icon(
                                          Icons.close,
                                          size: 9,
                                          color: Colors.black,
                                        )
                                      : Icon(
                                          Icons.done,
                                          size: 9,
                                          color: Colors.white,
                                        ),
                            ),
                          ]
                        ],
                      ),
                    );
                  }),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 4),
                    blurRadius: 32,
                    color: Theme.of(context).accentColor,
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    IconButton(
                        icon: Icon(Icons.mic,
                            color: Theme.of(context).primaryColor),
                        onPressed: () {}),
                    SizedBox(width: 5),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.sentiment_satisfied_alt_outlined,
                              color: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.color
                                  ?.withOpacity(0.64),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextField(
                                maxLines: 5,
                                minLines: 1,
                                controller: _postEditingController,
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    hintText: "Type message",
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  setState(() {
                                    aboutToPost = true;
                                    postMessage = value;
                                  });
                                },
                              ),
                            ),
                            (aboutToPost == true && postMessage!.length > 0)
                                ? IconButton(
                                    icon: Icon(Icons.send),
                                    color: Theme.of(context).primaryColor,
                                    onPressed: () {
                                      // model.sendTextMessage(
                                      //     postMessage.toString());

                                      model.subscribeLiveQuery(
                                          postMessage.toString());
                                      FocusScope.of(context).unfocus();
                                      _postEditingController.clear();
                                      model.fetchMessages();
                                    },
                                  )
                                : Row(
                                    children: [
                                      Icon(
                                        Icons.attach_file,
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyText1
                                            ?.color
                                            ?.withOpacity(0.64),
                                      ),
                                      SizedBox(width: 5),
                                      IconButton(
                                        icon: Icon(
                                          Icons.camera_alt_outlined,
                                          color: Theme.of(context)
                                              .textTheme
                                              .bodyText1
                                              ?.color
                                              ?.withOpacity(0.64),
                                        ),
                                        onPressed: () => model.disconnect(),
                                      ),
                                    ],
                                  )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ]);
        }),
      ),
    );
  }
}
