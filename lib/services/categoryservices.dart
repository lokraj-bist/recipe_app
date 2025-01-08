import 'dart:convert';
import 'package:recipeapp/consts/apiconst.dart';
import 'package:http/http.dart' as http;
import 'package:recipeapp/models/category_model.dart';

class CategoryService {
  static Future<List<cmodel>> getCategory() async {
    var uri = Uri.https(CATEGORY_BASE_URL, '/api/categories');
    try {
      var response = await http.get(uri);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print('Actual data: $data');
        List<dynamic> dataList = data['data'];
        return cmodel.categoryFromSnapshot(dataList);
      } else {
        print('Failed to fetch categories');
        return [];
      }
    } catch (e) {
      print(e);
      return [];
    }
  }
}
