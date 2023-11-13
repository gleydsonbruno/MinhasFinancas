import 'package:basic_notions/home.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      scaffoldBackgroundColor: Color.fromARGB(255, 39, 37, 37),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          fontSize: 20,
        ),
        
      ),
    ),
    home: Home(),
  )
  );
}

