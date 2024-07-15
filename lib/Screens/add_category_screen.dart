import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class AddCategoryScreen extends StatefulWidget {
  final TextEditingController categoryName;
  final Function(Map<String, String>) addCategoryCallback;
  final VoidCallback addNewCategory;
  Color currentColor;
  String selectedCategory;

  AddCategoryScreen({
    required this.categoryName,
    required this.addCategoryCallback,
    required this.addNewCategory,
    required this.currentColor,
    required this.selectedCategory,
  });

  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  Color pickerColor = Color.fromARGB(255, 1, 217, 255);

  void changeColor(Color color) {
    setState(() {
      pickerColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Přidat štítek'),
          leading: IconButton(
              icon: const Icon(Icons.close, size: 35),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              })),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Přidat štítek',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: TextField(
                  controller: widget.categoryName,
                  decoration: const InputDecoration(
                    hintText: 'Zadejte název štítku',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                    border: InputBorder.none,
                  ),
                ),
              ),
              ColorPicker(
                enableAlpha: false,
                portraitOnly: true,
                paletteType: PaletteType.hueWheel,
                pickerColor: pickerColor,
                onColorChanged: changeColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextButton(
                  onPressed: () => {
                    widget.currentColor = pickerColor,
                    widget.addCategoryCallback({
                      'name': widget.categoryName.text,
                      'color': widget.currentColor.toString(),
                    }),
                    Navigator.of(context).pop({}),
                    setState(() {}),
                  },
                  child: const Text("Přidat štítek"),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
