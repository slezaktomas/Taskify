import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:thedo/Screens/add_category_screen.dart';

class CategoryScreen extends StatefulWidget {
  final List<Map<String, dynamic>> categoriesList;
  final TextEditingController categoryName;
  final Function(Map<String, String>) addCategoryCallback;
  final Function(Map<String, dynamic>) deleteCategoryCallback;
  final VoidCallback addNewCategory;
  Color currentColor;
  String selectedCategory;

  CategoryScreen({
    required this.categoriesList,
    required this.categoryName,
    required this.addCategoryCallback,
    required this.deleteCategoryCallback,
    required this.addNewCategory,
    required this.currentColor,
    required this.selectedCategory,
  });

  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Vyberte kategorii'),
          leading: IconButton(
              icon: const Icon(Icons.close, size: 35),
              onPressed: () {
                Navigator.of(context).pop();
              })),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Kategorie',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.add,
                    size: 35,
                  ),
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCategoryScreen(
                          categoryName: widget.categoryName,
                          addCategoryCallback: widget.addCategoryCallback,
                          addNewCategory: widget.addNewCategory,
                          currentColor: widget.currentColor,
                          selectedCategory: widget.selectedCategory,
                        ),
                      ),
                    );
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.categoriesList.length,
              itemBuilder: (context, index) {
                final category = widget.categoriesList[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.selectedCategory = category['color'];
                    });
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: ListTile(
                      title: Text(category['name']),
                      leading: Icon(
                        Icons.circle,
                        color: Color(int.parse(
                          category['color'].substring(6, 16),
                        )),
                      ),
                      /*Container(
                        height: 500,
                        width: 15,
                        color: Color(
                            int.parse(category['color'].substring(6, 16),)),
                        
                      ),*/

                      trailing: IconButton(
                        onPressed: () {
                          widget.deleteCategoryCallback(category);
                          setState(() {});
                        },
                        icon: const Icon(Icons.horizontal_rule),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
