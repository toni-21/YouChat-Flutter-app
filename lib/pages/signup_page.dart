//import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart' show mainModel,MainModel;
import '../widgets/rounded_button.dart';
import './login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SignupPageState();
  }
}

class _SignupPageState extends State<SignupPage> {
  bool hideText = true;
  bool onPlatformSignup = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'username': null,
    'password': null,
  };

  Widget _buildUsernameTextfield(Size size) {
    return Container(
      margin: EdgeInsets.only(bottom: 15, top: 10),
      width: size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.25),
          borderRadius: BorderRadius.circular(29)),
      child: TextFormField(
        decoration: InputDecoration(
            icon: Icon(Icons.person, color: Colors.redAccent[400]),
            border: InputBorder.none,
            hintText: "Your UserName Here"),
        onSaved: (String? value) {
          _formData['username'] = value;
        },
        validator: (String? value) {
          if (value == null || value.length > 10) {
            return "Please enter a username no more than 10 characters long";
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPasswordTextfield(size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.redAccent.withOpacity(0.25),
          borderRadius: BorderRadius.circular(29)),
      child: TextFormField(
        obscureText: hideText,
        decoration: InputDecoration(
            icon: Icon(Icons.lock, color: Colors.redAccent[400]),
            suffixIcon: IconButton(
                icon: Icon(Icons.visibility, color: Colors.redAccent[400]),
                onPressed: () {
                  setState(() {
                    hideText = !hideText;
                  });
                }),
            border: InputBorder.none,
            hintText: "Password"),
            onSaved: (String? value) {
          _formData['password'] = value;
        },
        validator: (String? value) {
          if (value == null || value.length < 5) {
            return 'password is incorrect';
          }
        },
        
      ),
    );
  }

  Widget _buildSignInText() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(
        "Already have an account? ",
        style: TextStyle(color: Colors.red),
      ),
      GestureDetector(
        child: Text(
          " Sign In",
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
              fontSize: 15.5),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return LoginPage();
          }),
        ),
      ),
    ]);
  }

  Widget _buildOrDividerRow(Size size) {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(top: 5),
          alignment: Alignment.bottomLeft,
          width: size.width * 0.45,
          height: 1,
          color: Colors.redAccent.withOpacity(0.6),
        ),
        Spacer(),
        Text(
          "OR",
          style: TextStyle(color: Colors.red[500], fontWeight: FontWeight.bold),
        ),
        Spacer(),
        Container(
          margin: EdgeInsets.only(top: 5),
          alignment: Alignment.bottomRight,
          width: size.width * 0.45,
          height: 1,
          color: Colors.redAccent.withOpacity(0.75),
        ),
      ],
    );
  }

  Widget _buildAlternativeSignupRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1.5, color: Colors.redAccent.withOpacity(0.5)),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            "assets/icons/facebook.svg",
            color: Colors.blue[900],
            height: 20,
            width: 20,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1.5, color: Colors.redAccent.withOpacity(0.5)),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            "assets/icons/twitter.svg",
            color: Colors.blue,
            height: 20,
            width: 20,
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(
                width: 1.75, color: Colors.redAccent.withOpacity(0.5)),
            shape: BoxShape.circle,
          ),
          child: SvgPicture.asset(
            "assets/icons/google-plus.svg",
            color: Colors.red,
            height: 20,
            width: 20,
          ),
        ),
      ],
    );
  }

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    Map<String, dynamic> successInformation = await authenticate(
        _formData['username'], _formData['password'],
        newUser: true);
    if (successInformation['success']) {
      print(successInformation['success']);
      Navigator.pushReplacementNamed(context, '/start');
    } else {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("An error has occeured"),
              content: Text(successInformation['message']),
              actions: [
                TextButton(
                  child: Text('Okay'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      //backgroundColor: Colors.blue,
      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Image.asset("assets/images/signup_top.png",
                  width: size.width * 0.23),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: Image.asset("assets/images/main_bottom.png",
                  width: size.width * 0.20),
            ),
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "SIGNUP",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: "Lato",
                          fontSize: 16,
                          letterSpacing: 0.8),
                    ),
                    SizedBox(height: size.height * 0.01),
                    Image.asset(
                      "assets/images/signup.png",
                      height: size.height * 0.35,
                    ),
                    _buildUsernameTextfield(size),
                    _buildPasswordTextfield(size),
                    ScopedModel(model: mainModel,
                    child: ScopedModelDescendant<MainModel>(builder:
                        (BuildContext context, Widget? child, MainModel model) {
                      return RoundedButton(
                        size: size,
                        press: () {
                          return _submitForm(model.authenticate);
                        },
                        text: "SIGNUP",
                        color: Colors.redAccent,
                      );
                    }),
                    ),
                    SizedBox(height: size.height * 0.03),
                    _buildSignInText(),
                    SizedBox(height: 10),
                    _buildOrDividerRow(size),
                    SizedBox(height: size.height * 0.014),
                    _buildAlternativeSignupRow(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
