import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Providers/db_provider.dart';
import 'package:py_quest/Resuable%20widgets/custom_btn.dart';
import 'package:py_quest/Resuable%20widgets/customfeild.dart';

class AddQuizScreen extends StatefulWidget {
  String lessonId;
  AddQuizScreen({super.key, required this.lessonId});

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();
  final hintController = TextEditingController();
  final quizNoController = TextEditingController();
  final lessonIdController = TextEditingController();
  final option1Controller = TextEditingController();
  final option2Controller = TextEditingController();
  final option3Controller = TextEditingController();
  final option4Controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    lessonIdController.text = widget.lessonId;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Add Quiz',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      backgroundColor: Color.fromARGB(255, 37, 33, 34),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(
                  readOnly: true,
                  controller1: lessonIdController,
                  lable: "Lesson Id",
                  ispass: false),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  readOnly: false,
                  controller1: questionController,
                  lable: "Question",
                  ispass: false),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  readOnly: false,
                  controller1: answerController,
                  lable: "Answer",
                  ispass: false),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  readOnly: false,
                  controller1: option1Controller,
                  lable: "option 1",
                  ispass: false),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  readOnly: false,
                  controller1: option2Controller,
                  lable: "option 2",
                  ispass: false),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  readOnly: false,
                  controller1: option3Controller,
                  lable: "option 3",
                  ispass: false),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  readOnly: false,
                  controller1: option4Controller,
                  lable: "option 4",
                  ispass: false),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                readOnly: false,
                controller1: hintController,
                lable: "hint",
                ispass: false,
                maxLines: 3,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  readOnly: false,
                  controller1: quizNoController,
                  lable: "Quiz No",
                  ispass: false),
              SizedBox(
                height: 40,
              ),
              CustomButton(
                  text: "Add Quiz",
                  ontap: () {
                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    Provider.of<DbProvider>(context, listen: false).addQuiz(
                        lessonIdController.text,
                        id,
                        questionController.text,
                        answerController.text,
                        option1Controller.text,
                        option2Controller.text,
                        option3Controller.text,
                        option4Controller.text,
                        hintController.text,
                        int.parse(quizNoController.text));
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
