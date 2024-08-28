import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github-gist.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:py_quest/Resuable%20widgets/custom_btn.dart';
import 'package:py_quest/Screens/ExerciseScreens/exercise_screen.dart';
import 'package:py_quest/Screens/LessonsScreens/lesson_part_screen.dart';
import 'package:py_quest/Screens/QuizScreens/add_quiz_screen.dart';
import 'package:py_quest/Utils/device_info.dart';

class LessonExplainScreen extends StatefulWidget {
  final String id, name, lessonIndex;
  LessonExplainScreen(
      {super.key,
      required this.id,
      required this.name,
      required this.lessonIndex});

  @override
  State<LessonExplainScreen> createState() => _LessonExplainScreenState();
}

class _LessonExplainScreenState extends State<LessonExplainScreen> {
  @override
  void initState() {
    getLessonDescription(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dbRef = FirebaseDatabase.instance
        .ref('lessons')
        .orderByChild('lessonid')
        .equalTo(widget.id);

    final ref = FirebaseDatabase.instance
        .ref('lessonPart')
        .orderByChild('lessonid')
        .equalTo(widget.id);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 33, 34),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Chapter ${widget.name}',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            FutureBuilder<String>(
              future: getLessonDescription(widget.id),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '0',
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ); // Default to 0 if there's an error
                } else {
                  return Text(
                    snapshot.data!.toString(),
                    style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontSize: screenWidth / 25),
                  ); // Display the count number
                }
              },
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: ref,
                itemBuilder: (context, snapshot, animation, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      elevation: 3.0,
                      color: const Color.fromARGB(255, 25, 24, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.child('title').value.toString(),
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              snapshot.child('description').value.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Text(
                              'Example:',
                              style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.pink,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: HighlightView(
                              snapshot.child('example').value.toString(),
                              language: 'python',
                              theme: githubGistTheme,
                              padding: EdgeInsets.all(12),
                              textStyle: TextStyle(
                                //fontFamily: 'Consolas', // Monospace font
                                fontSize: 16,
                                //color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Center(
              child: CustomButton(
                text: "Quiz",
                ontap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExerciseScreen(
                                id: widget.id,
                              )));
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.red,
        activeForegroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.red,
            label: 'Quiz',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AddQuizScreen(lessonId: widget.id)));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            label: 'Lesson Part',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LessonPartScreen(lessonId: widget.id)));
            },
          ),
        ],
      ),
    );
  }

  Future<String> getLessonDescription(String lessonId) async {
    final DatabaseReference lessonsRef =
        FirebaseDatabase.instance.ref().child('lessons');

    final DatabaseEvent event =
        await lessonsRef.orderByChild('lessonid').equalTo(lessonId).once();
    final snapshot = event.snapshot;
    String dec = "";
    if (snapshot.value != null) {
      // Convert the snapshot value to a Map and return the count of entries
      await lessonsRef.child(lessonId).once().then((value) {
        // print(value.snapshot.child("description").value.toString());
        dec = value.snapshot.child("description").value.toString();
      });
      // Map<dynamic, dynamic> lessons = snapshot.value as Map<dynamic, dynamic>;
      // print("Lenght" + lessons.length.toString());
      // print(lessons.toString());
      // return lessons[chapterId]["description"];
      return dec;
    } else {
      return ""; // No lessons found
    }
  }
}
