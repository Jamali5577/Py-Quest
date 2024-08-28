import 'package:cloud_firestore/cloud_firestore.dart';

class Chapter {
  String id;
  String courseid;
  String name;
  int chapNo;
  bool status;

  Chapter({
    required this.id,
    required this.courseid,
    required this.name,
    required this.chapNo,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseid': courseid,
      'name': name,
      'chapNo': chapNo,
      'status': status,
    };
  }

  factory Chapter.fromSnapShot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Chapter(
      id: document.id,
      courseid: data['courseid'],
      name: data['name'],
      chapNo: data['chapNo'],
      status: data['status'],
    );
  }
}
