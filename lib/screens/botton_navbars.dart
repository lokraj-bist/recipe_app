import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:recipeapp/favorite_screen.dart';
import 'package:recipeapp/screens/favorite_foods.dart';
import 'package:recipeapp/screens/home.dart';

class NavScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<NavScreen> {
  int _sIndex = 0;

  final List<Widget> _pages = [
    Home(),
    FavoriteScreen(),
  ];

  void _onTap(int index) {
    setState(() {
      _sIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_sIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        currentIndex: _sIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        onTap: _onTap,
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(IconlyBold.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Favorite',
          ),
        ],
      ),
    );
  }
}
