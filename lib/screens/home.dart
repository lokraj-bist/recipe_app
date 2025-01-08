import 'package:card_swiper/card_swiper.dart';
import 'package:recipeapp/screens/all_foods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recipeapp/widgets/topicons.dart';
import 'package:recipeapp/widgets/slidebanner.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:recipeapp/widgets/gridcontainer.dart';
import 'package:page_transition/page_transition.dart';
import 'package:recipeapp/widgets/categorywidget.dart';
import 'package:recipeapp/services/foodservice.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipeapp/models/food_model.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _MyAppState();
}

class _MyAppState extends State<Home> {
  late List<Food> foodData = [];
  late List<Food> filteredData = [];
  String selectedFoodType = 'none';
  final focusNode=FocusNode();

  TextEditingController _controller = TextEditingController();

  void getFoodData() async {
    FoodService foodService = FoodService();
    foodData = await foodService.fetchFoods();
    filteredData = foodData;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getFoodData();
  }

  void filterFoods() {
    setState(() {
      filteredData = foodData.where((food) {
        bool matchFType = food.foodType == selectedFoodType;
        bool matchSQuery = food.foodName
            .toLowerCase()
            .contains(_controller.text.toLowerCase());
        return matchFType && matchSQuery;
      }).toList();
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Color(0xFF252c4a),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding:  EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'By Type',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10),
                ListTile(
                  title: Text(
                    'Vegetarian',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    setState(() {
                      selectedFoodType = 'Vegetarian';
                      filterFoods();
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text(
                    'Non-Vegetarian',
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    setState(() {
                      selectedFoodType = 'Non-Vegetarian';
                      filterFoods();
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xFF252c4a),
      body: SafeArea(
        child: Column(
          children: [
            topicons(onFilterPressed: _showFilterDialog,),
           GestureDetector(
             onTap: (){
               focusNode.unfocus();
             },
             child:  Padding(
               padding:  EdgeInsets.all(8.0),
               child: TextField(
                 keyboardType: TextInputType.none,
                 controller: _controller,
                 decoration: InputDecoration(
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(10),
                       borderSide: BorderSide(color: Colors.white, width: 1),
                     ),
                     hintText: 'Search',
                     filled: true,
                     fillColor: Colors.grey[200],
                     suffixIcon:Icon(IconlyLight.search)

                 ),
                 onChanged: (text) {
                   filterFoods();
                 },
               ),
             ),
           ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.25,
                      child: Swiper(
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return slide();
                        },
                        pagination: SwiperPagination(
                          alignment: Alignment.bottomCenter,
                          builder: DotSwiperPaginationBuilder(
                              color: Colors.white, activeColor: Colors.red),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding:  EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Available Food',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    child: AllFoods(),
                                    type: PageTransitionType.fade),
                              );
                            },
                            icon: Icon(Icons.arrow_circle_right_outlined,
                                color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    foodData.isEmpty
                        ? Padding(
                            padding:  EdgeInsets.only(top: 130),
                            child: Center(
                                child: CupertinoActivityIndicator(
                              color: Colors.white,
                            )),
                          )
                        : Padding(
                            padding:  EdgeInsets.only(
                                left: 8.0, top: 0, right: 8),
                            child: GridView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: filteredData.length > 3
                                  ? 3
                                  : filteredData.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.7,
                              ),
                              itemBuilder: (context, index) {
                                return gridcontainer(
                                  food: filteredData[index],
                                );
                              },
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
