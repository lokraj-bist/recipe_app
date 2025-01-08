class Food {
  final int id;
  final String foodName;
  final String foodType;
  final String steps;
  final String categoryName;
  final String foodThumbnail;
  final String foodBigImageUrl;
  final String recipeSteps;
  final String ingredients;
  bool isFavorite;

  Food({
    required this.id,
    required this.foodName,
    required this.foodType,
    required this.steps,
    required this.categoryName,
    required this.ingredients,
    required this.foodThumbnail,
    required this.foodBigImageUrl,
    required this.recipeSteps,
    required this.isFavorite,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'foodName': foodName,
      'foodType': foodType,
      'steps': steps,
      'categoryName': categoryName,
      'foodThumbnail': foodThumbnail,
      'foodBigImageUrl': foodBigImageUrl,
      'recipeSteps': recipeSteps,
      'ingredients': ingredients,
      'isFavorite': isFavorite,
    };
  }

  factory Food.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'];

    return Food(
      id: json['id'],
      foodName: attributes['foodName'],
      foodType: attributes['foodType'],
      steps: attributes['steps'],
      ingredients: attributes['ingredients'],
      categoryName: attributes['category']['data']['attributes']['categoryName'],
      foodThumbnail: 'https://lecook.pirus.app${attributes['foodPhoto']['data'][0]['attributes']['url']}',
      foodBigImageUrl: 'https://lecook.pirus.app${attributes['foodPhoto']['data'][1]['attributes']['url']}',
      recipeSteps: attributes['steps'],
      isFavorite: false,
    );
  }
}
