import 'package:flutter/material.dart';
import 'package:web_control/src/widgets.dart';
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
      body: TemperatureBody(
        listNotifier: _appstate,
      ),
    );
  }
}

class TemperatureBody extends StatelessWidget {
  const TemperatureBody({super.key, required this.listNotifier});

  final ApplicationState listNotifier; //a példánysított állapothpz listNotifier

  @override
  Widget build(BuildContext context) {
    //képernyő mérete
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 700;
    final bool isLargeScreen = width > 1200;

    //szükséges változók
    double allTimeAVG = 0;
    double allTime = 0;
    double onehourTimeAVG = 0;
    double onehourTime = 0;
    double onedayTimeAVG = 0;
    double onedayTime = 0;

    //a képernyő méretétől függően mennyi oszlopa legyen a gridnek
    late int rownumber;
    if (isSmallScreen) {
      rownumber = 1;
    } else if (isLargeScreen) {
      rownumber = 3;
    } else {
      rownumber = 2;
    }

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

                // kiiratjuk az össze elemet sorban - végül nem használjuk
                // return ListView.builder(
                //   itemBuilder: (BuildContext context, int index) => ListTile(
                //     title: Text('${values[index].value}'),
                //   ),
                //   itemCount: values.length,
                // );

                // idő hiányában nem a timestamp alapján kérdezzük le,
                // csak az utolsó x db értéket nézzük
                for (int i = 0; i < values.length; i++) {
                  allTime += values[i].value;
                  allTimeAVG = allTime / i;
                }
                for (int i = 0; i < 100; i++) {
                  onehourTime += values[i].value;
                  onehourTimeAVG = onehourTime / i;
                }
                for (int i = 0; i < 150; i++) {
                  onedayTime += values[i].value;
                  onedayTimeAVG = onedayTime / i;
                }

                // a Block függvény példányosításához szükséges értékek
                var valueList = [
                  values[0].value.toStringAsFixed(2),
                  onehourTimeAVG.toStringAsFixed(2),
                  onedayTimeAVG.toStringAsFixed(2),
                  allTimeAVG.toStringAsFixed(2),
                  '?'
                ];
                var unitList = ['°C', '°C', '°C', '°C', 'unit'];
                var nameList = [
                  'CURRENT TEMPERATURE',
                  'LAST HOUR AVG',
                  'DAILY AVERAGE',
                  'ALL TIME AVG',
                  'COMING SOON'
                ];

                //grid view generálása, elemeinek meghatározása
                return Scaffold(
                    body: GridView.count(
                  crossAxisCount: rownumber,
                  children: List.generate(5, (index) {
                    return Center(
                        child: Block(valueList[index], unitList[index],
                            nameList[index], 270, 240));
                  }),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
