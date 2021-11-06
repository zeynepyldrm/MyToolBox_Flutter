import 'package:flutter/material.dart';
import 'package:yapilacaklar_listesi/db/db_provider.dart';
import './model/task_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyTodoApp(),
    );
  }
}

class MyTodoApp extends StatefulWidget {
  const MyTodoApp({Key? key}) : super(key: key);

  @override
  _MyTodoAppState createState() => _MyTodoAppState();
}

class _MyTodoAppState extends State<MyTodoApp> {
  Color mainColor = Color(0xFF0D0952);
  Color secondColor = Color(0xFF212061);
  Color btnColor = Color(0xFFFF955B);
  Color editorColor = Color(0xFF4044CC);

  TextEditingController inputController = TextEditingController();
  String newTaskTxt = "";

  getTasks() async {
    return await DBProvider.db.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    // pubspec.yaml dosyasinda dependencyleri belirttim. sqflite fluttere portlanmis sqlite
    // path ise dosya yonetimi saglayan bir lib
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: secondColor,
        title: Text('Yapilacaklar'),
        actions: [
          Padding(
              padding: EdgeInsets.all(8.0),
              child: TextButton.icon(
                icon: Icon(
                  Icons.delete,
                  color: Colors.black,
                ),
                onPressed: () {
                  DBProvider.db.clear();
                  setState(() {});
                },
                label:
                    Text('Delete All', style: TextStyle(color: Colors.black)),
                style: TextButton.styleFrom(
                    shape: StadiumBorder(),
                    backgroundColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0)),
              ))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getTasks(),
              builder: (_, taskData) {
                switch (taskData.connectionState) {
                  case ConnectionState.waiting:
                    {
                      return Center(child: CircularProgressIndicator());
                    }
                  case ConnectionState.done:
                    {
                      if (taskData.data != Null) {
                        var tasksMap =
                            taskData.data as List<Map<String, dynamic>>;
                        return Padding(
                            padding: EdgeInsets.all(8.0),
                            child: ListView.builder(
                              itemCount: tasksMap.length,
                              itemBuilder: (context, index) {
                                String task = tasksMap[index]['task'];
                                String day = DateTime.parse(
                                        tasksMap[index]['createdDate'])
                                    .day
                                    .toString();
                                return Card(
                                    color: Colors.amberAccent,
                                    child: InkWell(
                                        child: Row(children: [
                                      Container(
                                        margin: EdgeInsets.only(right: 12.0),
                                        padding: EdgeInsets.all(12.0),
                                        child: Text(day),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(2.0))),
                                      ),
                                      Expanded(child: Text(task))
                                    ])));
                              },
                            ));
                      }
                    }
                }
                return Center(child: Text('You have no Task today'));
              },
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  color: editorColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 18.0),
              child: Row(children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Type a new Task"),
                    controller: inputController,
                  ),
                ),
                SizedBox(
                  width: 15.0,
                ),
                TextButton.icon(
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      newTaskTxt = inputController.text.toString();
                      inputController.text = "";
                    });
                    Task newTask =
                        Task(task: newTaskTxt, dateTime: DateTime.now());
                    DBProvider.db.addNewTask(newTask);
                  },
                  label:
                      Text('Add Task', style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: btnColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
                ),
              ]))
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}