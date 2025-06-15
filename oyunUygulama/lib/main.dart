import 'package:flutter/material.dart';
import 'game_page.dart'; 

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Matematik Oyunu',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const GamePage(), 
    );
  }
}
