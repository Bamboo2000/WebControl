import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'dart:async';
import 'toggle.dart';
import 'pages/mainPage.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  //kiolvasáshoz
  StreamSubscription<QuerySnapshot>? _temperatureSubscription;
  List<TemperatureMessage> _temperatureMessages = [];
  List<TemperatureMessage> get temperatureMessages => _temperatureMessages;

  Future<void> init() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(),
    ]);

    //kiolvasás (bőv.)
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _temperatureSubscription = FirebaseFirestore.instance
            .collection('temperature')
            .orderBy('ts', descending: true)
            .snapshots()
            .listen((snapshot) {
          _temperatureMessages = [];
          for (final document in snapshot.docs) {
            _temperatureMessages.add(
              TemperatureMessage(
                value: document.data()['value'] as double,
              ),
            );
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _temperatureMessages = [];
        _temperatureSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  Future<DocumentReference> addMessageToUcontrol(bool isHome) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('homeoraway')
        .add(<String, dynamic>{
      'isHome': isHome,
      'ts': DateTime.now(),
    });
  }
}
