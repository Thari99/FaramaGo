import 'package:farmago/screens/farmer/Navigation/navigation_drawer_widget.dart';
import 'package:farmago/screens/farmer/Navigation/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageF extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<HomePageF> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => NavigationProviderF(),
      child: Scaffold(
        drawer: NavigationDrawerWidgetF(),
        appBar: AppBar(
          // backgroundColor: Colors.red,
          centerTitle: true,
        ),
      ));
}