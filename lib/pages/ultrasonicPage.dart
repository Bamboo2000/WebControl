import 'package:flutter/material.dart';
import 'package:web_control/src/widgets.dart';
import '../app_state.dart';

//hasonló a temperature oldalhoz, nincs részletesen kommentelve

//kiolvasáshoz
class UltrasonicMessage {
  UltrasonicMessage({required this.isOpened});
  final bool isOpened;
}

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

  final ApplicationState listNotifier;
  @override
  Widget build(BuildContext context) {
    //sortörés elkerülése és látványosabb funkció miatt
    //magasság állandó
    double blockHeight = 300;
    //szélesség bizonyos ablakméretig (kicsit több mint a közepes) állandó, utána arányosan nő
    late double blockWidth;
    if (MediaQuery.of(context).size.width > 800) {
      blockWidth = MediaQuery.of(context).size.width / 2;
    } else {
      blockWidth = 400;
    }

    //szükséges paraméterek
    late String isOpened, desc;

    //az oldal tartalma
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListenableBuilder(
              listenable: listNotifier,
              builder: (BuildContext context, Widget? child) {
                //List generálása az adatbázis adataiból
                final List<UltrasonicMessage> values =
                    listNotifier.ultrasonicMessages;

                //legfrissebb elemet olvassa ki a [0],
                //utolsó elemet a [values.length-1] (az a door_state doc jelenleg)
                if (values[0].isOpened == true) {
                  isOpened = 'CLOSE';
                  desc = 'OPENED';
                } else {
                  isOpened = 'OPEN';
                  desc = 'CLOSED';
                }

                //body tartalma
                return Block(isOpened, 'THE DOOR', "IT'S $desc", blockWidth,
                    blockHeight);
              },
            ),
          )
        ],
      ),
    );
  }
}
