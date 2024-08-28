import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:py_quest/Models/user_details.dart';
import 'package:py_quest/Providers/db_provider.dart';
import 'package:py_quest/Screens/ChapterScreens/add_chapters_screen.dart';
import 'package:py_quest/Screens/LessonsScreens/lesson_screen.dart';
import 'package:py_quest/Utils/device_info.dart';

class ChaptersScreen extends StatefulWidget {
  ChaptersScreen({super.key, this.name});
  String? name;
  @override
  State<ChaptersScreen> createState() => _ChaptersScreenState();
}

class _ChaptersScreenState extends State<ChaptersScreen> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final _dbRef = FirebaseDatabase.instance.ref('chapters');

  //here we make a function which return the number of lessons
  Future<int> getLessonCountForChapter(String chapterId) async {
    final DatabaseReference lessonsRef =
        FirebaseDatabase.instance.ref().child('lessons');

    final DatabaseEvent event =
        await lessonsRef.orderByChild('chapterId').equalTo(chapterId).once();
    final snapshot = event.snapshot;

    if (snapshot.value != null) {
      // Convert the snapshot value to a Map and return the count of entries
      Map<dynamic, dynamic> lessons = snapshot.value as Map<dynamic, dynamic>;
      // print("Lenght" + lessons.length.toString());
      return lessons.length;
    } else {
      return 0; // No lessons found
    }
  }

  // void getLessonCount(String chapterId) async {
  //   // final dbRef = await FirebaseDatabase.instance
  //   //     .ref('lessons')
  //   //     .orderByChild('chapterId')
  //   //     .equalTo(chapterId);
  //   // dbRef.get().then((value) {
  //   //   print("Lessons value" + value.toString());
  //   // });
  //   final dbref = FirebaseDatabase.instance.ref('Lessons');
  //   dbref.orderByChild(chapterId).once().then((value) {
  //     print(object)
  //       //for(var v in value.snapshot)
  //   });
  // }

  @override
  void initState() {
    getLessonCountForChapter("1723720618489510");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final dbProvider = Provider.of<DbProvider>(context, listen: false);
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
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddChaptersScreen()));
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
          'Courses',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w700, color: Colors.white),
        ),
        backgroundColor: Colors.pink,
      ),
      body: Column(
        children: [
          //header
          Container(
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 10, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Learn",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth * 0.09,
                            fontWeight: FontWeight.w600),
                      ),
                      // SizedBox(
                      //   height: screenHeight * 0.00,
                      // ),
                      Text(
                        widget.name!,
                        style: TextStyle(
                            color: Colors.pink,
                            fontSize: screenWidth * 0.11,
                            fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                ),
                //here we now show the progress indicator
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.white,
                      color: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.pink),
                      value: 0.5,
                      strokeWidth: 10,
                      semanticsLabel: "progress",

                      //semanticsValue: ,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: FirebaseAnimatedList(
            defaultChild: Center(child: CircularProgressIndicator()),
            query: _dbRef,
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
                                builder: (context) => LessonScreen(
                                      id: snapshot
                                          .child('chapid')
                                          .value
                                          .toString(),
                                      name: snapshot
                                          .child('chapNo')
                                          .value
                                          .toString(),
                                    )));
                      },
                      title: Text(
                        "Chapter " + snapshot.child('chapNo').value.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: screenWidth / 19,
                            fontWeight: FontWeight.w500),
                      ),
                      trailing: PopupMenuButton(
                        icon: Column(
                          children: [
                            Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                        itemBuilder: (context) => [
                          PopupMenuItem(
                              value: 1,
                              child: ListTile(
                                onTap: () {
                                  String id =
                                      snapshot.child('chapid').value.toString();
                                  Navigator.pop(context);

                                  showMyDialog(
                                      id,
                                      snapshot.child('name').value.toString(),
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
                                  Navigator.pop(context);
                                  Provider.of<DbProvider>(context,
                                          listen: false)
                                      .deleteChapter(snapshot
                                          .child('chapid')
                                          .value
                                          .toString());
                                },
                                leading: Icon(Icons.delete),
                                title: Text(
                                  'delete',
                                  style: TextStyle(fontSize: 18),
                                ),
                              )),
                        ],
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            snapshot.child('name').value.toString(),
                            style: TextStyle(
                                color: Colors.white70,
                                fontSize: screenWidth / 22,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Lessons',
                                    style: TextStyle(
                                        color: Colors.white70,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Consumer<DbProvider>(
                                    builder: (context, value, child) =>
                                        FutureBuilder<int>(
                                      future: getLessonCountForChapter(snapshot
                                          .child("chapid")
                                          .value
                                          .toString()),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text('...');
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              '0'); // Default to 0 if there's an error
                                        } else {
                                          return Text(
                                            snapshot.data.toString(),
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w600,
                                                fontSize: screenWidth / 25),
                                          ); // Display the count number
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              Consumer<DbProvider>(
                                builder: (context, value, child) => Row(
                                  children: [
                                    Text(
                                      'Skills',
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    FutureBuilder<int>(
                                      future: getLessonCountForChapter(snapshot
                                          .child("chapid")
                                          .value
                                          .toString()),
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Text('...');
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              '0'); // Default to 0 if there's an error
                                        } else {
                                          return Text(
                                            snapshot.data.toString(),
                                            style: TextStyle(
                                                color: Colors.white70,
                                                fontWeight: FontWeight.w600,
                                                fontSize: screenWidth / 25),
                                          ); // Display the count number
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ))
        ],
      ),
    );
  }

  Future<void> showMyDialog(
    String id,
    String name,
    String description,
  ) async {
    nameController.text = name;
    descriptionController.text = description;
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(child: Text('Update Chapter')),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel')),
            TextButton(
                onPressed: () async {
                  await Provider.of<DbProvider>(context, listen: false)
                      .updateChapter(
                          id, nameController.text, descriptionController.text);

                  // await Provider.of<DbProvider>(context, listen: false)
                  //     .updateLesson(
                  //         id, titleController.text, descriptionController.text);
                  // print(id);
                  Navigator.pop(context);
                },
                child: Text('Update'))
          ],
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(hintText: 'Chapter Name'),
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
}
