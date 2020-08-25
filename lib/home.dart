import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String email;
  final String name;

  Home({this.email, this.name});
  @override
  HomeState createState() {
    return HomeState(
      email: email,
      name: name,
    );
  }
}

class HomeState extends State<Home> {
  String email;
  String name;

  HomeState({
    this.email,
    this.name,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Text(name == null ? "" : name),
                Text(email == null ? "" : email)
              ],
            ),
          )
        ],
      ),
    );
  }
}
