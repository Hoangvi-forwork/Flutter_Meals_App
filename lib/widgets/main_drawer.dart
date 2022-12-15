import 'package:flutter/material.dart';
import 'package:meals_app/views/filtes_screen..dart';
import '../views/category_meals_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTitle(String title, IconData icon, VoidCallback? tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Roboto',
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Cooking Up",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          buildListTitle(
            'Meals',
            Icons.restaurant,
            () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          buildListTitle(
            'Filtes',
            Icons.settings,
            () {
              Navigator.of(context)
                  .pushReplacementNamed(FiltesScreen.rountName);
            },
          ),
        ],
      ),
    );
  }
}
