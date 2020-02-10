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
        child: ListView(
          children: <Widget>[
            Image.asset(
              "AppGravyLogo.png",
              width: 100,
              height: 40,
            ),
            SizedBox(height: 55,),
            Image.asset(
              "me.jpg",
              width: 300,
              height: 100,
            ),
            SizedBox(height: 25,),
            Container(

              width: 350,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50.0),
                  color: Colors.lightBlueAccent.shade100),
              child: Center(
                child: Text("   My Personal Todo And Reminger App. \n "
                    "  I will be using this app as an open source learning tool \n "
                    "  I will allow others to contribute to the app and welcome \n "
                    "  others willing to learn with me creating this app"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
