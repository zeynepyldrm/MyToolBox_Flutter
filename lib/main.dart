import 'package:flutter/material.dart';
import 'package:yapilacaklar_listesi/db/db_provider.dart';
import './model/task_model.dart';
import 'package:yapilacaklar_listesi/navigation.dart';
import 'package:yapilacaklar_listesi/theming/ThemeModel.dart';
import 'package:provider/provider.dart';
import 'package:dcdg/dcdg.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black12,
        ),
        debugShowCheckedModeBanner: false,
        home: NavigationAppBar());
  }
}

//to do list başlangıç
class MyTodoApp extends StatefulWidget {
  const MyTodoApp({Key? key}) : super(key: key);

  @override
  _MyTodoAppState createState() => _MyTodoAppState();
}

class _MyTodoAppState extends State<MyTodoApp> {
  Color mainColor = Colors.white;
  Color secondColor = Colors.white;
  Color firstColor = Colors.grey.shade700;
  Color btnColor = Colors.deepPurple.shade200;
  Color editorColor = Colors.deepPurple.shade400;

  TextEditingController inputController = TextEditingController();
  String newTaskTxt = "";

//db den alma to do ları
  getTasks() async {
    return await DBProvider.db.getAllTasks();
  }

  @override
  Widget build(BuildContext context) {
    // pubspec.yaml dosyasinda dependencyleri belirttim. sqflite fluttere portlanmis sqlite
    // path ise dosya yonetimi saglayan bir lib
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      Color bcColor = themeNotifier.isDark ? firstColor : secondColor;
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: bcColor,
          title: Text('Notlar',
          style: TextStyle(
            color: themeNotifier.isDark ? Colors.white : Colors.deepPurple
          )),
          actions: [
            Padding(
                padding: EdgeInsets.all(8.0),
                child: TextButton.icon(
                  icon: Icon(
                    Icons.delete,
                    color: Colors.deepPurple.shade200,
                  ),
                  onPressed: () {
                    DBProvider.db.clear();
                    setState(() {});
                  },
                  label:
                      Text('Tümünü Sil', style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(
                      shape: StadiumBorder(),
                      backgroundColor: Colors.deepPurple,
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
                                      color: Colors.deepPurple.shade100,
                                      child: InkWell(
                                          child: Row(children: [
                                        Container(
                                          margin: EdgeInsets.only(right: 12.0),
                                          padding: EdgeInsets.all(12.0),
                                          child: const Icon(Icons.check), // önceden içeride day alındığı için eklenen gün geliyordu
                                          decoration: BoxDecoration(
                                              color: Colors.deepPurple.shade100,
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
                  return Center(child: Text('- Not Yok -'));
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
                          hintStyle: TextStyle(
                            color:  Colors.black
                            ),
                          hintText: "Not yaz ..."),
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
                    label: Text('Ekle',
                        style: TextStyle(color: Colors.white)),
                    style: TextButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: btnColor,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
                  ),
                ]))
          ],
        ),
        backgroundColor: bcColor,
      );
    });
  }
}
