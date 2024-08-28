import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Providers/db_provider.dart';
import 'package:py_quest/Resuable%20widgets/custom_btn.dart';
import 'package:py_quest/Resuable%20widgets/customfeild.dart';

class LessonPartScreen extends StatefulWidget {
  String lessonId;
  LessonPartScreen({super.key, required this.lessonId});

  @override
  State<LessonPartScreen> createState() => _LessonPartScreenState();
}

class _LessonPartScreenState extends State<LessonPartScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final exampleController = TextEditingController();
  final partNoController = TextEditingController();
  final lessonIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    lessonIdController.text = widget.lessonId;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Add Lesson Part',
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
                  controller1: titleController,
                  lable: "Title",
                  ispass: false),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  readOnly: false,
                  controller1: descriptionController,
                  lable: "Description",
                  ispass: false),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                readOnly: false,
                controller1: exampleController,
                lable: "Example",
                ispass: false,
                maxLines: 3,
              ),
              SizedBox(
                height: 20,
              ),
              CustomTextField(
                  readOnly: false,
                  controller1: partNoController,
                  lable: "Part No",
                  ispass: false),
              SizedBox(
                height: 40,
              ),
              CustomButton(
                  text: "Add Lesson Part",
                  ontap: () {
                    String id =
                        DateTime.now().millisecondsSinceEpoch.toString();
                    Provider.of<DbProvider>(context, listen: false)
                        .addLessonPart(
                            lessonIdController.text,
                            id,
                            titleController.text,
                            descriptionController.text,
                            exampleController.text,
                            int.parse(partNoController.text));
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
