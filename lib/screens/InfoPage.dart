import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: <Widget>[
            Image.asset(
              "AppGravyLogo.png",
              width: 200,
              height: 100,
            ),
            Image.asset(
              "me.jpg",
              width: 200,
              height: 300,
            ),
            Container(
              width: 250,
              color: Colors.lightGreenAccent,
              child: Center(
                child: Text("My Personal Todo And Reminger App. \n "
                    "I will be using this app as an open source learning tool \n "
                    "I will allow others to contribute to the app and welcome others willing to learn with me creating this app"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
