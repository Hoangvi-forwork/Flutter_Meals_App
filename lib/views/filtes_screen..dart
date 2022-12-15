import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FiltesScreen extends StatefulWidget {
  static const rountName = '/filtes';
  final Function setFiltes;
  final Map<String, bool> currentFitles;

  const FiltesScreen(
      {super.key, required this.setFiltes, required this.currentFitles});

  @override
  State<FiltesScreen> createState() => _FiltesScreenState();
}

class _FiltesScreenState extends State<FiltesScreen> {
  bool _glutenFree = false;
  bool _veretarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  @override
  void initState() {
    super.initState();
    _glutenFree = widget.currentFitles['gluten']!;
    _lactoseFree = widget.currentFitles['lastose']!;
    _vegan = widget.currentFitles['vegan']!;
    _veretarian = widget.currentFitles['vegetarian']!;
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(description),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Your Filtes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final selectedFiltes = {
                'gluten': _glutenFree,
                'lastose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _veretarian,
              };
              widget.setFiltes(selectedFiltes);
            },
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text('Adjust your meal selection'),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile("Gluten - Free",
                    'Only include gluten-free meals', _glutenFree, (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                _buildSwitchListTile("Veretarian - Free",
                    'Only include gluten-free meals', _veretarian, (newValue) {
                  setState(() {
                    _veretarian = newValue;
                  });
                }),
                _buildSwitchListTile(
                    "Vegan - Free", 'Only include gluten-free meals', _vegan,
                    (newValue) {
                  setState(() {
                    _vegan = newValue;
                  });
                }),
                _buildSwitchListTile("LactoseFree - Free",
                    'Only include gluten-free meals', _lactoseFree, (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
