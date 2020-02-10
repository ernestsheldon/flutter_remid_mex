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
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.calendar_today)),
                Tab(icon: Icon(Icons.add_box)),
              ],
            ),
            title: Text('Shit Todo'),
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
