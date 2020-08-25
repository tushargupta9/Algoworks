import 'package:algoworks/loginscreen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Algoworks',
        home: LoginScreen()

        // Container(
        //     child: _isLoggedIn
        //         ? Column(
        //             // mainAxisAlignment: MainAxisAlignment.center,
        //             children: <Widget>[
        //               Image.network(
        //                 _googleSignIn.currentUser.photoUrl,
        //                 height: 50.0,
        //                 width: 50.0,
        //               ),
        //               Text(_googleSignIn.currentUser.displayName),
        //               OutlineButton(
        //                 child: Text("Logout"),
        //                 onPressed: () {
        //                   _logout();
        //                 },
        //               )
        //             ],
        //           )
        //         : Center(
        //             child: OutlineButton(
        //               child: Text("Login with Google"),
        //               onPressed: () {
        //                 _login();
        //               },
        //             ),
        //           )),
        // Container(
        //     child: _isLoggedIn
        //         ? Column(
        //             // mainAxisAlignment: MainAxisAlignment.center,
        //             children: <Widget>[
        //               Image.network(
        //                 userProfile["picture"]["data"]["url"],
        //                 height: 50.0,
        //                 width: 50.0,
        //               ),
        //               Text(userProfile["name"]),
        //               OutlineButton(
        //                 child: Text("Logout"),
        //                 onPressed: () {
        //                   _logoutfb();
        //                 },
        //               )
        //             ],
        //           )
        //         : Align(
        //             alignment: Alignment.bottomCenter,
        //             child: OutlineButton(
        //               child: Text("Login with facebook"),
        //               onPressed: () {
        //                 _loginWithFB();
        //               },
        //             ),
        //           )),

        );
  }
}
