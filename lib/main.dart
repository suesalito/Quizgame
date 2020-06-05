import 'package:flutter/material.dart';
import 'package:quizzler/questionbank.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scoreKeeper = [];

  List<String> questions = [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.'
  ];

  List<bool> answers = [false, true, true];
  List<bool> useranswer = [];

  int questionNumber = 0;
  int scoreTotal = 0;

  QuestionBank questionBank = QuestionBank();

  void checkAnswer(bool userPicked) {
    setState(() {
      print(questionBank.getQuestionNumber());

      bool correctAnswer = questionBank.getQuestionsAnswer();

      if (correctAnswer == userPicked) {
        scoreTotal++;
        print('user got it right.');
        print(scoreTotal);

        scoreKeeper.add(Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        print('user got it wrong.');
        scoreKeeper.add(Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      if (questionBank.isfinished() == true) {
        Alert(context: context, title: "Finished", desc: "You have finished the Quiz. \n Your score is $scoreTotal .")
            .show();
        questionBank.resetQuestionNumber();
        scoreKeeper = [];
        scoreTotal = 0;
      } else {
        questionBank.nextQuestion();
      }
    });
  }

  // static Question q1 = Question(q: 'You can lead a cow down stairs but not up stairs.', a: false);
  // static Question q2 = Question(q: 'Approximately one quarter of human bones are in the feet.', a: true);
  // static Question q3 = Question(q: 'A slug\'s blood is green.', a: true);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questionBank.getQuestionsText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //print(questionBank.getQuestionNumber());
                checkAnswer(true);
                //The user picked true.
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //print(questionBank.getQuestionNumber());
                checkAnswer(false);

                //The user picked false.
              },
            ),
          ),
        ),
        //TODO: Add a Row here as your score keeper
        Expanded(
          child: Row(
            children: scoreKeeper,
          ),
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
