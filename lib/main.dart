import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/views/category_meals_screen.dart';
import 'package:meals_app/views/filtes_screen..dart';
import 'package:meals_app/views/meal_detail_screen.dart';
import 'package:meals_app/views/tabs_screen.dart';
import 'views/categories_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filtes = {
    'gluten': false,
    'lastose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _favoriteMeals = [];
  List<Meal> _availableMeals = DUMMY_MEALS;

  void _setFiltes(Map<String, bool> filtesData) {
    setState(() {
      _filtes = filtesData;

      _availableMeals = DUMMY_MEALS.where(
        (meal) {
          if (_filtes['gluten']! && !meal.isGlutenFree) {
            return false;
          }
          if (_filtes['lastose']! && !meal.isLactoseFree) {
            return false;
          }
          if (_filtes['vegan']! && !meal.isVegan) {
            return false;
          }
          if (_filtes['vegetarian']! && !meal.isVegetarian) {
            return false;
          }
          return true;
        },
      ).toList();
    });
  }

  void _toggleFavorite(String mealID) {
    final exitingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealID);
    if (exitingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(exitingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(
          DUMMY_MEALS.firstWhere((meal) => meal.id == mealID),
        );
      });
    }
  }

  bool _isfavoriteMeal(String id) {
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.pink,
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TabsScreen(
              favoriteMeals: _favoriteMeals,
            ),
        CategoryMealScreen.rountName: (context) => CategoryMealScreen(
              availableMeals: _availableMeals,
            ),
        MealDetailScreen.rountName: (context) => MealDetailScreen(
              toggleFavorite: _toggleFavorite,
              isFavorite: _isfavoriteMeal,
            ),
        FiltesScreen.rountName: (context) => FiltesScreen(
              currentFitles: _filtes,
              setFiltes: _setFiltes,
            ),
      },
    );
  }
}
