import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  String taskName;
  String dueDate;
  String taskDescription;
  String taskCreated;
  bool completed;
  TaskPage({ Key? key, required this.taskName, required this.dueDate, required this.taskDescription, required this.taskCreated, required this.completed }) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.taskName),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(0, 217, 217, 1),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Task Info", style: TextStyle(color: Color.fromRGBO(0, 217, 217, 1), fontSize: 20),),
              SizedBox(height: 30,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 250,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(0, 217, 217, 1),
                  borderRadius: BorderRadius.circular(25)
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Task Created: ${widget.taskCreated}", style: TextStyle(color: Colors.white, fontSize: 20),),
                      SizedBox(height: 30,),
                      Text("Task Description: ${widget.taskDescription}", style: TextStyle(color: Colors.white, fontSize: 15)),
                      SizedBox(height: 30,),
                      Text("Task Due: ${widget.dueDate}", style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(height: 30,),
                      Text(widget.completed ? "Completed" : "Not Completed", style: TextStyle(color: Colors.white, fontSize: 20))
                    ],
                  ),
                ),
      ),
            ],
          ),
        ),),
    );
  }
}