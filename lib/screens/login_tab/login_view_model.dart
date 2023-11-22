import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/base.dart';
import 'package:untitled/screens/login_tab/connector.dart';

class LoginViewModel extends BaseViewModel<LoginConnector>{
   void loginUser(String email, String password,
       // Function onSuccess,
       // Function onError
       ) async {
    try {
      connector!.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
       credential.user!.sendEmailVerification();
      // await credential.user!.sendEmailVerification();
      if(credential.user?.uid!=null){
        if(credential.user!.emailVerified){
          connector!.hideLoading();
          connector!.goToHome();
          // onSuccess();
        }
        else{
          connector!.hideLoading();
          connector!.showmessage("Please Veritify Your Mail");
          // onError("Please Veritify Your Mail");
        }
      }
    } on FirebaseAuthException catch (e) {
      connector!.hideLoading();
      connector!.showmessage("${e.message}");
      // onError("wrong mail or password");
    }
  }

}