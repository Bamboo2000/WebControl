import 'package:flutter/material.dart';
import 'pages/mainPage.dart';
import 'pages/temperaturePage.dart';
import 'pages/ultrasonicPage.dart';
// import 'pages/profilePage.dart'; //végül nme használjuk
import 'src/widgets.dart';
import 'package:provider/provider.dart';
import '../toggle.dart';
import '../app_state.dart';

//az alsó navigáció elem elnevezések
const _navBarItems = [
  BottomNavigationBarItem(
    icon: Icon(Icons.home_outlined),
    activeIcon: Icon(Icons.home_rounded),
    label: 'Main Board',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.sensors),
    activeIcon: Icon(Icons.sensors),
    label: 'Ultrasonic Sensor',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.device_thermostat_outlined),
    activeIcon: Icon(Icons.device_thermostat_rounded),
    label: 'Temperature Sensor',
  ),
];

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    //ablak mérete
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 700;
    final bool isLargeScreen = width > 1200;

    //itt hívjuk meg az oldalakat (routing kicsit profibb)
    final screens = [
      mainPage(),
      ultrasonicPage(),
      temperaturePage(),
    ];

    //oldal tartalma - fejléc, navigációs ablakok
    return Scaffold(
      //appBar: fejléc
      appBar: AppBar(
        backgroundColor: color_1,

        //leading: fejléc bal sarka
        leadingWidth: 150,
        leading: const Center(
          child: Text(
            'WebControl',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),

        //title: fejléc közepe - toggle gomb
        title: Consumer<ApplicationState>(
          builder: (context, appState, _) => ToggleFunc(
            addisHome: (isHome) => appState.addMessageToUcontrol(isHome),
            values: appState.temperatureMessages, //kiolvasás
          ),
        ),

        //action: fejléc jobb sarka
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: CircleAvatar(
              backgroundColor: color_1,
              child: _InfoIcon(),
            ),
          )
        ],
      ),

      //ha kicsi a képernyő, alsó navbar
      bottomNavigationBar: isSmallScreen
          ? BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: color_1,
              backgroundColor: color_6,
              items: _navBarItems,
              currentIndex: _selectedIndex,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              })
          : null,

      //oldalsó navbár
      body: Row(
        children: <Widget>[
          if (!isSmallScreen)
            NavigationRail(
              selectedLabelTextStyle: const TextStyle(
                color: Colors.white,
                fontSize: 15,
              ),
              unselectedLabelTextStyle: const TextStyle(
                color: color_1,
                fontSize: 15,
              ),
              selectedIconTheme: const IconThemeData(color: Colors.white),
              unselectedIconTheme: const IconThemeData(color: color_1),
              backgroundColor: color_4,
              indicatorColor: color_3,
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              extended: isLargeScreen,
              destinations: _navBarItems
                  .map((item) => NavigationRailDestination(
                      icon: item.icon,
                      selectedIcon: item.activeIcon,
                      label: Text(
                        item.label!,
                      )))
                  .toList(),
            ),
          const VerticalDivider(thickness: 1, width: 1),

          // a főoldal tartalma - meghívja az oldalakat
          Expanded(
            child: screens[_selectedIndex],
          )
        ],
      ),
    );
  }
}

//fejlác jobb sarka külső fv
class _InfoIcon extends StatelessWidget {
  const _InfoIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Tooltip - felugró ablak
    return const Tooltip(
      message:
          'Webes alkalmazások fejlesztése HF\n\nKészítették:\nBalogh Árpád Mátyás - BWTY9G\nBarcza Bende - HS9T14\nBognár Péter - E8SJ91\nHubay Csenge - RNI5C7\nKnoll Ágoston - SZHWO7\n\n2023.12.01.',
      child: Icon(
        Icons.info_outline,
        size: 25,
        color: Colors.white,
      ),
    );
  }
}
