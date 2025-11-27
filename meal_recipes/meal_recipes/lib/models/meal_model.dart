class Meal {
  final String id;
  final String name;
  final String thumbnail;
  final String? instructions;
  final String? youtubeUrl;
  final List<Ingredient> ingredients;

  Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    this.instructions,
    this.youtubeUrl,
    required this.ingredients,
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredients = [];
    
    for (int i = 1; i <= 20; i++) {
      String ingredient = json['strIngredient$i'] ?? '';
      String measure = json['strMeasure$i'] ?? '';
      
      if (ingredient.trim().isNotEmpty) {
        ingredients.add(Ingredient(
          name: ingredient,
          measure: measure,
        ));
      }
    }

    return Meal(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
      instructions: json['strInstructions'],
      youtubeUrl: json['strYoutube'],
      ingredients: ingredients,
    );
  }
}

class Ingredient {
  final String name;
  final String measure;

  Ingredient({
    required this.name,
    required this.measure,
  });
}

class MealPreview {
  final String id;
  final String name;
  final String thumbnail;

  MealPreview({
    required this.id,
    required this.name,
    required this.thumbnail,
  });

  factory MealPreview.fromJson(Map<String, dynamic> json) {
    return MealPreview(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnail: json['strMealThumb'] ?? '',
    );
  }
}