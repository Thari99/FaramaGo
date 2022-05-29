import 'package:flutter/material.dart';

class view_page extends StatefulWidget {
  const view_page({Key? key}) : super(key: key);

  @override
  State<view_page> createState() => _view_pageState();
}

class _view_pageState extends State<view_page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  title: Text('Card Number 1'),
                  subtitle: Text(
                    'Card Number Sub',
                    style: TextStyle(
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                ),
                Image(image: AssetImage('assets/welcome-page/farmer.png'),
                height: 250,
                width: 250,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
