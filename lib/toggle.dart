import 'package:flutter/material.dart';
// import 'package:toggle_switch/toggle_switch.dart';
import 'dart:async';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//kiolvasáshoz
class TemperatureMessage {
  TemperatureMessage({required this.value});
  final double value;
}

// main pagen kell
class HomeMessage {
  HomeMessage({required this.isHome});
  final bool isHome;
}

class ToggleFunc extends StatefulWidget {
  const ToggleFunc({required this.addisHome, required this.values, super.key});

  final FutureOr<void> Function(bool isHome) addisHome;
  final List<TemperatureMessage> values; //kiolvasás

  @override
  State<ToggleFunc> createState() => _ToggleFuncState();
}

//statisztika hányszot mentem el otthonról - végül nem használt
double leftHome = 0;

class _ToggleFuncState extends State<ToggleFunc> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_ToggleFuncState');

  //homeoraway collection, RUHome doc elérése
  final isHomeRef =
      FirebaseFirestore.instance.collection("homeoraway").doc("RUHome");

  //szükséges változók
  late bool isHome;
  int labelIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Form(
        key: _formKey,
        child: Row(
          children: [
            ToggleSwitch(
              minWidth: 90.0,
              cornerRadius: 20.0,
              activeBgColors: [
                [Colors.green[800]!],
                [Colors.red[800]!]
              ],
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              initialLabelIndex: labelIndex, //kell bele memoria
              totalSwitches: 2,
              labels: const ['Home', 'Away'],
              radiusStyle: true,
              onToggle: (index) async {
                if (index == 0) {
                  isHome = true;
                  labelIndex = 0;
                } else {
                  isHome = false;
                  labelIndex = 1;
                }
                // await widget.addisHome(isHome); //addol új doc-ot (nem lett kiszedve a többi része, csak itt)
                isHomeRef.update({"isHome": isHome});
              },
            ),
          ],
        ),
      ),
    );
  }
}
