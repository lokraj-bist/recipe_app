import 'dart:convert';

import 'package:recipeapp/services/categoryservices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipeapp/widgets/categorywidget.dart';
import 'package:recipeapp/models/category_model.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import '../consts/apiconst.dart';

class categoryscreens extends StatefulWidget {
  @override
  State<categoryscreens> createState() => _categoryscreensState();
}

class _categoryscreensState extends State<categoryscreens> {
  List<cmodel> data = [];

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  Future getCategory() async {
    data = await CategoryService.getCategory();
    setState(() {});
    print('data are${data}');
  }

  @override
  Widget build(BuildContext context) {

   return Scaffold(
      backgroundColor: Color(0xFF252c4a),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                   EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        IconlyBold.arrowLeftCircle,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    textAlign: TextAlign.center,
                    'Categories',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('')
                ],
              ),
            ),
            Expanded(
              child: data.isEmpty
                  ? Center(
                child: CupertinoActivityIndicator(
                  radius: 20,
                  color: Colors.white,
                ),
              )
                  : GridView.builder(
                padding: EdgeInsets.all(16),
                itemCount: data.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  return categorywidget(
                    name: data[index].categoryName!,
                    icon: Icon(Icons.emoji_food_beverage_outlined, color: Colors.white),
                    categoryId: data[index].id!,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
