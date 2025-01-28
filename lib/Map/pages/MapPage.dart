import 'package:flutter/material.dart';
import 'package:shorts_restaurant/Widgets/BottomNavBar.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.lightGreen,
              child: Center(
                child: Text(
                  '지도페이지'
                ),
              ),
            ),
          ),
          BottomNavBar(context, 'map')
        ],
      ),
    );
  }
}
