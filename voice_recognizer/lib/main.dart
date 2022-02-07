import 'package:flutter/material.dart';
import 'package:voice_recognizer/voice_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Voice Demo',
      theme: ThemeData(),
      home: voiceScreen(),
    );
  }
}