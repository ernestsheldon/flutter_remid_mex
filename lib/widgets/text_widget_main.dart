import 'package:flutter/material.dart';

class TextWidgetMain extends StatefulWidget {
  TextWidgetMain({Key key}) : super(key: key);

  @override
  _TextWidgetMainState createState() => _TextWidgetMainState();
}

class _TextWidgetMainState extends State<TextWidgetMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      width: 355,
      height: 355,
      child: Text("hello"),
    );
  }
}