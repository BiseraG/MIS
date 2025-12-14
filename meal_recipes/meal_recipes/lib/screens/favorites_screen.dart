import 'package:flutter/material.dart';
import '../services/favorites_service.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  final FavoritesService _favoritesService = FavoritesService();

  void _openDetails(BuildContext context, String id) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MealDetailScreen(mealId: id),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final favorites = _favoritesService.favorites;

    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Recipes')),
      body: favorites.isEmpty
          ? const Center(child: Text('No favorite meals yet ❤️'))
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
              ),
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final meal = favorites[index];
                return MealCard(
                  meal: meal,
                  onTap: () => _openDetails(context, meal.id),
                );
              },
            ),
    );
  }
}
