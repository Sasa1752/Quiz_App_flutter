import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';


class ResultBox extends StatelessWidget {
  const ResultBox({Key ? key,required this.result,required this.questionLength,required this.onPressed}) : super(key: key);
  final int result;
  final int questionLength;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: background,
      content: Padding(
        padding: const EdgeInsets.all(70.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Result',
              style: TextStyle(
                  color: neutral,
                 fontSize: 22.0,
              ),
            ),
            const SizedBox(height: 20.0,),
            CircleAvatar(
              child: Text('$result/$questionLength',
                style: TextStyle(
                  fontSize: 30.0,
                ),
              ),
              radius: 70.0,
              backgroundColor: result == questionLength/2
                  ? Colors.yellow   //when the result is half of questions
                  : result < questionLength/2
                      ?incorrect  //when result is less than half
                      :correct,   //when result is above than half
            ),
            const SizedBox(height: 20.0,),
            Text(
              result == questionLength/2
                  ? 'Almost There'   //when the result is half of questions
                  : result < questionLength/2
                  ?'Try Again ?'  //when result is less than half
                  :'Great!', //when result is above than half
                  style: const TextStyle(
                    color: neutral,
                  ),
            ),
            const SizedBox(height: 25.0),
            GestureDetector(
              onTap: onPressed,
              child: const Text('Start Over',
               style: TextStyle(
                 color: Colors.blue,
                 fontSize: 20.0,
                 letterSpacing: 1.0,
               ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
