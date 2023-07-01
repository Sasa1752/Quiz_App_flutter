import 'package:flutter/material.dart';
import 'package:quiz_app/models/db_connect.dart';
import 'package:quiz_app/models/question_model.dart';  //question model
import 'package:quiz_app/widgets/next_button.dart';
import 'package:quiz_app/widgets/option_card.dart';
import 'package:quiz_app/widgets/question_widget.dart';  //question widget
import 'package:quiz_app/widgets/result_box.dart';
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
  //create an object for db connection
  var db = DBconnect();

  late Future _questions;
  Future<List<Question>> getData() async{
    return db.fetchQuestions();
  }

  @override
  void initState(){
    _questions = getData();
    super.initState();
  }

  // List<Question>_questions = [
  //   Question(
  //     id: '10',
  //     title: 'What is 2 +2 ?',
  //     options: {'5':false,'30':false,'4':true,'10':false},
  //   ),
  //   Question(id: '11',
  //     title: 'What is 10 + 20 ?',
  //     options: {'40':false,'30':true,'20':false,'60':false},
  //   ),
  // ];

  //create an index to loop trough question
  int index = 0;
  //Score variable
  int score = 0;
  //create bool value to check if user click options
  bool isPressed = false;
  bool isAlreadySelected = false;

  //function to display next question
  void nextQuestion(int questionlength) {
    if(index == questionlength -1){
      //when all questions are end
      showDialog(
          context: context,
          barrierDismissible: true,  //this will disable the dismiss function on clicking outside of box
          builder: (ctx) => ResultBox(
            result: score, //total points user get
            questionLength: questionlength,  //out of how many questions
            onPressed: startOver,
      ));
    }else{
      if(isPressed) {
        setState(() {
          index ++; //when the index will change to 1
          isPressed = false;
          isAlreadySelected = false;
        });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select any option'),
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.symmetric(vertical: 20.0),
          )
        );
      }
    }

  }
  //function to change color of options after pressed
  void checkAnswerAndUpdate(bool value) {
    if(isAlreadySelected){
      return;
    }else{
      if (value == true) {
        score ++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }

  }
  //function to start over
  void startOver(){
    setState(() {
      index = 0;
      score =0;
      isPressed =false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }
  @override
  Widget build(BuildContext context) {
    //use the future builder widget

    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx,snapshot){
        if(snapshot.connectionState == ConnectionState.done){
          if(snapshot.hasError){
            return Center(
              child: Text('${snapshot.error}'),
            );
          }else if(snapshot.hasData){
             var extractedData = snapshot.data as List<Question>;
             return   Scaffold(
               backgroundColor: background,
               appBar: AppBar(
                 title: const Text("Quiz App"),
                 backgroundColor: background,
                 shadowColor: Colors.transparent,
                 actions: [
                   Padding(
                     padding: const EdgeInsets.all(18.0),
                     child: Text('Score : $score',
                       style: const TextStyle(fontSize: 18.0,),
                     ),
                   ),
                 ],
               ),
               body: Container(
                 width: double.infinity,
                 padding: const EdgeInsets.symmetric(horizontal: 10.0),
                 child: Column(
                   children:[
                     //add the question widget
                     QuestionWidget(
                       indexAction:index, //currently at 0
                       question: extractedData[index].title, //means first question in the list
                       totalQuestions:extractedData.length,
                     ),
                     const Divider(color:neutral,),
                     //add some space
                     const SizedBox(height: 25.0,),
                     //display options of question
                     for(int i=0;i<extractedData[index].options.length;i++)
                       GestureDetector(
                         onTap : () => checkAnswerAndUpdate(
                             extractedData[index].options.values.toList()[i]),
                         child: OptionCard(
                           option: extractedData[index].options.keys.toList()[i],
                           //we need to check if the answer is correct or not
                           //we need this value
                           color: isPressed
                               ? extractedData[index].options.values.toList()[i]== true ? correct:incorrect
                               : neutral,

                         ),
                       ),
                   ],
                 ),

               ),

               //use floating action button for next question
               floatingActionButton: GestureDetector(
                 onTap: () => nextQuestion(extractedData.length),
                 child: const Padding(
                   padding: EdgeInsets.symmetric(horizontal: 10.0) ,
                   child: NextButton(
                    //above function
                   ),
                 ),
               ),
               floatingActionButtonLocation:FloatingActionButtonLocation.centerFloat ,
             );
          }
        }else{
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20.0),
                Text(
                    'Please wait while questions are loading..',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        decoration: TextDecoration.none,
                        fontSize:14.0
                    ),
                ),
              ],
            ),
          );
        }
        
        return const Center(
          child: Text('No Data'),
        );
      },

    );
  }
}
