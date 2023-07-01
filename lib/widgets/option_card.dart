import 'package:flutter/material.dart';
import '../constants.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({Key? key,required this.option,required this.color}) : super(key: key);
  final String option;
  final Color color;
  @override
  Widget build(BuildContext context) {
    //GestureDetector used to create clickable button
    return Card(
        color: color,
        child: ListTile(
          title: Text(
            option,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
              //we will decide if the color we are recieving here.
              //what ratio of the red and green color are in it
              color: color.red != color.green ? neutral : Colors.black ,
            ),
          ),
        ),
    );
  }
}
