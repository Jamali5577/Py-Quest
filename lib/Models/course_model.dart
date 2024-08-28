import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  String id;
  String name;
  bool status;

  Course({
    required this.id,
    required this.name,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
    };
  }

  factory Course.fromSnapShot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return Course(
      id: document.id,
      name: data['name'],
      status: data['status'],
    );
  }
}
