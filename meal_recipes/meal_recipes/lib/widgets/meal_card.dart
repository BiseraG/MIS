import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../services/favorites_service.dart';

class MealCard extends StatelessWidget {
  final MealPreview meal;
  final VoidCallback onTap;

  MealCard({super.key, required this.meal, required this.onTap});

  final FavoritesService _favoritesService = FavoritesService();

  @override
  Widget build(BuildContext context) {
    final isFav = _favoritesService.isFavorite(meal.id);

    return Card(
      child: InkWell(
        onTap: onTap,
        child: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Image.network(meal.thumbnail, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    meal.name,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
            Positioned(
              right: 4,
              top: 4,
              child: IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  _favoritesService.toggleFavorite(meal);
                  (context as Element).markNeedsBuild();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
