import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/screens/login_tab/connector.dart';

class LoginViewModel extends ChangeNotifier{
  late LoginConnector loginConnector;
   void loginUser(String email, String password,
       // Function onSuccess,
       // Function onError
       ) async {
    try {
      loginConnector.showLoading();
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
       credential.user!.sendEmailVerification();
      // await credential.user!.sendEmailVerification();
      if(credential.user?.uid!=null){
        if(credential.user!.emailVerified){
          loginConnector.hideLoading();
          loginConnector.goToHome();
          // onSuccess();
        }
        else{
          loginConnector.hideLoading();
          loginConnector.showMessage("Please Veritify Your Mail");
          // onError("Please Veritify Your Mail");
        }
      }
    } on FirebaseAuthException catch (e) {
      loginConnector.hideLoading();
      loginConnector.showMessage("${e.message}");
      // onError("wrong mail or password");
    }
  }

}