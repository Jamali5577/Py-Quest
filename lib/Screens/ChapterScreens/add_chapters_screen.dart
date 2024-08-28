import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Providers/db_provider.dart';
import 'package:py_quest/Resuable%20widgets/alert_dialog.dart';
import 'package:py_quest/Resuable%20widgets/custom_btn.dart';

class AddChaptersScreen extends StatefulWidget {
  const AddChaptersScreen({super.key});

  @override
  State<AddChaptersScreen> createState() => _AddChaptersScreenState();
}

class _AddChaptersScreenState extends State<AddChaptersScreen> {
  final nameController = TextEditingController();
  final chapNoController = TextEditingController();
  final descriptionController = TextEditingController();

  final _databaseRef = FirebaseDatabase.instance.ref();

  // Future<void> addChapter(String courseid, String name, String chapterid,
  //     int chapNo, bool status) async {
  //   await _databaseRef.child('courses/$courseid/chapters/chapterId').set({
  //     'courseid': courseid,
  //     'name': name,
  //     'chapNo': chapNo,
  //     'chapterid': chapterid,
  //   }).then((val) {
  //     print('Successfully Added');
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<DbProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 33, 34),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Add Chapters',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: chapNoController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Chapter No',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Name',
                  labelStyle: TextStyle(color: Colors.white)),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              maxLines: 4,
              controller: descriptionController,
              decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Description',
                labelStyle: TextStyle(color: Colors.white),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 20,
            ),
            CustomButton(
              ontap: () {
                String courseid = '1723456777290624';
                String id = DateTime.now().microsecondsSinceEpoch.toString();

                dbProvider
                    .addChapter(
                        courseid,
                        id,
                        nameController.text,
                        int.parse(chapNoController.text),
                        descriptionController.text,
                        false)
                    .then((val) {
                  UiHelper.CustomAlertBox(context, 'Chapter Added');
                });
              },
              text: 'Add Chapter',
            )
          ],
        ),
      ),
    );
  }
}
