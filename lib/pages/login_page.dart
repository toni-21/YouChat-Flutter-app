import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart' show mainModel, MainModel;
import '../widgets/rounded_button.dart';
import './signup_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  bool hideText = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> _formData = {
    'username': null,
    'password': null,
  };

  Widget _buildUsernameTextfield(Size size) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.greenAccent.withOpacity(0.45),
          borderRadius: BorderRadius.circular(29)),
      child: TextFormField(
        decoration: InputDecoration(
            icon: Icon(Icons.person, color: Colors.greenAccent[400]),
            border: InputBorder.none,
            hintText: "Your Email Here"),
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
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
          color: Colors.greenAccent.withOpacity(0.45),
          borderRadius: BorderRadius.circular(29)),
      child: TextFormField(
        obscureText: hideText,
        decoration: InputDecoration(
            icon: Icon(Icons.lock, color: Colors.greenAccent[400]),
            suffixIcon: IconButton(
                icon: Icon(Icons.visibility, color: Colors.greenAccent[400]),
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

  Widget _buildSignupRow() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      Text(
        "Don't have an account? ",
        style: TextStyle(color: Colors.green),
      ),
      GestureDetector(
        child: Text(
          " Sign Up",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.green, fontSize: 15.5),
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) {
            return SignupPage();
          }),
        ),
      ),
    ]);
  }

  // void _submitForm(Function authenticate) {
  //   Navigator.pushReplacementNamed(context, '/start');
  // }

  void _submitForm(Function authenticate) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();

    Map<String, dynamic> successInformation = await authenticate(
        _formData['username'], _formData['password'],
        newUser: false);
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
      //backgroundColor: Colors.white,

      body: Container(
        height: size.height,
        width: double.infinity,
        child: Stack(alignment: Alignment.center, children: [
          Positioned(
              right: 0,
              bottom: 0,
              child: Image.asset(
                "assets/images/login_bottom.png",
                width: size.width * 0.36,
              )),
          SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "LOGIN",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Lato",
                        fontSize: 16,
                        letterSpacing: 0.8),
                  ),
                  SizedBox(height: size.height * 0.01),
                  Image.asset(
                    "assets/images/login.png",
                  ),
                  SizedBox(height: size.height * 0.05),
                  _buildUsernameTextfield(size),
                  _buildPasswordTextfield(size),
                  ScopedModel(
                    model: mainModel,
                    child: ScopedModelDescendant<MainModel>(builder:
                        (BuildContext context, Widget? child, MainModel model) {
                      return RoundedButton(
                        size: size,
                        press: () {
                          return _submitForm(model.authenticate);
                        },
                        text: "LOGIN",
                        color: Colors.greenAccent[400]!,
                      );
                    }),
                  ),
                  SizedBox(height: size.height * 0.04),
                  _buildSignupRow(),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
