import 'package:http/http.dart' as http;
import 'package:quiz_app/models/question_model.dart';
import 'dart:convert';

class DBconnect{
  //firebase address and table name add to the end as json
  final url = Uri.parse('https://simplequizapp-2ec12-default-rtdb.firebaseio.com/questions.json');

  //this part is optional for add questions for app
  Future<void> addQuestion(Question question) async{
    http.post(url,body:json.encode({
      'title' : question.title,
      'options' : question.options
    }) );
  }

  //fetch the data from the database
  Future<List<Question>> fetchQuestions() async {
      return http.get(url).then((response){
        var data = json.decode(response.body) as Map<String,dynamic>;
        List<Question> newQuestions = [];
        data.forEach((key, value) {
          var newQuestion = Question(
            id: key,
            title: value['title'],
            options: Map.castFrom(value['options']),
          );
          //add to newQuestions
          newQuestions.add(newQuestion);
        });
        return newQuestions;
      });
  }
}