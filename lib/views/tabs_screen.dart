// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:meals_app/views/categories_screen.dart';
import 'package:meals_app/views/favorites_screen.dart';
import 'package:meals_app/widgets/main_drawer.dart';

import '../models/meal.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  const TabsScreen({super.key, required this.favoriteMeals});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, dynamic>> _pages;

  int _selectPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _pages = [
      {
        'page': const CategoriesScreen(),
        'title': "Categories",
      },
      {
        'page': FavoritesScreen(
          favoriteMeals: widget.favoriteMeals,
        ),
        'title': "Your Favories",
      },
    ];
  }

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectPageIndex]['title']),
        ),
        drawer: const MainDrawer(),
        body: _pages[_selectPageIndex]['page'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (currentIndex) => _selectPage(currentIndex),
          currentIndex: _selectPageIndex,
          items: [
            const BottomNavigationBarItem(
              label: 'Categories',
              icon: Icon(Icons.category),
            ),
            const BottomNavigationBarItem(
              label: 'Favories',
              icon: Icon(Icons.star),
            )
          ],
        ));
  }
}
