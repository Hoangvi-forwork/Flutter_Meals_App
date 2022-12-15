import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const rountName = '/meal-detail-screen';
  final Function toggleFavorite;
  final Function isFavorite;
  const MealDetailScreen({
    super.key,
    required this.toggleFavorite,
    required this.isFavorite,
  });

  Widget buildSelectTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      height: 150,
      width: 300,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectMeal = DUMMY_MEALS.firstWhere(
      (meal) => meal.id == mealId,
    );
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(selectMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                selectMeal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            buildSelectTitle(context, 'Ingradients'),
            buildContainer(
              ListView.builder(
                itemCount: selectMeal.ingredients.length,
                itemBuilder: ((context, index) {
                  return Card(
                    color: Color.fromARGB(255, 185, 175, 179),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(
                        selectMeal.ingredients[index],
                      ),
                    ),
                  );
                }),
              ),
            ),
            buildSelectTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemCount: selectMeal.steps.length,
                itemBuilder: ((context, index) {
                  return Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          child: Text('#${(index + 1)}'),
                        ),
                        title: Text(selectMeal.steps[index]),
                      ),
                      // ignore: prefer_const_constructors
                      Divider(
                        height: 0.25,
                        color: Colors.black,
                      ),
                    ],
                  );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavorite(mealId),
        child: Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}
