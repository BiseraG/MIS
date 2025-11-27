import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../models/meal_model.dart';
import '../services/meal_service.dart';
import '../widgets/meal_card.dart';
import 'meal_detail_screen.dart';

class MealsByCategoryScreen extends StatefulWidget {
  final Category category;

  const MealsByCategoryScreen({
    super.key,
    required this.category,
  });

  @override
  State<MealsByCategoryScreen> createState() => _MealsByCategoryScreenState();
}

class _MealsByCategoryScreenState extends State<MealsByCategoryScreen> {
  final MealService _mealService = MealService();
  List<MealPreview> _meals = [];
  List<MealPreview> _filteredMeals = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _loadMeals();
    _searchController.addListener(_filterMeals);
  }

  Future<void> _loadMeals() async {
    try {
      final meals = await _mealService.getMealsByCategory(widget.category.name);
      setState(() {
        _meals = meals;
        _filteredMeals = meals;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  void _filterMeals() async {
    final query = _searchController.text.trim();
    
    if (query.isEmpty) {
      setState(() {
        _filteredMeals = _meals;
      });
    } else {
      try {
        final searchResults = await _mealService.searchMeals(query);
        final filtered = searchResults
            .where((meal) => _meals.any((m) => m.id == meal.id))
            .toList();
        setState(() {
          _filteredMeals = filtered;
        });
      } catch (e) {
        setState(() {
          _filteredMeals = _meals
              .where((meal) => meal.name.toLowerCase().contains(query.toLowerCase()))
              .toList();
        });
      }
    }
  }

  void _navigateToMealDetail(String mealId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MealDetailScreen(mealId: mealId),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.name),
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
                          hintText: 'Search meals...',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: _filteredMeals.isEmpty
                          ? const Center(
                              child: Text('No meals found'),
                            )
                          : GridView.builder(
                              padding: const EdgeInsets.all(8),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.75,
                              ),
                              itemCount: _filteredMeals.length,
                              itemBuilder: (context, index) {
                                final meal = _filteredMeals[index];
                                return MealCard(
                                  meal: meal,
                                  onTap: () => _navigateToMealDetail(meal.id),
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