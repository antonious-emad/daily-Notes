import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../shared/firebase/firebase_functions.dart';

class MyProvider extends ChangeNotifier {
  UserModel? userModel;
  User? firebaseUser;

  MyProvider() {
    firebaseUser = FirebaseAuth.instance.currentUser;
    if (firebaseUser != null) {
      initMyUser();
    }
  }

  void initMyUser() async {
    firebaseUser=FirebaseAuth.instance.currentUser;
    userModel = await FireBaseFunctions.readUser(
        firebaseUser!.uid);
    notifyListeners();
  }
}
