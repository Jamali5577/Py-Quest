import 'package:cloud_firestore/cloud_firestore.dart';

class Exercise {
  String id;
  String lessonid;
  int taskno;
  String taskquestion;
  String taskans;
  String taskhint;
  String correctans;

  Exercise({
    required this.id,
    required this.lessonid,
    required this.taskno,
    required this.taskquestion,
    required this.taskans,
    required this.taskhint,
    required this.correctans,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lessonid': lessonid,
      'taskno': taskno,
      'taskquestion': taskquestion,
      'taskans': taskans,
      'taskhint': taskhint,
      'correctans': correctans,
    };
  }

  factory Exercise.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Exercise(
      id: document.id,
      lessonid: data['lessonid'],
      taskno: data['taskno'],
      taskquestion: data['taskquestion'],
      taskans: data['taskans'],
      taskhint: data['taskhint'],
      correctans: data['correctans'],
    );
  }
}
