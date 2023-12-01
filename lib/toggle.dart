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

//kiolvasáshoz
class UltrasonicMessage {
  UltrasonicMessage({required this.isOpened});
  final bool isOpened;
}

class ToggleFunc extends StatefulWidget {
  const ToggleFunc({required this.addisHome, required this.values, super.key});

  final FutureOr<void> Function(bool isHome) addisHome;
  final List<TemperatureMessage> values; //kiolvasás

  @override
  State<ToggleFunc> createState() => _ToggleFuncState();
}

double leftHome = 0;

class _ToggleFuncState extends State<ToggleFunc> {
  final _formKey = GlobalKey<FormState>(debugLabel: '_ToggleFuncState');
  final isHomeRef =
      FirebaseFirestore.instance.collection("homeoraway").doc("RUHome");
  bool isHome = true;

  // late double tempValue = widget.values[0].value; //utso hőm. érték

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
              initialLabelIndex: 0, //kell bele memoria
              totalSwitches: 2,
              labels: const ['Home', 'Away'],
              radiusStyle: true,
              onToggle: (index) async {
                //bug: ha kattintok, mindig vált isHome-ot, akkor is ha nem váltok át
                isHome = !isHome;
                leftHome +=
                    0.5; //és egészre kerekítve adom meg majd, így azt írja ki hányszor mentem el otthonról, nem a toggle számot
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
