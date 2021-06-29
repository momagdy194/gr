import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:untitled2/components/already_have_an_account_acheck.dart';
import 'package:untitled2/components/rounded_button.dart';
import 'package:untitled2/components/rounded_input_field.dart';
import 'package:untitled2/components/rounded_password_field.dart';
import 'package:untitled2/widgets/home.dart';

import '../../../constants/constant.dart';
import '../../Signup/signup_screen.dart';
import 'background.dart';

class Body extends StatefulWidget {
  const Body({
    Key key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = new GoogleSignIn();
  bool isGoogleSignIn = false;
  String errorMessage = '';
  String successMessage = '';
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  String _emailId;
  String _password;
  final _emailIdController = TextEditingController(text: '');
  final _passwordController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/login.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            Column(
              children: [
                Form(
                  key: _formStateKey,
                  autovalidate: true,
                  child: Column(
                    children: [
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
                  text: "LOGIN",
                  press: () {
                    if (_formStateKey.currentState.validate()) {
                      _formStateKey.currentState.save();
                      signIn(_emailId, _password).then((user) {
                        if (user != null) {
                          print('Logged in successfully.');

                          setState(() {
                            successMessage =
                                'Logged in successfully.\nYou can now navigate to Home Page.';
                          });
                          Navigator.pushNamed(context, '/about');
                        } else {
                          print('Error while Login.');
                        }
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),
            (successMessage != ''
                ? Text(
                    successMessage,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  )
                : Container()),
            (!isGoogleSignIn
                ? RaisedButton(
                    child: Text('Google Login'),
                    color: kPrimaryColor,
                    onPressed: () {
                      googleSignin(context).then((user) {
                        if (user != null) {
                          print('Logged in successfully.');
                          setState(() {
                            isGoogleSignIn = true;
                            successMessage =
                                'Logged in successfully.\nEmail : ${user.email}\nYou can now navigate to Home Page.';
                          });
                        } else {
                          print('Error while Login.');
                        }
                      });
                    },
                  )
                : RaisedButton(
                    child: Text('Google Logout'),
                    onPressed: () {
                      googleSignout().then((response) {
                        if (response) {
                          setState(() {
                            isGoogleSignIn = false;
                            successMessage = '';
                          });
                        }
                      });
                    },
                  )),
          ],
        ),
      ),
    );
  }

  Future<FirebaseUser> signIn(String email, String password) async {
    try {
       var user = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (user != null) {
        print("hi");

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StockMarketAppHome(),
            ));
      }
      // assert(user != null);
      // assert(await user.getIdToken() != null);

      // final FirebaseUser currentUser = await auth.currentUser();
      // assert(user.uid == currentUser.uid);
      // return user;
    } catch (e) {
      // handleError(e);
      // return null;

      print(e);
    }
  }

  Future<FirebaseUser> googleSignin(BuildContext context) async {
    FirebaseUser currentUser;
    try {
      final GoogleSignInAccount googleUser = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user =
          (await auth.signInWithCredential(credential)) as FirebaseUser;
      assert(user.email != null);
      assert(user.displayName != null);
      assert(!user.isAnonymous);
      assert(await user.getIdToken() != null);

      currentUser = await auth.currentUser;
      assert(user.uid == currentUser.uid);
      print(currentUser);
      print("User Name  : ${currentUser.displayName}");
    } catch (e) {
      handleError(e);
    }
    return currentUser;
  }

  Future<bool> googleSignout() async {
    await auth.signOut();
    await googleSignIn.signOut();
    return true;
  }

  handleError(PlatformException error) {
    print(error);
    switch (error.code) {
      case 'ERROR_USER_NOT_FOUND':
        setState(() {
          errorMessage = 'User Not Found!!!';
        });
        break;
      case 'ERROR_WRONG_PASSWORD':
        setState(() {
          errorMessage = 'Wrong Password!!!';
        });
        break;
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
    if (value.trim().isEmpty) {
      return 'Password is empty!!!';
    }
    return null;
  }
}
