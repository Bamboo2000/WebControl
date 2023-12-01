import 'package:flutter/material.dart';
import 'package:web_control/src/widgets.dart';
import 'package:web_control/toggle.dart';
import '../app_state.dart';

class ultrasonicPage extends StatefulWidget {
  const ultrasonicPage({super.key});
  @override
  State<ultrasonicPage> createState() => _ultrasonicPageState();
}

class _ultrasonicPageState extends State<ultrasonicPage> {
  final ApplicationState _appstate = ApplicationState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ultrasonicBody(
        listNotifier: _appstate,
      ),
    );
  }
}

class ultrasonicBody extends StatelessWidget {
  const ultrasonicBody({super.key, required this.listNotifier});

  final ApplicationState listNotifier; //a példánysított állapothpz listNotifier

  @override
  Widget build(BuildContext context) {
    final blockWidth = MediaQuery.of(context).size.width / 2;
    final blockHeight = MediaQuery.of(context).size.height / 2;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListenableBuilder(
              listenable: listNotifier,
              builder: (BuildContext context, Widget? child) {
                // Minden alkalommal, amikor a lista változik, újraépítjük
                // így a framework tudja h frissíteni kell a rendert
                final List<TemperatureMessage> values =
                    listNotifier.temperatureMessages; // lista másolás

                return Block(
                    'CLOSE', 'THE DOOR', 'ITS OPENED', blockWidth, blockHeight);
              },
            ),
          )
        ],
      ),
    );
  }
}
