import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pages/ultrasonicPage.dart';
import 'firebase_options.dart';
import 'dart:async';
import 'toggle.dart';

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

  StreamSubscription<QuerySnapshot>? _ultrasonicSubscription;
  List<UltrasonicMessage> _ultrasonicMessages = [];
  List<UltrasonicMessage> get ultrasonicMessages => _ultrasonicMessages;

  StreamSubscription<QuerySnapshot>? _homeSubscription;
  List<HomeMessage> _homeMessages = [];
  List<HomeMessage> get homeMessages => _homeMessages;

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

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _ultrasonicSubscription = FirebaseFirestore.instance
            .collection('door')
            .orderBy('ts', descending: true)
            .snapshots()
            .listen((snapshot) {
          _ultrasonicMessages = [];
          for (final document in snapshot.docs) {
            _ultrasonicMessages.add(
              UltrasonicMessage(
                isOpened: document.data()['open'] as bool,
              ),
            );
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _ultrasonicMessages = [];
        _ultrasonicSubscription?.cancel();
      }
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _homeSubscription = FirebaseFirestore.instance
            .collection('homeoraway')
            // .orderBy('ts', descending: true)
            .snapshots()
            .listen((snapshot) {
          _homeMessages = [];
          for (final document in snapshot.docs) {
            _homeMessages.add(
              HomeMessage(
                isHome: document.data()['isHome'] as bool,
              ),
            );
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _homeMessages = [];
        _homeSubscription?.cancel();
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
