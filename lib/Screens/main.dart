import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';
import 'package:thedo/Screens/add_task_screen.dart';
import 'package:thedo/Screens/category_screen.dart';

void main() {
  AwesomeNotifications().initialize(
    'resource://drawable/res_app_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: const Color(0xFF9D50DD),
        ledColor: Colors.white,
      )
    ],
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.transparent),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Map<String, dynamic>> tasks = [];
  final List<Map<String, dynamic>> categories = [];
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController categoryNameController = TextEditingController();
  double value = 0.0;
  List<Map<String, dynamic>> selectedCategories = [];
  String selectedCategory = '';
  String priority = '';
  bool isSelected = false;
  String filter = '';

  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  void addTask(Map<String, Object> task) {
    setState(() {
      tasks.add({...task, 'isChecked': false});
    });
  }

  void deleteTask(BuildContext context, Map<String, dynamic> task) {
    setState(() {
      tasks.remove(task);
    });
  }

  void addCategory(Map<String, dynamic> category) {
    setState(() {
      categories.add(category);
    });
  }

  void deleteCategory(BuildContext context, Map<String, dynamic> category) {
    setState(() {
      categories.remove(category);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(250, 251, 254, 255),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(250, 251, 254, 255),
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(250, 251, 254, 255),
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 50.0),
                        child: Text(
                          'Taskify',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.settings,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Card(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: ListTile(
                leading: const Icon(Icons.circle_outlined, color: Colors.black),
                title: const Text('Všechny úkoly'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: ExpansionTile(
                leading: const Icon(Icons.label_outlined, color: Colors.black),
                title: const Text('Štítky'),
                children: [
                  ListTile(
                    title: const Text('Kategorie'),
                    onTap: () {},
                  ),
                  ListTile(
                    title: const Text('Přidat kategorii'),
                    onTap: () {},
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: ExpansionTile(
                leading: const Icon(Icons.hourglass_empty, color: Colors.black),
                title: const Text('Priorita'),
                children: [
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Color(0xFfA5DD9B),
                      ),
                    ),
                    title: const Text('Nízká'),
                    onTap: () {
                      filter = 'Low';
                      print(filter);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Color(0xFfFF6F193),
                      ),
                    ),
                    title: const Text('Střední'),
                    onTap: () {
                      filter = "Mid";
                      print(filter);
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: const CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        radius: 8,
                        backgroundColor: Color(0xFfFFF8080),
                      ),
                    ),
                    title: const Text('Vysoká'),
                    onTap: () {
                      filter = "High";
                      print(filter);
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ),
            Card(
              shadowColor: Colors.transparent,
              color: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: ListTile(
                leading:
                    const Icon(Icons.task_alt_outlined, color: Colors.black),
                title: const Text('Dokončené úkoly'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 25.0, bottom: 10.0),
              child: Text(
                "ŠTÍTKY:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: categories.isEmpty
                  ? Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(
                          'Nejsou dostupné žádné kategorie.',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  : SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: categories.map((category) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 10.0),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 100,
                                width: 200,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0, left: 10),
                                          child: Text(
                                            category['name'],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 20.0, left: 20),
                                          child: CircleAvatar(
                                            radius: 10,
                                            backgroundColor: Colors.black,
                                            child: CircleAvatar(
                                              radius: 8,
                                              backgroundColor: Color(int.parse(
                                                  category['color']
                                                      .substring(6, 16))),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          10, 15, 10, 0),
                                      child: LinearProgressIndicator(
                                        minHeight: 5,
                                        value: value,
                                        backgroundColor: Colors.grey[300],
                                        valueColor:
                                            const AlwaysStoppedAnimation<Color>(
                                          Color(0xFffaa5be),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
              child: Text(
                "DNEŠNÍ ÚKOLY:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
            if (filter == 'Low')
              Expanded(
                child: tasks
                        .where((task) => task['priority'] == 'Low')
                        .toList()
                        .isEmpty
                    ? Center(
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text(
                            'Žádné úkoly nejsou dostupné. Přidejte úkol a žačněte!',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey[600],
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 30.0),
                          child: Column(
                              children: tasks.map((task) {
                            return Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: Dismissible(
                                  dragStartBehavior: DragStartBehavior.start,
                                  key: Key(task['name']),
                                  onDismissed: (direction) {
                                    setState(() {
                                      deleteTask(context, task);
                                    });
                                  },
                                  background: Container(
                                    color: Colors.red,
                                    child: const Icon(
                                      Icons.delete,
                                      color: Colors.white,
                                    ),
                                  ),
                                  child: Card(
                                    shadowColor: Colors.transparent,
                                    color: Colors.transparent,
                                    surfaceTintColor: Colors.transparent,
                                    child: ListTile(
                                      leading: Checkbox(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        checkColor: Colors.white,
                                        value: task['isChecked'],
                                        onChanged: (bool? value) {
                                          setState(() {
                                            task['isChecked'] = value;
                                          });
                                        },
                                      ),
                                      title: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              task['name'],
                                              maxLines: 1,
                                              overflow: TextOverflow.fade,
                                              softWrap: false,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                decoration: task['isChecked'] ==
                                                        true
                                                    ? TextDecoration.lineThrough
                                                    : TextDecoration.none,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      trailing: Chip(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          side: const BorderSide(
                                            color: Colors.black,
                                            width: 2,
                                          ),
                                        ),
                                        label: Text(
                                          task["priority"],
                                          style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        backgroundColor: task['priority'] ==
                                                'High'
                                            ? const Color(0xFfFFF8080)
                                            : task['priority'] == 'Mid'
                                                ? const Color(0xFfFF6F193)
                                                : task['priority'] == 'Low'
                                                    ? const Color(0xFfA5DD9B)
                                                    : Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ));
                          }).toList()),
                        ),
                      ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(250, 251, 254, 255),
        shape: const CircleBorder(
          side: BorderSide(
            color: Colors.black,
            width: 2,
          ),
        ),
        elevation: 0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => AddTaskScreen(
                taskName: taskNameController,
                categoryName: categoryNameController,
                addTaskCallback: addTask,
                addCategoryCallback: addCategory,
                categoriesLList: categories,
                onCategoryAdded: () {
                  setState(() {});
                },
                selectedCategory: selectedCategory,
                currentColor: const Color.fromARGB(255, 228, 12, 77),
                priority: priority,
              ),
            ),
          );
        },
        tooltip: 'Add task',
        child: const Icon(
          Icons.add,
          color: Colors.black,
          size: 30,
        ),
      ),
    );
  }

  @override
  void dispose() {
    taskNameController.dispose();
    categoryNameController.dispose();
    super.dispose();
  }
}
