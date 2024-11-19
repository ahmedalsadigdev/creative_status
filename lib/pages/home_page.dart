import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Title(color: Color(0xFF3E0E1F), child: Text("Creative Status")),
      ),
      body: Center(
        child: Image.asset("assets/images/bg_yellow.png"),
      ),
    );
  }
}
