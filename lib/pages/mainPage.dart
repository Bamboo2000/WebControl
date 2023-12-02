import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'package:google_fonts/google_fonts.dart';

import '../app_state.dart';
import '../src/authentication.dart';
import '../src/widgets.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});
  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {
  final ApplicationState _appstate = ApplicationState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MainBody(
        listNotifier: _appstate,
      ),
    );
  }
}

class MainBody extends StatelessWidget {
  const MainBody({super.key, required this.listNotifier});

  final ApplicationState listNotifier;

  @override
  Widget build(BuildContext context) {
    //post collection, post_state doc elérése
    final postRef =
        FirebaseFirestore.instance.collection("post").doc("post_state");

    //átméretezhetőség
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 700;
    final bool isLargeScreen = width > 1200;

    //képernyőtől függő sorok száma
    late int rownumber;
    if (isSmallScreen) {
      rownumber = 1;
    } else if (isLargeScreen) {
      rownumber = 3;
    } else {
      rownumber = 2;
    }

    return Scaffold(
        backgroundColor: color_5,
        // 6 db blokk deklarálása, majd feltöltése tartalommal
        body: GridView.count(
          crossAxisCount: rownumber,
          children: List.generate(6, (index) {
            //---------------------WELCOME-SCREEN-------------------------
            if (index == 0) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: Card(
                  color: color_1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Hello!',
                        style: TextStyle(
                          fontSize: 40,
                          color: color_5,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text("I'm a card. You will find a lot of us.",
                          style: TextStyle(fontSize: 15, color: color_6)),
                      Text(
                        "I can be a lot of things.",
                        style: TextStyle(
                            fontSize: 15,
                            letterSpacing: 3.6,
                            color: color_4,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(height: 10),
                      Text("Enjoy your stay!",
                          style: TextStyle(
                            fontSize: 25,
                            color: color_5,
                          )),
                    ],
                  ),
                ),
              );
            }
            //---------------------PROFILE-PART-------------------------
            if (index == 1) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.all(Radius.circular(150))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Header('Profile Settings'),
                      Consumer<ApplicationState>(
                        builder: (context, appState, _) => AuthFunc(
                            loggedIn: appState.loggedIn,
                            signOut: () {
                              FirebaseAuth.instance.signOut();
                            }),
                      ),
                    ],
                  ),
                ),
              );
            }
            //---------------------STATS-DEMO-------------------------
            if (index == 2) {
              return const Block(
                  '12', 'I can be a cool', "SENSOR VALUE", 250, 250);
            }
            //---------------------POST-BUTTON-------------------------
            if (index == 3) {
              return Card(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'I can also:',
                    style: GoogleFonts.playfairDisplay(
                      textStyle:
                          const TextStyle(fontSize: 30, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  PostButton(
                    onPressed: () async {
                      // post cellectionben true-ra vált
                      // for myself: csak a final postRef kell hozzá
                      postRef.update({"post": true});
                    },
                    mainText: 'POST',
                    secondText: 'A QUOTE',
                  ),
                ],
              ));
            }
            //---------------------HOME-AWAY-------------------------
            if (index == 4) {
              return const Text('1');
            }
            //---------------------LAST-SOMETHING-------------------------
            else {
              //ha vmi hiba ütne be
              return const Block('ect.', 'more', "WHAT'S NEXT?", 270, 250);
            }
          }),
        ));
  }
}
