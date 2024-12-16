import 'package:flutter/material.dart';
import 'vacationCard.dart';

void main()  {
  runApp(MyApp());
  }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: VacationCard(),
    );
  }
}
