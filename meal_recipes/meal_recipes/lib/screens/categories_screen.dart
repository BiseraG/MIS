import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/meal_service.dart';
import '../widgets/category_card.dart';
import 'meals_by_category_screen.dart'; 
import '../services/notification_service.dart';
import 'favorites_screen.dart';
import 'random_meal_screen.dart'; 


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final MealService _mealService = MealService();
  List<Category> _categories = [];
  List<Category> _filteredCategories = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadCategories();
    _searchController.addListener(_filterCategories);
     NotificationService().init();
  }

  Future<void> _loadCategories() async {
    try {
      final categories = await _mealService.getCategories();
      setState(() {
        _categories = categories;
        _filteredCategories = categories;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterCategories() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        _filteredCategories = _categories
            .where((category) =>
                category.name.toLowerCase().contains(query) ||
                category.description.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _navigateToMealsScreen(Category category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealsByCategoryScreen(category: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Categories'),
        actions: [
  IconButton(
    icon: const Icon(Icons.favorite),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => FavoritesScreen()),
      );
    },
  ),
  IconButton(
    icon: const Icon(Icons.shuffle),
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const RandomMealScreen()),
      );
    },
  ),
],

      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text('Error: $_error'))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search categories...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.60,
                        ),
                        itemCount: _filteredCategories.length,
                        itemBuilder: (context, index) {
                          final category = _filteredCategories[index];
                          return CategoryCard(
                            category: category,
                            onTap: () => _navigateToMealsScreen(category),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}