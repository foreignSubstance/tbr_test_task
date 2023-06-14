import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "SpaceX Launches",
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w400),
          ),
          centerTitle: true,
          backgroundColor: Colors.black,
        ),
        backgroundColor: Colors.black,
        body: const HomeScreen(),
      ),
    );
  }
}
