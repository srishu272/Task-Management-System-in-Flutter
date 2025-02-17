import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/provider/taskProvider.dart';
import 'package:task_management_app/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context)=>TaskProvider(),
      child: MaterialApp(
    title: "Task Management App",
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    ),);
  }
}
