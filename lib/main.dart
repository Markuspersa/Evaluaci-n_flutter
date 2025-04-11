import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:flutter_application_1/screens/car_select_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
  '/car-select': (context) => CarSelectScreen(),
}    
    ); 
    
  }
}


