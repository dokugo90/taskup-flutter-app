import 'package:flutter/material.dart';
import 'package:taskupflutter/pages/createTask.dart';
import 'package:taskupflutter/pages/task.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import "package:http/http.dart" as http;


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks',
      home: const MyHomePage(title: 'Tasks'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool ?_isSelected;
  List tasks = <dynamic>[];
  final String apiCall = "https://taskup-flutter-api.vercel.app/";

  void getTasks() async {
    try {
      var req = await http.get(Uri.parse('${apiCall}tasks'));
    var res = jsonDecode(req.body);

    setState(() {
      tasks = res;
    });

    if (req.statusCode == 200) {
    
    }
    } catch (err) {

    }

  }

   void completeTask(String task) async {
    try {
      var res = await http.post(Uri.parse('${apiCall}complete'), body: {"name": task});

      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Completed Task', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                      backgroundColor: Color.fromRGBO(0, 217, 217, 1),
                                      duration: Duration(seconds: 5),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      )),
                                      dismissDirection: DismissDirection.startToEnd,
                                    ),
                                          );
                                getTasks();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Try again', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 5),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      )),
                                      dismissDirection: DismissDirection.startToEnd,
                                    ),
                                          );
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Please try again', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                      backgroundColor: Color.fromRGBO(0, 217, 217, 1),
                                      duration: Duration(seconds: 5),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      )),
                                      dismissDirection: DismissDirection.startToEnd,
                                    ),
                                          );
    }
  }

  void deleteTask(String task) async {
    try {
      var res = await http.post(Uri.parse('${apiCall}delete'), body: { "name": task });
      if (res.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Deleted Task', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                      backgroundColor: Color.fromRGBO(0, 217, 217, 1),
                                      duration: Duration(seconds: 5),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      )),
                                      dismissDirection: DismissDirection.startToEnd,
                                    ),
                                          );
                                          getTasks();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Try Again', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 5),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      )),
                                      dismissDirection: DismissDirection.startToEnd,
                                    ),
                                          );
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Try Again', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
                                      backgroundColor: Colors.red,
                                      duration: Duration(seconds: 5),
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      )),
                                      dismissDirection: DismissDirection.startToEnd,
                                    ),
                                          );
    }
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 217, 217, 1),
        title: Text("TaskUp (${tasks.length} tasks)"),
        centerTitle: true,
        leading: InkWell(child: Icon(Icons.refresh), onTap: getTasks,),
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.all(8.0), 
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder:(context, index) {
                return Column(
                  children: [
                    SizedBox(height: 20,),
                    Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        deleteTask(tasks[index]["taskName"].toString());
                      },
                      background: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(25),
      color: Colors.red,
      ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(Icons.delete, color: Colors.white,),
        SizedBox(width: 20),
      ],
    ),
  ),
                      child: IntrinsicHeight(
                        child: ListTile(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder:(context) => TaskPage(taskName: tasks[index]["taskName"].toString(), 
                          dueDate: tasks[index]["dueDate"].toString(), 
                          taskDescription: tasks[index]["taskDescription"].toString(), 
                          taskCreated: tasks[index]["created"].toString(), 
                          completed: tasks[index]["completed"],),));
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)
                        ),
                        tileColor: Color.fromRGBO(0, 217, 217, 1),
                        selectedColor: Color.fromRGBO(0, 217, 217, 1),
                                        trailing: Text(tasks[index]["dueDate"].toString()),
                                        title: Text(tasks[index]["taskName"].toString(), style: TextStyle(decoration: tasks[index]["completed"] ? TextDecoration.lineThrough : TextDecoration.none),),
                                        leading: tasks[index]["completed"] ? 
                                        InkWell(
                        onTap: () {
                          
                        },
                        child: Icon(Icons.check_box),
                        )
                        : InkWell(
                        onTap: () {
                          completeTask(tasks[index]["taskName"].toString());
                        },
                        child: Icon(Icons.cancel),
                        )
                                      ),
                      ),
                    ),
                  ],
                );
                
              },),)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTaskPage()));
        },
        tooltip: 'New Task',
        child: const Icon(Icons.add),
        backgroundColor: Color.fromRGBO(0, 217, 217, 1),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
