import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/model/task.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTasksCollection() {
    return FirebaseFirestore.instance
        .collection(Task.collectionName)
        .withConverter<Task>(
            fromFirestore: ((snapshot, options) =>
                Task.fromJson(snapshot.data()!)),
            toFirestore: (task, options) => task.toJson());
  }

  static Future<void> addTaskToFireStore(Task task) {
    var taskCollection = getTasksCollection();
    var taskDocRef = taskCollection.doc();
    task.id = taskDocRef.id; //auto id
    return taskDocRef.set(task);
  }

  static Future<void> deleteTaskFromFirestore(Task task) {
    return getTasksCollection().doc(task.id).delete();
  }

  static Future<void> updateTaskInFirestore(Task task) async {
    final docTask = getTasksCollection().doc(task.id);
    await docTask.update(task.toJson());
  }
}
