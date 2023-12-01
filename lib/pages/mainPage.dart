import 'package:toggle_switch/toggle_switch.dart';
import '../src/widgets.dart';
import 'package:flutter/material.dart';
import '../toggle.dart';
import '../app_state.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late int rownumber;
var valueList = [3, 2, leftHome, 4, 5, 6];
var unitList = ['cm', 'mm', 'times', 'kg', 'dkg', 'g'];
var nameList = ['DAILY AVG', 'FAVOURITE', 'LEFT HOME', 'SMT', 'SMT', 'SMT'];

class mainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 600;
    final bool isLargeScreen = width > 1000;

    if (isSmallScreen) {
      rownumber = 1;
    } else if (isLargeScreen) {
      rownumber = 3;
    } else {
      rownumber = 2;
    }

    return Scaffold(
      backgroundColor: color_5,
      body: GridView.count(
        crossAxisCount: rownumber,
        children: List.generate(6, (index) {
          return Center(
              child: Block(valueList[index].toDouble(), unitList[index],
                  nameList[index]));
        }),
      ),
    );
  }
}
