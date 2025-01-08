import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipeapp/models/food_model.dart';

class FoodService {
  Future<List<Food>> fetchFoods() async {
    final response = await http.get(Uri.parse(
        'https://lecook.pirus.app/api/foods?populate=*'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['data'];
      return data.map((json) => Food.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load foods');
    }
  }
}
