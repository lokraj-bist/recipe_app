import 'dart:convert';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:recipeapp/models/food_model.dart';
import 'package:recipeapp/widgets/gridcontainer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FoodListScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;

  FoodListScreen({
    required this.categoryId,
    required this.categoryName,
  });

  @override
  _FoodListScreenState createState() => _FoodListScreenState();
}

class _FoodListScreenState extends State<FoodListScreen> {
  List<Food> foods = [];
  bool isLoading = true;
  String errorMessage = '';

  static const String baseUrl = 'https://lecook.pirus.app/api';

  @override
  void initState() {
    super.initState();
    fetchFoods();
  }

  Future<void> fetchFoods() async {
    try {
      final response = await http.get(Uri.parse(
          '$baseUrl/foods?populate=*&filters[category][id]=${widget.categoryId}'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['data'] ?? [];
        setState(() {
          foods = data.map((json) => Food.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          foods = [];
          errorMessage = 'Failed to load foods.';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        foods = [];
        errorMessage = 'An error occurred: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252c4a),
      body: Column(
        children: [
          Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 16.0, vertical: 30.0),            child: Row(
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
                  widget.categoryName,  
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : errorMessage.isNotEmpty
                ? Center(
              child: Text(
                errorMessage,
                style: TextStyle(color: Colors.white),
              ),
            )
                : foods.isEmpty
                ? Center(
              child: Text(
                'No foods available',
                style: TextStyle(color: Colors.white),
              ),
            )
                : GridView.builder(
              padding: EdgeInsets.all(8.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: foods.length,
              itemBuilder: (context, index) {
                return gridcontainer(food: foods[index]);
              },
            ) ,
          )

        ],
      ),
    );
  }
}
