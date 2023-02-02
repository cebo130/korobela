import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:korobela/screens/tabs_screen.dart';

import 'menu_page.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) => ZoomDrawer(
   // style: DrawerStyle.style1,
    mainScreen: TabsScreen(),
    menuScreen: MenuPage(),
    menuBackgroundColor: Colors.purple,
  );
}
