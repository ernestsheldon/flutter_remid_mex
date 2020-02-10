import 'package:flutter/material.dart';
import 'package:flutter_remid_me/screens/InfoPage.dart';
import 'package:flutter_remid_me/screens/flutter_calendar.dart';
import 'package:flutter_remid_me/screens/todoScreen.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: "Home",),
                Tab(icon: Icon(Icons.calendar_today), text: "Events"),
                Tab(icon: Icon(Icons.add_box), text: "ToDos"),
              ],
            ),
            title: Text('Shit Todo V1.0', style: TextStyle(
                fontWeight: FontWeight.w900,
                backgroundColor: Colors.black
            ),),
          ),
          body: TabBarView(
            children: [
              InfoPage(),
              FlutterCalendar(),
              TodoScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
