import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:recipeapp/models/food_model.dart';
import 'package:recipeapp/provider/favorite_provider.dart';
import 'package:recipeapp/services/foodservice.dart';
import 'package:recipeapp/widgets/gridcontainer.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late Future<List<Food>> _foodsFuture;

  @override
  void initState() {
    super.initState();
    _foodsFuture = FoodService().fetchFoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252c4a),

      body: FutureBuilder<List<Food>>(
        future: _foodsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No foods available"));
          }

          List<Food> allFoods = snapshot.data!;


          List<int> favoriteIds = context.read<FavoriteProvider>().favoriteIds;


          List<Food> favoriteFoods = allFoods.where((food) {
            return favoriteIds.contains(food.id);
          }).toList();

          if (favoriteFoods.isEmpty) {
            return Center(child: Text("No favorites yet."));
          }


          return Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.7,
              ),
              itemCount: favoriteFoods.length,
              itemBuilder: (context, index) {
                final food = favoriteFoods[index];
                return gridcontainer(food: food);
              },
            ),
          );
        },
      ),
    );
  }
}
