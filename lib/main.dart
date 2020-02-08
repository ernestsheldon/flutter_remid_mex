import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'package:flutter_remid_me/screens/home_screen.dart';
import 'package:flutter_remid_me/providers/todos_model.dart';

void main() => runApp(TodosApp());

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Todos',
        theme: ThemeData.dark(),
        home: HomeScreen(),
      ), create: (BuildContext context) => TodosModel(),
    );
  }
}