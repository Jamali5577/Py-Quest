import 'package:another_stepper/dto/stepper_data.dart';
import 'package:another_stepper/widgets/another_stepper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Providers/scrore_provider.dart';
import 'package:py_quest/Screens/ExerciseScreens/question4Screen.dart';

import 'package:py_quest/Utils/device_info.dart';

class Question3Screen extends StatefulWidget {
  String id;
  int num;
  Question3Screen({super.key, required this.id, required this.num});

  @override
  State<Question3Screen> createState() => _Question3ScreenState();
}

class _Question3ScreenState extends State<Question3Screen> {
  int points = 0;
  String? answer;
  String? selectedOption;
  String? lessonId;
  bool isCorrect = false;

  List<StepperData> stepperData = [
    StepperData(
        title: StepperText(
          "Question 1",
          textStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
        iconWidget: Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(30))),
          //child: Icon(Icons.looks_two, color: Colors.white),
        )),
    StepperData(
      title: StepperText(
        "Question 2",
        textStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
    ),
    StepperData(
      title: StepperText(
        "Question 3",
        textStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
    ),
    StepperData(
      title: StepperText("Question 4",
          textStyle: const TextStyle(color: Colors.grey)),
      iconWidget: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.all(Radius.circular(30))),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    lessonId = widget.id;

    final ref = FirebaseDatabase.instance
        .ref('quiz')
        .orderByChild('lessonid')
        .equalTo(widget.id);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 33, 34),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Quiz',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
        child: Column(
          children: [
            SizedBox(height: 20),
            AnotherStepper(
              stepperList: stepperData,
              stepperDirection: Axis.horizontal,
              iconWidth: 40,
              iconHeight: 40,
              activeBarColor: Colors.green,
              inActiveBarColor: Colors.grey,
              inverted: true,
              verticalGap: 30,
              activeIndex: 2,
              barThickness: 5,
            ),
            SizedBox(height: 20),
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  if (index == 2) {
                    answer = snapshot.child("answer").value.toString();
                    return Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 0, 0),
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Q:${snapshot.child("quizNO").value.toString()} " +
                                  snapshot.child('question').value.toString(),
                              style: TextStyle(
                                  fontSize: screenWidth / 18,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white),
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                _buildRadioOption(
                                  snapshot.child('option1').value.toString(),
                                  "(1)",
                                ),
                                SizedBox(height: 5),
                                _buildRadioOption(
                                  snapshot.child('option2').value.toString(),
                                  "(2)",
                                ),
                                SizedBox(height: 5),
                                _buildRadioOption(
                                  snapshot.child('option3').value.toString(),
                                  "(3)",
                                ),
                                SizedBox(height: 5),
                                _buildRadioOption(
                                  snapshot.child('option4').value.toString(),
                                  "(4)",
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      size: screenWidth / 12,
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    )),
                                IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Question4Screen(
                                                      id: lessonId
                                                          .toString())));
                                    },
                                    icon: Icon(
                                      size: screenWidth / 12,
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  } else
                    return Center();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioOption(String option, String label) {
    return Card(
      color: (option == answer && option == selectedOption)
          ? Colors.green
          : (option != answer && option == selectedOption)
              ? Colors.red
              : Colors.grey,
      //color: answer == selectedOption ? Colors.green : Colors.red,
      //color: Colors.blueGrey,
      child: RadioListTile<String>(
        value: option,
        groupValue: selectedOption,
        activeColor: option == selectedOption ? Colors.green : Colors.red,
        onChanged: selectedOption == null
            ? (value) async {
                setState(() {
                  selectedOption = value;
                });
                await Future.delayed(Duration(seconds: 1));
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             Question2Screen(id: lessonId.toString(), num: 2)));
                _checkAnswer(value!, answer!, context);
              }
            : null,
        title: Text(
          option,
          style: TextStyle(fontSize: screenWidth / 25, color: Colors.white),
        ),
        secondary: Text(
          label,
          style: TextStyle(fontSize: screenWidth / 25, color: Colors.white),
        ),
      ),
    );
  }

  void _checkAnswer(
      String selectedAns, String correctAnswer, BuildContext context) {
    bool isCorrect = false;
    if (selectedAns == correctAnswer) {
      isCorrect = true;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Correct!',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ));
    } else {
      isCorrect = false;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Wrong Answer!',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: Colors.deepOrange,
      ));
    }

    if (isCorrect) {
      Provider.of<ScroreProvider>(context, listen: false).addPoints();
    }
  }

  // void ansIsCorrect() {
  //   if (option == answer && option == selectedOption) {
  //     isTure;
  //   } else if (option != null && option == selectedOption) {
  //     isFalse;
  //   }
  // }
}
