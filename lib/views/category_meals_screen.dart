import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealScreen extends StatefulWidget {
  static const rountName = '/category-meals';
  final List<Meal> availableMeals;
  const CategoryMealScreen({
    super.key,
    required this.availableMeals,
  });

  @override
  State<CategoryMealScreen> createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeals;
  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)?.settings.arguments as Map<String, String>;
      final categoryID = routeArgs['id'];
      categoryTitle = routeArgs['title']!;
      displayedMeals = widget.availableMeals.where((meal) {
        return meal.categories.contains(categoryID);
      }).toList();
      _loadedInitData = true;
    }
  }

  void _removeMeal(String mealID) {
    setState(() {
      displayedMeals?.removeWhere((meal) => meal.id == mealID);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(categoryTitle.toString()),
      ),
      body: ListView.builder(
        itemCount: displayedMeals?.length,
        itemBuilder: ((context, index) {
          return MealItem(
            id: displayedMeals![index].id,
            title: displayedMeals![index].title,
            imageUrl: displayedMeals![index].imageUrl,
            affordability: displayedMeals![index].affordability,
            duration: displayedMeals![index].duration,
            complexity: displayedMeals![index].complexity,
            // removeItem: _removeMeal,
          );
        }),
      ),
    );
  }
}
