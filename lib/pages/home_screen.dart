import 'package:flutter/material.dart';
import 'package:you_chat/widgets/chatslist_container.dart';
import '../widgets/experiences_title_container.dart';
import '../widgets/experiences_images_container.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text(
          "YouChat",
          style: TextStyle(
              fontFamily: "Poppins",
              letterSpacing: 0.75,
              fontWeight: FontWeight.w600),
        ),
        automaticallyImplyLeading: false,
        actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(
          Icons.add,size: 30,
          color: Colors.white,
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 7.5),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: Column(
          children: <Widget>[
            ExperiencesTitleContainer(),
            ExperiencesImagesContainer(),
            ChatsListContainer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.messenger), label: "Chats"),
          BottomNavigationBarItem(icon: Icon(Icons.people), label: "People"),
          BottomNavigationBarItem(icon: Icon(Icons.call), label: "Calls"),
          BottomNavigationBarItem(
              icon: CircleAvatar(
                radius: 14,
                backgroundImage: AssetImage("assets/images/user_2.png"),
              ),
              label: "Profile"),
        ],
      ),
    );
  }
}
