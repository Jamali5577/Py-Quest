import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Providers/db_provider.dart';
import 'package:py_quest/Resuable%20widgets/alert_dialog.dart';
import 'package:py_quest/Resuable%20widgets/custom_btn.dart';

class AddLessonScreen extends StatefulWidget {
  AddLessonScreen({super.key, this.chapterId});
  String? chapterId;

  @override
  State<AddLessonScreen> createState() => _AddLessonScreenState();
}

class _AddLessonScreenState extends State<AddLessonScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final lessonNoController = TextEditingController();

  // final idcontroller = TextEditingController(text: 'lessonID2');
  // final firestore = FirebaseFirestore.instance
  //     .collection("/Courses/CourseID1/Chapters/ChapterID1/Lessons");
  final dbRef = FirebaseDatabase.instance.ref();

  // Future<void> addLesson(String courseId, String chapterId, String lessonId,
  //     String title, String description) async {
  //   await dbRef
  //       .child('courses/$courseId/chapters/$chapterId/lessons/$lessonId')
  //       .set({
  //     'chapterId': chapterId,
  //     'title': title,
  //     'description': description,
  //   });
  // }

  @override
  void initState() {
    super.initState();
    _fetchLessonCount();
  }

  Future<void> _fetchLessonCount() async {
    int count = await countLessonIndex();
    lessonNoController.text = 'Lesson: ' + (count + 1).toString();
  }

  Future<int> countLessonIndex() async {
    final dbRef = FirebaseDatabase.instance
        .ref('lessons')
        .orderByChild('chapterId')
        .equalTo(widget.chapterId);

    final snapshot = await dbRef.once();
    final count = snapshot.snapshot.children.length;

    return count;
  }

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<DbProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 33, 34),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Add Lessons',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: lessonNoController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'lesson',
                  labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
              readOnly: true,
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Title',
                  labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: descriptionController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Description',
                  labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              ontap: () {
                //String courseid = '1723456777290624';
                String chapterid = widget.chapterId.toString();
                String id = DateTime.now().microsecondsSinceEpoch.toString();
                dbProvider
                    .addLesson(chapterid, id, titleController.text,
                        descriptionController.text)
                    .then((val) {
                  UiHelper.CustomAlertBox(context, 'Lesson Added');
                  //Navigator.pop(context);
                });
              },
              text: 'Add Lesson',
              // ontap: () {
              //   firestore.doc(idcontroller.text).set({
              //     'title': titleController.text,
              //     'id': idcontroller.text,
              //     'chapterid': chapteridController.text,
              //     'description': descriptionController.text,
              //   }).then((val) {
              //     UiHelper.CustomAlertBox(context, 'Lesson Add');
              //   }).onError(
              //     (error, stackTrace) {
              //       UiHelper.CustomAlertBox(context, error.toString());
              //     },
              //   );
              //   titleController.clear();
              //   idcontroller.clear();
              //   chapteridController.clear();
              //   descriptionController.clear();
              // })
            )
          ],
        ),
      ),
    );
  }
}
