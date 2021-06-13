import 'package:flutter/material.dart';
import 'package:you_chat/pages/home_screen.dart';
//import './pages/home_screen.dart';
import './pages/welcome_screen.dart';
import './helpers/size_route.dart';

void main() {
  runApp(YouChat());
}

class YouChat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _YouChatState();
  }
}

class _YouChatState extends State<YouChat> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "You Chat",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red,
        accentColor: Color(0xFFFEF9EB),
        appBarTheme: AppBarTheme(elevation: 0, centerTitle: false),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            selectedItemColor: Color(0xFF1D1D35).withOpacity(0.7),
            unselectedItemColor: Color(0xFF1D1D35).withOpacity(0.4),
            selectedIconTheme: IconThemeData(color: Colors.red),
            showUnselectedLabels: true),
      ),
      home: WelcomeScreen(),
      routes: {
        "/home": (BuildContext context) => HomeScreen(),
      },
      onGenerateRoute: (RouteSettings settings) {
        if (settings.name! == "/start") {
          return FadeRoute(page: HomeScreen());
        }
        return null;
      },
    );
  }
}

//  backgroundColor:  Color(0xFFF5FCF9),
