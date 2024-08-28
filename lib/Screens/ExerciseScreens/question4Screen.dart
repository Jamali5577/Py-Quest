import 'package:another_stepper/another_stepper.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Models/user_details.dart';
import 'package:py_quest/Providers/db_provider.dart';
import 'package:py_quest/Providers/scrore_provider.dart';
import 'package:py_quest/Resuable%20widgets/custom_btn.dart';
import 'package:py_quest/Resuable%20widgets/custom_iconbtn.dart';
import 'package:py_quest/Utils/device_info.dart';

class Question4Screen extends StatefulWidget {
  String id;
  Question4Screen({super.key, required this.id});

  @override
  State<Question4Screen> createState() => _Question4ScreenState();
}

class _Question4ScreenState extends State<Question4Screen> {
  int points = 0;
  String? answer;
  String? selectedOption;
  String? lessonId;
  String? userId;
  int score = 0;

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
          //child: const Icon(Icons.looks_two, color: Colors.white),
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

    Provider.of<UserDetails>(context, listen: false).getUsersDetailsFromPref();
    score = Provider.of<ScroreProvider>(context, listen: false).score;
    //points = 5;
    //int score = 0;
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
              activeIndex: 3,
              barThickness: 5,
            ),
            SizedBox(height: 20),
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  if (index == 0) {
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
                                CustomIconbtn(
                                    ontap: () {
                                      Navigator.pop(context);
                                    },
                                    icon: Icon(
                                      Icons.arrow_back,
                                      size: screenWidth / 12,
                                    ),
                                    color: Colors.white),
                                CustomIconbtn(
                                    ontap: () {},
                                    icon: Icon(
                                      Icons.arrow_forward,
                                      size: screenWidth / 12,
                                    ),
                                    color: Colors.white)
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
            Consumer<UserDetails>(
              builder: (context, value, child) {
                return CustomButton(
                    text: "Submit",
                    ontap: () {
                      //fetchScore();

                      userId = value.userId;
                      getUserPoints(userId.toString());
                      int total = points + score;
                      Provider.of<DbProvider>(context, listen: false)
                          .updateUserPoints(userId.toString(), total);

                      //print(value.userId);
                    });
              },
            ),
            SizedBox(
              height: 20,
            )
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
      points += 5;
    }
  }

  Future<void> getUserPoints(String userid) async {
    DatabaseReference dbRef = FirebaseDatabase.instance.ref();
    final snapshot = await dbRef.child('Users/$userid').get();
    if (snapshot.exists) {
      int userPoints = snapshot.child('point').value as int;
      points = userPoints;
    } else {
      print('No data available for user $userid');
    }
  }
}
