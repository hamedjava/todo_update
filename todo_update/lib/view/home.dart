import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_listener/hive_listener.dart';
import 'package:todo_update/model/todo_model.dart';
import 'package:todo_update/view/components/custom_button.dart';
import 'package:todo_update/view/components/custom_textformfield.dart';
import 'package:todo_update/model/Database/Box/todo_box.dart' as box;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  final _fromKey = GlobalKey<FormState>();
  late List<TodoModel> listTodo;
  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    box.todoBox = await Hive.openBox("todoDB");
    setState(() {
      listTodo = box.todoBox.values.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Form(
          key: _fromKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Container(
                    width: width,
                    height: 150,
                    color: Colors.red[500],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "TODO App",
                            style: TextStyle(color: Colors.white, fontSize: 22),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                    title: "title", controller: titleController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    CustomTextField(title: "Date", controller: dateController),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomButton(
                    title: "submit",
                    onPressed: () {
                      if (_fromKey.currentState!.validate()) {
                        addItemToDB(titleController.text, dateController.text)
                            .then((value) {
                          getData();
                        });
                      } else {
                        return "Hamed";
                      }
                    }),
              ),
              Container(
                color: Colors.white,
                width: width / 1.6,
                height: height / 3.8,
                child: Visibility(
                  visible: false,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: Scaffold(
                    /**
                     * HiveListener(
                  box: Hive.box('settings'),
                  keys: ['dark_theme'], // keys is optional to specify listening value changes
                  builder: (box) {
                    return MaterialApp(
                      title: 'Flutter Demo',
                      theme: box.get('dark_theme', defaultValue: false) ? ThemeData.dark() : ThemeData.light(),
                      home: MyHomePage(title: 'Flutter Demo Home Page'),
                    );
                  },
                )
                     */
                    body: HiveListener<dynamic>(
                      box: box.todoBox,
                      builder: (box) {
                        return ListView.builder(
                            padding: const EdgeInsets.all(3),
                            itemCount: box.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                  height: 50,
                                  margin: const EdgeInsets.all(2),
                                  padding: const EdgeInsets.all(3),
                                  color: Colors.white,
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.email,
                                            textDirection: TextDirection.rtl,
                                            color: Colors.grey[600],
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              box.values
                                                  .toList()[index]
                                                  .title
                                                  .toString(),
                                              style:
                                                  const TextStyle(fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: const Icon(
                                                Icons.edit,
                                                color: Colors.green,
                                              ))
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(
                                                Icons.delete,
                                                color: Colors.red[500],
                                              ))
                                        ],
                                      ),
                                    ],
                                  )));
                            });
                      },
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future addItemToDB(String title, String date) async {
    box.todoBox = await Hive.openBox("todoDB");
    box.todoBox.add(TodoModel(title: title, date: date));
  }

  // Future<List<TodoModel>> retriveFromDB() async {
  //   box.todoBox = await Hive.openBox("todoDB");
  //   return box.todoBox.values.toList();
  // }
  // Future addItem(String title, String date) async {
//   await todoBox.add(TodoModel(title: title, date: date));
// }

// //void removeItemFromDB(int index) async
// Future removeItemFromDB(int index) async {
//   await todoBox.deleteAt(index);
// }

// Future editItemToList(int index, String title, String date) async {
//   await todoBox.putAt(index, TodoModel(title: title, date: date));
// }
}
