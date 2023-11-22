import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled/models/task_model.dart';

import '../../models/user_model.dart';

class FireBaseFunctions{
static CollectionReference<TaskModel> getTaskCollection(){
  return FirebaseFirestore.instance.collection("Tasks").withConverter<TaskModel>(fromFirestore: (snapshot, _) {
    return TaskModel.fromJson(snapshot.data()!);
  }, toFirestore: (tasks, options) {return tasks.toJson();},
  );
}
static void  addTask(TaskModel taskModel){
    var collection=getTaskCollection();
    var docRef=collection.doc();
    taskModel.id=docRef.id;
    docRef.set(taskModel);
  }
static Stream<QuerySnapshot<TaskModel>> getTasksFromFirestore(DateTime date) {
  return getTaskCollection()
      .orderBy("date", descending: false)
      .orderBy("title", descending: false)
      .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where("date", isEqualTo: DateUtils.dateOnly(date).millisecondsSinceEpoch
  )
      .snapshots();
}
static Future<void> deleteTask(String id) {
  return getTaskCollection().doc(id).delete();
}
static Future<void> updateTask(TaskModel task) {
  return getTaskCollection().doc(task.id).update(task.toJson());
}
static Stream<QuerySnapshot<TaskModel>>getTasksRealTimeChanges(  DateTime dateTime){
  return getTaskCollection()
      .where("userId", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where("date", isEqualTo:DateUtils.dateOnly(dateTime).millisecondsSinceEpoch).snapshots(); //real time changes
  // isEqualTo:DateUtils.dateOnly(dateTime).millisecondsSinceEpoch).orderBy("date",descending: true).snapshot(); //for ordering
}
static Future<QuerySnapshot<TaskModel>>getTasks(  DateTime dateTime){
  return getTaskCollection().where("date",
      isEqualTo:DateUtils.dateOnly(dateTime).millisecondsSinceEpoch).get(); //one time read should refresh screen
  // isEqualTo:DateUtils.dateOnly(dateTime).millisecondsSinceEpoch).orderBy("date",descending: true).get(); //for ordering
}

static CollectionReference<UserModel> getUsersCollection() {
  return FirebaseFirestore.instance
      .collection("Users")
      .withConverter<UserModel>(
    fromFirestore: (snapshot, _) {
      return UserModel.fromJson(snapshot.data()!);
    },
    toFirestore: (value, options) {
      return value.toJson();
    },
  );
}
static Future <void> addUserToFirestore(UserModel userModel) {
  var collection = getUsersCollection();
  var docRef = collection.doc(userModel.id);
  return docRef.set(userModel);
}
static createUser(int age, String name, String email, String password, Function onSuccess, Function onError) async {
  try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((cred) {
      UserModel userModel =
      UserModel(id: cred.user!.uid, email: email, name: name, age: age);
      addUserToFirestore(userModel).then((value) {
        cred.user!.sendEmailVerification();
        onSuccess();
      });
    });
  } on FirebaseAuthException catch (e) {
    onError(e.message);

    // if (e.code == 'weak-password') {
    //   onError(e.message);
    //   print('The password provided is too weak.');
    // }
    // else if (e.code == 'email-already-in-use') {onError(e.message);print('The account already exists for that email.');
    // }
  } catch (e) {
    onError(e.toString());
    print(e);
  }
}
// static void loginUser(String email, String password, Function onSuccess, Function onError) async {
//   try {
//     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
//     credential.user!.sendEmailVerification();
//     if(credential.user?.uid!=null){
//       if(credential.user!.emailVerified){onSuccess();}
//       else{onError("Please Veritify Your Mail");}
//     }
//   } on FirebaseAuthException catch (e) {
//     onError("wrong mail or password");
//   }
// }
static Future<UserModel?> readUser(String id) async {
  DocumentSnapshot<UserModel> userDoc =
  await getUsersCollection().doc(id).get();
  return userDoc.data();
}
}