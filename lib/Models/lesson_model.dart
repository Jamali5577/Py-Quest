import 'package:cloud_firestore/cloud_firestore.dart';

class Lesson {
  String id;
  String chapterid;
  String title;
  String description;

  Lesson({
    required this.id,
    required this.chapterid,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'chapterid': chapterid,
      'title': title,
      'description': description,
    };
  }

  factory Lesson.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Lesson(
      id: document.id,
      chapterid: data['chapterid'],
      title: data['title'],
      description: data['description'],
    );
  }
}
