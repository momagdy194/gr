import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:untitled2/Screens/Login/login_screen.dart';
import 'package:untitled2/Screens/Signup/components/social_icon.dart';
import 'package:untitled2/components/already_have_an_account_acheck.dart';
import 'package:untitled2/components/rounded_button.dart';
import 'package:untitled2/components/rounded_input_field.dart';
import 'package:untitled2/components/rounded_password_field.dart';
import 'package:untitled2/constants/constant.dart';

import 'background.dart';
import 'or_divider.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');
  final _confirmPasswordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/signup.svg",
              height: size.height * 0.35,
            ),
            Column(
              children: [
                Form(
                  key: _formStateKey,
                  autovalidate: true,
                  child: Column(
                    children: [
                      RoundedInputField(
                        icon: Icons.person,
                        hintText: "Your Name",
                        onChanged: (value) {},
                      ),
                      RoundedInputField(
                        validator: validateEmail,
                        icon: Icons.person,
                        hintText: "Your Email",
                        onChanged: (value) {
                          _emailId = value;
                        },
                        type: TextInputType.emailAddress,
                        controller: _emailIdController,
                      ),
                      RoundedPasswordField(
                        controller: _passwordController,
                        validator: validatePassword,
                        iconShape: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        hintText: 'Password',
                        onChanged: (value) {
                          _password = value;
                        },
                      ),
                      RoundedPasswordField(
                        validator: validateConfirmPassword,
                        controller: _confirmPasswordController,
                        iconShape: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        hintText: 'Repeat your password',
                      ),
                    ],
                  ),
                ),
                (errorMessage != ''
                    ? Text(
                        errorMessage,
                        style: TextStyle(color: Colors.red),
                      )
                    : Container()),
                RoundedButton(
                  text: "SIGNUP",
                  press: () {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      signUp(_emailId, _password).then(
                        (user) {
                          if (user != null) {
                            print('Registered Successfully.');
                            setState(() {
                              successMessage =
                                  'Registered Successfully.\nYou can now navigate to Login Page.';
                            });
                          } else {
                            print('Error while Login.');
                          }
                        },
                      );
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
            (successMessage != ''
                ? Text(
                    successMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, color: Colors.green),
                  )
                : Container()),
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> signUp(email, password) async {
      FirebaseUser user = (await auth.createUserWithEmailAndPassword(
          email: email, password: password)) as FirebaseUser;
      assert(user != null);
      assert(await user.getIdToken() != null);
      return user;
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_EMAIL_ALREADY_IN_USE':
        setState(() {
          errorMessage = 'Email Id already Exist!!!';
        });
        break;
      default:
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty || !regex.hasMatch(value))
      return 'Enter Valid Email Id!!!';
    else
      return null;
  }

  String validatePassword(String value) {
    if (value.trim().isEmpty || value.length < 6 || value.length > 14) {
      return 'Minimum 6 & Maximum 14 Characters!!!';
    }
    return null;
  }

  String validateConfirmPassword(String value) {
    if (value.trim() != _passwordController.text.trim()) {
      return 'Password Miuntitled2tch!!!';
    }
    return null;
  }
}
