import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Providers/db_provider.dart';
import 'package:py_quest/Resuable%20widgets/alert_dialog.dart';
import 'package:py_quest/Screens/LessonsScreens/add_lesson.dart';
import 'package:py_quest/Screens/LessonsScreens/lesson_explain_screen.dart';
import 'package:py_quest/Utils/device_info.dart';

class LessonScreen extends StatefulWidget {
  String id;
  String name;
  LessonScreen({super.key, required this.id, required this.name});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final ref = FirebaseDatabase.instance.ref('lessons');
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Future<String> getChapterDescription(String chapterId) async {
    final DatabaseReference lessonsRef =
        FirebaseDatabase.instance.ref().child('chapters');

    final DatabaseEvent event =
        await lessonsRef.orderByChild('chapid').equalTo(chapterId).once();
    final snapshot = event.snapshot;
    String dec = "";
    if (snapshot.value != null) {
      // Convert the snapshot value to a Map and return the count of entries
      await lessonsRef.child(chapterId).once().then((value) {
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

  @override
  void initState() {
    getChapterDescription(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dbRef = FirebaseDatabase.instance
        .ref('lessons')
        .orderByChild('chapterId')
        .equalTo(widget.id);
    // final _dbRef =
    //     FirebaseDatabase.instance.ref('chapters').orderByChild('chapId').once();
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 37, 33, 34),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.pink,
        foregroundColor: Colors.white,
        activeBackgroundColor: Colors.red,
        activeForegroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: Icon(Icons.edit),
            backgroundColor: Colors.red,
            label: 'Edit',
            onTap: () {
              print('First Option Pressed');
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            label: 'Add',
            onTap: () {
              String id = widget.id;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AddLessonScreen(
                            chapterId: id,
                          )));
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.delete),
            backgroundColor: Colors.blue,
            label: 'Delete',
            onTap: () {
              print('Third Option Pressed');
            },
          ),
        ],
      ),
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Introduction To Python',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth / 12,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<String>(
                    future: getChapterDescription(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text(
                          '...',
                          style: TextStyle(fontSize: 30, color: Colors.white),
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
                  // Text(
                  //     style: TextStyle(
                  //         fontSize: screenWidth / 25, color: Colors.white),
                  //     'Cookies are small files placed on your device that collect information when you use Khan Academy. Strictly necessary cookies are used to make our site work and are required. Other types of cookies are used to improve your experience, to analyze how Khan Academy is used, and to market our service. You can allow these other cookies by checking the boxes below. You can learn'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: FirebaseAnimatedList(
              defaultChild: Center(child: CircularProgressIndicator()),
              query: dbRef,
              itemBuilder: (context, snapshot, animation, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    color: Colors.pink,
                    child: SizedBox(
                      height: 100,
                      child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LessonExplainScreen(
                                          name: widget.name,
                                          id: snapshot
                                              .child('lessonid')
                                              .value
                                              .toString(),
                                          lessonIndex: (index + 1).toString(),
                                        )));
                          },
                          title: Text(
                            "Lesson " + (1 + index).toString(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth / 19,
                                fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(
                            snapshot.child('title').value.toString(),
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: screenWidth / 22,
                                fontWeight: FontWeight.w400),
                          ),
                          trailing: PopupMenuButton(
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 30,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                  value: 1,
                                  child: ListTile(
                                    onTap: () {
                                      String lessonid = snapshot
                                          .child('lessonid')
                                          .value
                                          .toString();
                                      Navigator.pop(context);
                                      showMyDialog(
                                          lessonid,
                                          snapshot
                                              .child('title')
                                              .value
                                              .toString(),
                                          snapshot
                                              .child('description')
                                              .value
                                              .toString());
                                    },
                                    leading: Icon(Icons.edit),
                                    title: Text(
                                      'Edit',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  )),
                              PopupMenuItem(
                                  value: 2,
                                  child: ListTile(
                                    onTap: () {
                                      Provider.of<DbProvider>(context,
                                              listen: false)
                                          .deleteLesson(snapshot
                                              .child('lessonid')
                                              .value
                                              .toString());
                                      Navigator.pop(context);
                                    },
                                    leading: Icon(Icons.delete),
                                    title: Text(
                                      'delete',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  )),
                            ],
                          )),
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialog(
    String id,
    String title,
    String description,
  ) async {
    titleController.text = title;
    descriptionController.text = description;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Update Lesson')),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () async {
                  // ref.child(id).update(
                  //     {'title': title, 'description': description}).then((val) {
                  //   print('Data Added');
                  // }).onError(
                  //   (error, stackTrace) {
                  //     print(error.toString());
                  //   },
                  // );
                  // updateLesson(title, description);

                  await Provider.of<DbProvider>(context, listen: false)
                      .updateLesson(
                          id, titleController.text, descriptionController.text);
                  print(id);
                  Navigator.pop(context);
                },
                child: Text('Update'))
          ],
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Title'),
                ),
                SizedBox(
                  height: 4,
                ),
                TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(hintText: 'Description'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> updateLesson(String title, String description) async {
    final ref = FirebaseDatabase.instance.ref('lessons');
    String lessonId = "1723723837802919";
    await ref.child(lessonId).update({
      'title': title,
      'description': description,
    }).then((value) {
      // print();
      print(lessonId + title + description);
      print('Data Updated Successfully');
    }).onError((er, StackTrace) {
      print(er.toString());
    });
  }
}
