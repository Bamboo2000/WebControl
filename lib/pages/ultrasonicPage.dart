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
    final blockWidth = MediaQuery.of(context).size.width / 2; //+if beépítése
    final blockHeight = MediaQuery.of(context).size.height / 2;

    //szükséges paraméterek
    late String isOpened, desc;

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListenableBuilder(
              listenable: listNotifier,
              builder: (BuildContext context, Widget? child) {
                final List<UltrasonicMessage> values =
                    listNotifier.ultrasonicMessages;

                //legfrissebb elemet olvassa ki a [0], [values.length-1]-gyel az utolsót olvashatom ki (az a door_state doc)
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
