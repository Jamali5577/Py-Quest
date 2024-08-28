import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class DbProvider extends ChangeNotifier {
  final DatabaseReference dbRef = FirebaseDatabase.instance.ref();

  Future<void> addUser(
      String userid, String name, String email, String password) async {
    await dbRef.child('Users/$userid').set({
      'userId': userid,
      'name': name,
      'email': email,
      'password': password,
      'picture': '',
      'role': 2,
      'point': 6,
      'status': 0
    });
    notifyListeners();
  }

  Future<void> addCourse(String courseId, String name, bool status) async {
    await dbRef.child('courses/$courseId').set({
      'name': name,
      'status': status,
    });
    notifyListeners();
  }

  Future<void> addChapter(String courseId, String chapterId, String name,
      int chapNo, String description, bool status) async {
    await dbRef.child('chapters/$chapterId').set({
      'courseId': courseId,
      'chapid': chapterId,
      'name': name,
      'chapNo': chapNo,
      'description': description,
      'status': status,
    });
    notifyListeners();
  }

  Future<void> updateChapter(
      String chapterId, String name, String description) async {
    final ref = FirebaseDatabase.instance.ref('chapters');
    await ref.child(chapterId).update({
      'name': name.toString(),
      'description': description.toString(),
    }).then((value) {
      print("db_provider " + chapterId);
      // print();
      print(chapterId + name + description);
      print('Data Updated Successfully');
    }).onError((er, StackTrace) {
      print(er.toString());
    });
    notifyListeners();
  }

  Future<void> deleteChapter(String chapterId) async {
    final ref = FirebaseDatabase.instance.ref('chapters');
    await ref.child(chapterId).remove().then((val) {
      print("Chapter Deleted Successfully");
    }).onError(
      (error, stackTrace) {
        print(error.toString());
      },
    );
  }

  Future<void> addLesson(String chapterId, String lessonId, String title,
      String description) async {
    await dbRef.child('lessons/$lessonId').set({
      'chapterId': chapterId,
      'lessonid': lessonId,
      'title': title,
      'description': description,
    });
    notifyListeners();
  }

  Future<void> addExercise(
      String chapterId,
      String lessonId,
      String exerciseId,
      int taskNo,
      String taskQuestion,
      String taskAns,
      String taskHint,
      String correctAns) async {
    await dbRef.child('exercises/$exerciseId').set({
      'lessonId': lessonId,
      'chapid': chapterId,
      'exerciseid': exerciseId,
      'taskNo': taskNo,
      'taskQuestion': taskQuestion,
      'taskAns': taskAns,
      'taskHint': taskHint,
      'correctAns': correctAns,
    });
    notifyListeners();
  }

  Future<void> addLessonPart(String lessonId, String lessonPartId, String title,
      String description, example, int partNo) async {
    await dbRef.child('lessonPart/$lessonPartId').set({
      'lessonPartId': lessonPartId,
      'lessonid': lessonId,
      'title': title,
      'description': description,
      'example': example,
      'partNO': partNo,
    }).then(
      (value) {
        print("Lesson Added Succefully");
      },
    ).onError(
      (error, stackTrace) {
        print(error.toString());
      },
    );
    notifyListeners();
  }

  Future<void> updateLesson(
      String lessonId, String title, String description) async {
    final ref = FirebaseDatabase.instance.ref('lessons');
    await ref.child(lessonId).update({
      'title': title.toString(),
      'description': description.toString(),
    }).then((value) {
      print("db_provider " + lessonId);
      // print();
      print(lessonId + title + description);
      print('Data Updated Successfully');
    }).onError((er, StackTrace) {
      print(er.toString());
    });
    notifyListeners();
  }

  Future<void> deleteLesson(String lessonId) async {
    final ref = FirebaseDatabase.instance.ref('lessons');
    await ref.child(lessonId).remove().then((value) {
      print("db_provider " + lessonId);
      // print();
      print(lessonId);
      print('Data deleted Successfully');
    }).onError((er, StackTrace) {
      print(er.toString());
    });
    notifyListeners();
  }

  Future<void> addQuiz(
      String lessonId,
      String quizId,
      String question,
      String answer,
      option1,
      option2,
      option3,
      option4,
      hint,
      int quizNo) async {
    await dbRef.child('quiz/$quizId').set({
      'quizId': quizId,
      'lessonid': lessonId,
      'question': question,
      'answer': answer,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
      'hint': hint,
      'quizNO': quizNo,
    }).then(
      (value) {
        print("Quiz Added Succefully");
      },
    ).onError(
      (error, stackTrace) {
        print(error.toString());
      },
    );
    notifyListeners();
  }

  Future<void> updateUserPoints(String userid, int point) async {
    await dbRef.child('Users/$userid').update({
      'point': point,
    });
    notifyListeners();
  }
}
