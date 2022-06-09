import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:farmago/screens/bayer/Navigation/navigation_drawer_widget.dart';
import 'package:farmago/screens/bayer/Navigation/navigation_provider.dart';
import 'package:farmago/screens/farmer/Navigation/navigation_drawer_widget.dart';
import 'package:farmago/screens/farmer/Navigation/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePageB extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<HomePageB> {
  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => NavigationProviderB(),
      child: Scaffold(
          backgroundColor: Color.fromARGB(255, 62, 124, 149),
          drawer: NavigationDrawerWidgetB(),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 6, 60, 85),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CarouselSlider(

                  options: CarouselOptions(
                    enlargeCenterPage: true,
                    height: 280.0,
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    enableInfiniteScroll: true,
                  ),
                  items: [
                    'assets/home/Dash1.jpg',
                    'assets/home/Dash2.jpg',
                    'assets/home/Dash3.jpg',
                    'assets/home/Dash4.jpg',
                    'assets/home/Dash5.jpg',
                    'assets/home/Dash6.jpg'
                  ].map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: const BoxDecoration(color: Color.fromARGB(255, 6, 60, 85),),
                            child: Image.asset(
                              i,
                              fit: BoxFit.cover,
                            ));
                      },
                    );
                  }).toList(),
                ),
                SizedBox(height: 10,)
              ],
            ),
          )));
}
