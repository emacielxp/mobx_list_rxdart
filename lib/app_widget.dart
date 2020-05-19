import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Slidy',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: HomePage(),
    );
  }
}
