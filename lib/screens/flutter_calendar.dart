import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_remid_me/notifications/NotificationManager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class FlutterCalendar extends StatefulWidget {
  @override
  _FlutterCalendarState createState() => _FlutterCalendarState();
}

class _FlutterCalendarState extends State<FlutterCalendar> {
  //create notification manager
  NotificationManager _notificationManager = NotificationManager();

  //create calendar controller
  CalendarController _controller;

  //create map list for calendar events
  Map<DateTime, List<dynamic>> _events;

  //create list of selected events
  List<dynamic> _selectedEvents;

  //create text field controllers
  TextEditingController _eventController; //calendar marker
  TextEditingController _notificationIdController;
  TextEditingController _notificationTitleController;
  TextEditingController _notificationDescriptionController;
  TextEditingController _notificationTimeHourController;
  TextEditingController _notificationTimeMinuteController;

//create shared preference for saving and reading saved events
  SharedPreferences prefs;

  //init vars
  @override
  void initState() {
    super.initState();
    initPrefs();
    _controller = CalendarController();
    _eventController = TextEditingController();

    _notificationIdController = TextEditingController();
    _notificationTitleController = TextEditingController();
    _notificationDescriptionController = TextEditingController();
    _notificationTimeHourController = TextEditingController();
    _notificationTimeMinuteController = TextEditingController();

    _events = {};
    _selectedEvents = [];
    _notificationManager.initNotifications();

  }


  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  //init data
  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  //encode data for pref
  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  //decode data pref
  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  //build ui widget tree
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Event'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                _createEventDialog();
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _events,
              initialCalendarFormat: CalendarFormat.month,
              calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  todayColor: Colors.orange,
                  selectedColor: Theme.of(context).primaryColor,
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.white)),
              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                formatButtonDecoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                formatButtonTextStyle: TextStyle(color: Colors.white),
                formatButtonShowsNext: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.monday,
              onDaySelected: (date, events) {
                setState(() {
                  _selectedEvents = events;
                });
              },
              builders: CalendarBuilders(
                selectedDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
                todayDayBuilder: (context, date, events) => Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(10.0)),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              calendarController: _controller,
            ),
            ..._selectedEvents.map((event) => ListTile(
                  title: Text(event),
                  leading: Icon(Icons.ac_unit),
                  subtitle: Text('?'),
                )),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Create Reminder',
                    style:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),

                  SizedBox(
                    height: 20.0,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Container(
                          color: Colors.blue,
                          child: FlatButton(
                            onPressed: _showAddDailyDialog,
                            child: Text('daily'),
                          ),
                        ),
                        Container(
                          color: Colors.yellow,
                          child: FlatButton(
                            onPressed: _notificationManager
                                .showWeeklyAtDayAndTime,
                            child: Text('weekly'),
                          ),
                        ),
                        Container(
                          color: Colors.redAccent,
                          child: FlatButton(
                            onPressed: _notificationManager.repeatNotification,
                            child: Text('repeating'),
                          ),
                        ),
                        Container(
                          color: Colors.lightGreenAccent,
                          child: FlatButton(
                            onPressed: _showAddScheduleDialog,
                            child: Text('Schedule'),
                          ),
                        ),
                        Container(
                          color: Colors.purpleAccent,
                          child: FlatButton(
                            onPressed: () {
                              setState(() {
                                _events.clear();
                                _eventController.clear();
                              });
                            },
                            child: Text('Remove All events'),
                          ),
                        ),
                        Container(
                          color: Colors.black,
                          child: FlatButton(
                            onPressed: _notificationManager.removeAllReminders,
                            child: Text(
                              'Delete All Reminders',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),


                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


  //create a reminder notification and calendar event on calendar
  _showAddDailyDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                height: 755,
                width: 355,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      TextField(
                        controller: _notificationIdController,
                        decoration: InputDecoration(
                            labelText: "Enter Notification Number Id"),
                      ),
                      TextField(
                        controller: _notificationTitleController,
                        decoration: InputDecoration(
                            labelText: "Enter Notification Title"),
                      ),
                      TextField(
                        controller: _notificationDescriptionController,
                        decoration: InputDecoration(
                            labelText: "Enter NOtification Description"),
                      ),
                      TextField(
                        controller: _notificationTimeHourController,
                        decoration: InputDecoration(
                            labelText: "Enter Notification Time Hour"),
                      ),
                      TextField(
                        controller: _notificationTimeMinuteController,
                        decoration: InputDecoration(
                            labelText: "Enter Notification Time Minute"),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Save"),
                  onPressed: () {
                    if (_notificationIdController.text.isEmpty) return;
                    if (_notificationTitleController.text.isEmpty) return;
                    if (_notificationDescriptionController.text.isEmpty) return;
                    if (_notificationTimeHourController.text.isEmpty) return;
                    if (_notificationTimeMinuteController.text.isEmpty) return;

                      _notificationManager.showNotificationDaily(
                          1,
                          _notificationTitleController.text,
                          _notificationDescriptionController.text,
                          int.parse(_notificationTimeHourController.text),
                          int.parse(_notificationTimeMinuteController.text));
                      // _notificationManager.showNotificationDaily(0,"alarm","get up lazy",13,56);
                      //_notificationManager.removeAllReminders();

                      Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  _showAddScheduleDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                height: 755,
                width: 355,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Enter Notification Title and Info"),
                        controller: _eventController,
                      ),
                      TextField(
                        controller: _notificationIdController,
                        decoration: InputDecoration(
                            labelText: "Enter Notification Number Id"),
                      ),
                      TextField(
                        controller: _notificationTitleController,
                        decoration: InputDecoration(
                            labelText: "Enter Notification Title"),
                      ),
                      TextField(
                        controller: _notificationDescriptionController,
                        decoration: InputDecoration(
                            labelText: "Enter NOtification Description"),
                      ),
                      TextField(
                        controller: _notificationTimeHourController,
                        decoration: InputDecoration(
                            labelText: "Enter Notification Time Hour"),
                      ),
                      TextField(
                        controller: _notificationTimeMinuteController,
                        decoration: InputDecoration(
                            labelText: "Enter Notification Time Minute"),
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Save"),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;
                    if (_notificationIdController.text.isEmpty) return;
                    if (_notificationTitleController.text.isEmpty) return;
                    if (_notificationDescriptionController.text.isEmpty) return;
                    if (_notificationTimeHourController.text.isEmpty) return;
                    if (_notificationTimeMinuteController.text.isEmpty) return;
                    setState(() {
                      if (_events[_controller.selectedDay] != null) {
                        _events[_controller.selectedDay]
                            .add(_eventController.text);
                      } else {
                        _events[_controller.selectedDay] = [
                          _eventController.text
                        ];
                      }
                      prefs.setString(
                          "events", json.encode(encodeMap(_events)));
                      _eventController.clear();

                      //_events.clear();
                      _notificationManager.scheduleNotification();
                      //_notificationManager.removeAllReminders();
                      _notificationManager.showNotificationDaily(
                          1,
                          _notificationTitleController.text,
                          _notificationDescriptionController.text,
                          int.parse(_notificationTimeHourController.text),
                          int.parse(_notificationTimeMinuteController.text));

                      Navigator.pop(context);
                    });
                  },
                )
              ],
            ));
  }

  _createEventDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Container(
                height: 755,
                width: 355,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      TextField(
                        decoration: InputDecoration(
                            labelText: "Enter Event Title and Info"),
                        controller: _eventController,
                      ),
                    ],
                  ),
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Save Event"),
                  onPressed: () {
                    if (_eventController.text.isEmpty) return;

                    setState(() {
                      if (_events[_controller.selectedDay] != null) {
                        _events[_controller.selectedDay]
                            .add(_eventController.text);
                      } else {
                        _events[_controller.selectedDay] = [
                          _eventController.text
                        ];
                      }
                      prefs.setString(
                          "events", json.encode(encodeMap(_events)));
                      _eventController.clear();

                      Navigator.pop(context);
                    });
                  },
                )
              ],
            ));
  }
}
