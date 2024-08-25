import 'package:flutter/material.dart';
import 'package:todo_app/firebase_utils.dart';
import 'package:todo_app/model/task.dart';

class ListProvider extends ChangeNotifier {
  var selectDate = DateTime.now();
  List<Task> tasksList = [];

  void getAllTasksFromFireStore(String uId) async {
    //get all tasks in firebase
    var querySnapshot = await FirebaseUtils.getTasksCollection(uId).get();
    // List<QueryDocumentSnapshot<Task>>
    tasksList = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    tasksList.where((task) {
      if (selectDate.day == task.datetime.day &&
          selectDate.month == task.datetime.month &&
          selectDate.year == task.datetime.year) {
        return true;
      } else {
        return false;
      }
    }).toList();

    //sorting
    tasksList.sort((task1, task2) {
      return task1.datetime.compareTo(task2.datetime);
    });

    notifyListeners();
  }

  //filter tasks => select date (chosen by user)
  void changeSelectDate(DateTime newDate, String uId) {
    selectDate = newDate;
    getAllTasksFromFireStore(uId);
  }
}
