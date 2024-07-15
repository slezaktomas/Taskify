import 'package:flutter/material.dart';
import 'package:thedo/Screens/add_category_screen.dart';
import 'package:thedo/Screens/category_screen.dart';

import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  AddTaskScreen({
    super.key,
    required this.taskName,
    required this.addTaskCallback,
    required this.addCategoryCallback,
    required this.categoryName,
    required this.categoriesLList,
    required this.onCategoryAdded,
    required this.currentColor,
    required this.selectedCategory,
    required this.priority,
  });

  final TextEditingController taskName;
  final TextEditingController categoryName;
  final Function(Map<String, Object>) addTaskCallback;
  final Function(Map<String, dynamic>) addCategoryCallback;
  final VoidCallback onCategoryAdded;
  List<Map<String, dynamic>> categoriesLList = [];
  String selectedCategory;
  Color currentColor;
  String priority = '';

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  void deleteCategory(Map<String, dynamic> category) {
    setState(() {
      widget.categoriesLList.remove(category);
    });
    widget.onCategoryAdded();
  }

  void addNewCategory() {
    if (widget.categoryName.text.isNotEmpty) {
      final newCategory = {
        'name': widget.categoryName.text,
        'color': widget.currentColor.toString()
      };
      setState(() {
        widget.categoriesLList.add(newCategory);
      });
      widget.categoryName.clear();
      widget.onCategoryAdded();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(250, 251, 254, 255),
      appBar: AppBar(
        leading: const SizedBox(),
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(50, 50, 50, 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 80),
                child: TextField(
                  style: const TextStyle(fontSize: 20),
                  decoration: const InputDecoration(
                    hintText: 'Zadejte nový úkol',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                    border: InputBorder.none,
                  ),
                  controller: widget.taskName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text("Přidat štítky", style: TextStyle(fontSize: 20)),
              ),
              Wrap(
                spacing: 15.0,
                children: widget.categoriesLList.map((category) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.selectedCategory = category['name'];
                        print(widget.selectedCategory);
                      });
                    },
                    child: Chip(
                      avatar: CircleAvatar(
                        radius: 8,
                        backgroundColor: Colors.black,
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: Color(
                              int.parse(category['color'].substring(6, 16))),
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: Colors.black, width: 2),
                      ),
                      label: Text(
                        category['name']!,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: Colors.transparent,
                      deleteIcon: Icon(Icons.close, size: 18),
                      onDeleted: () => deleteCategory(category),
                    ),
                  );
                }).toList(),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: TextButton.icon(
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                            side: BorderSide(color: Colors.black, width: 2))),
                    onPressed: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCategoryScreen(
                            categoryName: widget.categoryName,
                            addCategoryCallback: (newCategory) {
                              setState(() {
                                widget.categoriesLList.add(newCategory);
                              });
                              widget.categoryName.clear();
                              widget.onCategoryAdded();
                            },
                            addNewCategory: addNewCategory,
                            currentColor: widget.currentColor,
                            selectedCategory: widget.selectedCategory,
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                    label: Text(
                      "Přidat nový štítek",
                      style: TextStyle(fontSize: 13),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Text("Úroveň priority", style: TextStyle(fontSize: 20)),
              ),
              Wrap(
                spacing: 15.0,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.priority = 'Low';
                      });
                    },
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: Colors.black, width: 2),
                      ),
                      label: Text(
                        "Low",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: const Color(0xFfA5DD9B),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.priority = 'Mid';
                      });
                      print(widget.priority);
                    },
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: Colors.black, width: 2),
                      ),
                      label: Text(
                        "Mid",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: const Color(0xFfFF6F193),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.priority = 'High';
                      });
                    },
                    child: Chip(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                        side: BorderSide(color: Colors.black, width: 2),
                      ),
                      label: Text(
                        "High",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      backgroundColor: const Color(0xFfFFF8080),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nový úkol',
            style: TextStyle(color: Colors.black, fontSize: 20)),
        icon: const Icon(Icons.expand_less_rounded,
            color: Colors.black, size: 25),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
            side: BorderSide(color: Colors.black, width: 2)),
        elevation: 0,
        onPressed: () {
          if (widget.taskName.text.isNotEmpty && widget.priority.isNotEmpty) {
            final newTask = {
              'name': widget.taskName.text,
              'categories': widget.categoriesLList,
              'priority': widget.priority,
            };
            widget.addTaskCallback(newTask);
            widget.taskName.clear();

            Navigator.of(context).pop();
          }
        },
        tooltip: 'Nový úkol',
        backgroundColor: Colors.transparent,
      ),
    );
  }
}
