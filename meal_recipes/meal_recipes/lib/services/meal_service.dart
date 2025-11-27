import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/meal_model.dart';

class MealService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<Category>> getCategories() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/categories.php'));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final categories = data['categories'] as List;
        return categories.map((json) => Category.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories');
      }
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<List<MealPreview>> getMealsByCategory(String category) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/filter.php?c=$category')
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List?;
        
        if (meals != null) {
          return meals.map((json) => MealPreview.fromJson(json)).toList();
        }
        return [];
      } else {
        throw Exception('Failed to load meals');
      }
    } catch (e) {
      throw Exception('Failed to load meals: $e');
    }
  }

  Future<Meal> getMealById(String id) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/lookup.php?i=$id')
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List;
        
        if (meals.isNotEmpty) {
          return Meal.fromJson(meals.first);
        } else {
          throw Exception('Meal not found');
        }
      } else {
        throw Exception('Failed to load meal details');
      }
    } catch (e) {
      throw Exception('Failed to load meal details: $e');
    }
  }

  Future<List<MealPreview>> searchMeals(String query) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/search.php?s=$query')
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List?;
        
        if (meals != null) {
          return meals.map((json) => MealPreview.fromJson(json)).toList();
        }
        return [];
      } else {
        throw Exception('Failed to search meals');
      }
    } catch (e) {
      throw Exception('Failed to search meals: $e');
    }
  }

  Future<Meal> getRandomMeal() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/random.php')
      );
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List;
        
        if (meals.isNotEmpty) {
          return Meal.fromJson(meals.first);
        } else {
          throw Exception('No random meal found');
        }
      } else {
        throw Exception('Failed to load random meal');
      }
    } catch (e) {
      throw Exception('Failed to load random meal: $e');
    }
  }
}