import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import '../services/foodservice.dart';
import 'package:recipeapp/models/food_model.dart';
import 'package:recipeapp/widgets/gridcontainer.dart';

class AllFoods extends StatefulWidget {
  @override
  State<AllFoods> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllFoods> {
  final FoodService _foodService = FoodService();
  late List<Food> foodData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getFoodData();
  }

  void getFoodData() async {
    try {
      foodData = await _foodService.fetchFoods();
    } catch (e) {
      print(e);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252c4a),
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding:    EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
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
                    'All Products',
                    textAlign: TextAlign.center,
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
                  ? Center(
                child: CupertinoActivityIndicator(
                  radius: 20,
                  color: Colors.white,
                ),
              )
                  : foodData.isEmpty
                  ? Center(
                child: Text(
                  'No products available',
                  style: TextStyle(color: Colors.white),
                ),
              )
                  : Padding(
                padding:    EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 0.7,
                  ),
                  itemCount: foodData.length,
                  itemBuilder: (context, index) {
                    return gridcontainer(food: foodData[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
