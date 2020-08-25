import 'package:algoworks/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:localstorage/localstorage.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final LocalStorage storage = new LocalStorage('algoworks');
  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  bool passwordVisible;
  String email;
  String password;
  String name;
  // bool status  = false;

  bool _isLoggedIn = false;
  Map userProfile;
  final facebookLogin = FacebookLogin();

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _loginWithFB() async {
    final result = await facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        final token = result.accessToken.token;
        print("token is " + token);
        final graphResponse = await http.get(
            'https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
        final profile = JSON.jsonDecode(graphResponse.body);
        print(profile);
        setState(() {
          userProfile = profile;
          _isLoggedIn = true;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                    email: userProfile["email"], name: userProfile["name"])));
        break;

      case FacebookLoginStatus.cancelledByUser:
        setState(() => _isLoggedIn = false);
        break;
      case FacebookLoginStatus.error:
        setState(() => _isLoggedIn = false);
        break;
    }
  }

  _logoutfb() {
    facebookLogin.logOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  _login() async {
    try {
      await _googleSignIn.signIn();
      setState(() {
        _isLoggedIn = true;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Home(
                  email: _googleSignIn.currentUser.email,
                  name: _googleSignIn.currentUser.displayName)));
    } catch (err) {
      print(err);
    }
  }

  _logout() {
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  void initState() {
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
            padding: const EdgeInsets.all(16.0),
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Text('Login/Signup'.toUpperCase(),
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w700)),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Form(
                    key: _formKey,
                    autovalidate: _autoValidate,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (String value) {
                            if (value.isEmpty || value.trim().isEmpty)
                              return 'Please enter your Name';
                            else {
                              name = value;
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(16.0),
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              margin: const EdgeInsets.only(right: 7.0),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(10.0),
                                  )),
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            hintText: 'Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.blueAccent.withOpacity(0.1),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          validator: (String value) {
                            bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value);
                            if (value.isEmpty || value.trim().isEmpty)
                              return 'Please enter your Email-Id';
                            else {
                              if (!emailValid)
                                return 'Please enter valid Email-Id';
                              else
                                email = value;
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(16.0),
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              margin: const EdgeInsets.only(right: 7.0),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(10.0),
                                  )),
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                            hintText: 'Email Address',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none),
                            filled: true,
                            fillColor: Colors.blueAccent.withOpacity(0.1),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        TextFormField(
                          obscureText: passwordVisible,
                          validator: (String value) {
                            if (value.isEmpty || value.trim().isEmpty)
                              return 'Please Enter Password';
                            else {
                              password = value;
                              return null;
                            }
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.all(16.0),
                            prefixIcon: Container(
                              padding: const EdgeInsets.only(top: 5.0),
                              margin: const EdgeInsets.only(right: 7.0),
                              decoration: BoxDecoration(
                                  color: Colors.blueAccent,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30.0),
                                    topRight: Radius.circular(30.0),
                                    bottomLeft: Radius.circular(30.0),
                                    bottomRight: Radius.circular(10.0),
                                  )),
                              child: Icon(Icons.lock, color: Colors.white),
                            ),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none),
                            suffixIcon: IconButton(
                              icon: Icon(
                                passwordVisible
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.black38,
                              ),
                              onPressed: () {
                                setState(() {
                                  passwordVisible = !passwordVisible;
                                });
                              },
                            ),
                            filled: true,
                            fillColor: Colors.blueAccent.withOpacity(0.1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      child: RaisedButton(
                        elevation: 0,
                        onPressed: () async {
                          setState(() {
                            _autoValidate = true;
                          });
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _isLoggedIn = true;
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Home(
                                          email: email,
                                          name: name,
                                        )));
                          }
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        color: Colors.blueAccent,
                        child: Text(
                          'Login',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 70.0, vertical: 12.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  GoogleSignInButton(
                    onPressed: () {
                      _login();
                    },
                    borderRadius: 15,
                  ),
                  const SizedBox(height: 10.0),
                  FacebookSignInButton(
                    onPressed: () {
                      _loginWithFB();
                    },
                    borderRadius: 15,
                    text: "Login with facebook",
                  ),
                ],
              ),
            )),
      ],
    ));
  }
}
