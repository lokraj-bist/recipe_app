import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'categorywidget.dart';
import 'package:recipeapp/screens/categoryscreen.dart';
import 'package:recipeapp/services/categoryservices.dart';

class topicons extends StatelessWidget {
  final VoidCallback onFilterPressed;

  topicons({required this.onFilterPressed});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding:  EdgeInsets.only(left: 8.0,right: 0,top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        child: categoryscreens(),
                        type: PageTransitionType.fade));
                CategoryService.getCategory();
              },
              icon: Icon(
                IconlyBold.category,
                size: 40,
                color: Colors.white,
              )),
          Text(
            'Recipe',
            style: TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                      child: Column(), type: PageTransitionType.fade));
            },
            icon: IconButton(
              onPressed: onFilterPressed,
              icon: Icon(
                IconlyBold.filter,
                size: 40,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
