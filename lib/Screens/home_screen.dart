import 'package:flutter/material.dart';
import 'package:quiz_app/models/question_model.dart';  //question model
import 'package:quiz_app/widgets/next_button.dart';
import 'package:quiz_app/widgets/question_widget.dart';  //question widget
import '../constants.dart';

//create HomeScreen widget
//use stateful widget this is our parent page then we store all variables in
// this page therefore there are many states
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Question>_questions = [
    Question(
      id: '10',
      title: 'What is 2 +2 ?', 
      options: {'5':false,'30':false,'4':true,'10':false},
    ),
    Question(id: '11',
      title: 'What is 10 + 20 ?',
      options: {'40':false,'30':true,'20':false,'60':false},
    ),
  ];

  //create an index to loop trough question
  int index = 0;

  //function to display next question
  void nextQuestion(){
    if(index == _questions.length -1){
      return;
    }else{
      setState(() {
        index ++; //when the index will change to 1
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        title: const Text("Quiz App"),
        backgroundColor: background,
        shadowColor: Colors.transparent,
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children:[
            //add the question widget
           QuestionWidget(
             indexAction:index, //currently at 0
             question: _questions[index].title, //means first question in the list
             totalQuestions:_questions.length,
           ),
            const Divider(color:neutral,),
          ],
        ),

      ),

      //use floating action button for next question
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0) ,
        child: NextButton(
          nextQuestion: nextQuestion, //above function
        ),
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat ,
    );
  }
}
