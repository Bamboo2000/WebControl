import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:provider/provider.dart';
import '../app_state.dart';
import '../src/authentication.dart';
import '../src/widgets.dart';

class profilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          // const SizedBox(height: 8),
          const Header('Profile Settings'),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
                loggedIn: appState.loggedIn,
                signOut: () {
                  FirebaseAuth.instance.signOut();
                }),
          ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: color_5,
          ),
        ],
      ),
    );
  }
}

/* -- a column is fölös bele
Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.loggedIn) ...[
                  // const Header('RU Home?'),
                  ToggleFunc(
                    addisHome: (isHome) =>
                        appState.addMessageToUcontrol(isHome),
                  ),
                ],
              ],
            ),
          ),
          */