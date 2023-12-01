import 'package:flutter/material.dart';
import 'package:web_control/toggle.dart';
import '../app_state.dart';

class temperaturePage extends StatefulWidget {
  const temperaturePage({super.key});
  @override
  State<temperaturePage> createState() => _temperaturePageState();
}

class _temperaturePageState extends State<temperaturePage> {
  final ApplicationState _appstate = ApplicationState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListBody(
        listNotifier: _appstate,
      ),
    );
  }
}

class ListBody extends StatelessWidget {
  const ListBody({super.key, required this.listNotifier});

  final ApplicationState listNotifier;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          const Text('Current values:'),
          Expanded(
            child: ListenableBuilder(
              listenable: listNotifier,
              builder: (BuildContext context, Widget? child) {
                // We rebuild the ListView each time the list changes,
                // so that the framework knows to update the rendering.
                final List<TemperatureMessage> values =
                    listNotifier.temperatureMessages; // copy the list
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) => ListTile(
                    title: Text('${values[index].value}'),
                  ),
                  itemCount: values.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
