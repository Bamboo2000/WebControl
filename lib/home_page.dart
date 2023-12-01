import 'package:flutter/material.dart';
import 'pages/mainPage.dart';
import 'pages/temperaturePage.dart';
import 'pages/ultrasonicPage.dart';
import 'pages/profilePage.dart';
import 'src/widgets.dart';
import 'package:provider/provider.dart';
import '../toggle.dart';
import '../app_state.dart';

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
  BottomNavigationBarItem(
    icon: Icon(Icons.person_outline),
    activeIcon: Icon(Icons.person),
    label: 'Profile',
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
    final width = MediaQuery.of(context).size.width;
    final bool isSmallScreen = width < 700;
    final bool isLargeScreen = width > 1200;

    final screens = [
      mainPage(),
      ultrasonicPage(),
      temperaturePage(),
      profilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: color_1,
        leadingWidth: 150,
        leading: const Center(
          child: Text(
            'WebControl',
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        title: Consumer<ApplicationState>(
          builder: (context, appState, _) => ToggleFunc(
            addisHome: (isHome) => appState.addMessageToUcontrol(isHome),
            values: appState.temperatureMessages, //kiolvasás
          ),
        ),
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
      bottomNavigationBar: isSmallScreen
          ? BottomNavigationBar(
              selectedItemColor: color_2,
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
          // This is the main content.
          Expanded(
            child: screens[_selectedIndex],
          )
        ],
      ),
    );
  }
}

class _InfoIcon extends StatelessWidget {
  const _InfoIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Tooltip(
      // decoration: BoxDecoration(
      //   color: color_6,
      //   borderRadius: BorderRadius.all(Radius.circular(5)),
      // ),
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
