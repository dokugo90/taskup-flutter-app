import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'dart:convert';
import "package:http/http.dart" as http;

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({ Key? key }) : super(key: key);

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  DateTime selectedDate = DateTime.now();
  String taskName = "";
  String taskDescription = "";
  final Uri apiCall = Uri.parse("https://taskup-flutter-api.vercel.app/newTask");

  void handleNewTask() async {
    try {
      var req = await http.post(apiCall, body: {"name": taskName, "description": taskDescription, "due": '${selectedDate.month}/${selectedDate.day}/${selectedDate.year}'});
      if (req.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Created Task', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
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
      } else if (req.statusCode == 400) {
        ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Task already exists', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
                                   SnackBar(
                                     content: Text('Please Try Again', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
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
                                     content: Text('Please Try Again', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 217, 217, 1),
        title: Text("Create Task"),
        centerTitle: true,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back),
          ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Text("New Task", style: TextStyle(color: Color.fromRGBO(0, 217, 217, 1), fontSize: 20),),
                SizedBox(height: 20,),
                TextField(
                  onChanged:(String value) {
                    setState(() {
                      taskName = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(0, 217, 217, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 217, 217, 1),
                      )
                    ),
                    hintText: "Enter Task Name"
                  ),
                ),
                SizedBox(height: 30,),
                TextField(
                  onChanged: (String value) {
                    setState(() {
                      taskDescription = value;
                    });
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(0, 217, 217, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: Color.fromRGBO(0, 217, 217, 1),
                      )
                    ),
                    hintText: "Enter Task Description"
                  ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  width: 200,
                  child: RawMaterialButton(
                    fillColor: Color.fromRGBO(0, 217, 217, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    onPressed: () async {
                   final DateTime? dateTime = await showDatePicker(
                        context: context, initialDate: selectedDate, firstDate: DateTime.now(), lastDate: DateTime(2200)
                        );
                        if (dateTime != null) {
                          setState(() {
                            selectedDate = dateTime;
                          });
                        }
                     }, 
                    child: Text("Choose due date")
                    ),
                ),
                SizedBox(height: 30,),
                SizedBox(
                  width: 150,
                  child: RawMaterialButton(
                    fillColor: Color.fromRGBO(0, 217, 217, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    onPressed: handleNewTask,
                    child: Text("Create Task")
                    ),
                ),
              ],
            ),
            ),
        ),
      ),
    );
  }
}