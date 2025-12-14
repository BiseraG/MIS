import '../models/meal_model.dart';

class FavoritesService {
  static final FavoritesService _instance = FavoritesService._internal();
  factory FavoritesService() => _instance;
  FavoritesService._internal();

  final List<MealPreview> _favorites = [];

  List<MealPreview> get favorites => _favorites;

  bool isFavorite(String mealId) {
    return _favorites.any((m) => m.id == mealId);
  }

  void toggleFavorite(MealPreview meal) {
    if (isFavorite(meal.id)) {
      _favorites.removeWhere((m) => m.id == meal.id);
    } else {
      _favorites.add(meal);
    }
  }
}
