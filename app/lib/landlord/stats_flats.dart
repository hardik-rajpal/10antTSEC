import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:math';

class StatsFlats extends StatefulWidget {
  const StatsFlats({super.key});

  @override
  State<StatsFlats> createState() => _StatsFlatsState();
}

class _StatsFlatsState extends State<StatsFlats> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add Flat")),
        body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.all(70.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                  Icon(
                    Icons.check
                  ),
                  Icon(Icons.close),
                  Icon(Icons.question_mark)
                ]),
              )));
  }
}
