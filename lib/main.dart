import 'package:flutter/material.dart';
import 'package:quiz_app/models/db_connect.dart';
import 'package:quiz_app/models/question_model.dart';
import './Screens/home_screen.dart';   //file we created.

//run the main method
void main(){
  //create db connection and add question
  var db = DBconnect();
  // db.addQuestion(Question(id:'20',title:'What is 20 x 100 ?',options:{
  //   '100':false,
  //   '200':true,
  //   '300':false,
  //   '400':false,
  // }));

  db.fetchQuestions();
  //the runApp method
  runApp(
      const MyApp(),  //will create this below
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
