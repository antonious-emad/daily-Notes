import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/base.dart';
import 'package:untitled/screens/login_tab/connector.dart';
import 'package:untitled/screens/login_tab/login_view_model.dart';

import '../../layout/home_layout.dart';
import '../../providers/my_provider.dart';
import '../../shared/firebase/firebase_functions.dart';


class LoginTab extends StatefulWidget {
  LoginTab({super.key});

  @override
  State<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends BaseView<LoginViewModel,LoginTab>  implements LoginConnector{
var formKey=GlobalKey<FormState>();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel.connector=this;
  }
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return ChangeNotifierProvider(
      create: (context) => viewmodel,
      builder: (context, child) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'User Name',
                        hintText: 'Enter valid mail id as abc@gmail.com'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter your secure password'),
                  ),
                ),
                Container(
                  height: 50,
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.blue, borderRadius: BorderRadius.circular(20)),
                  child: ElevatedButton(
                    onPressed: () {
                      viewmodel.loginUser(
                          emailController.text,
                          passwordController.text,
                      //         () {
                      //   provider.initMyUser();
                      //   Navigator.pushNamedAndRemoveUntil(
                      //     context, HomeLayout.routeName, (route) => false,
                      //     // arguments: emailController.text
                      //   );
                      //
                      // },
                      //         (message) {
                      //   showDialog(
                      //     barrierDismissible: false,
                      //     context: context,
                      //     builder: (context) => AlertDialog(
                      //       title: Text("Error"),
                      //       content: Text(message),
                      //       actions: [
                      //         ElevatedButton(onPressed: () {
                      //           Navigator.pop(context);
                      //         }, child: Text("Okay"))
                      //       ],
                      //     ),
                      //   );
                      // }
                      );

                      // FireBaseFunctions.loginUser(
                      //     emailController.text,
                      //     passwordController.text, () {
                      //       provider.initMyUser();
                      //   Navigator.pushNamedAndRemoveUntil(
                      //       context, HomeLayout.routeName, (route) => false,
                      //       // arguments: emailController.text
                      //   );
                      //
                      //   }, (message) {
                      //   showDialog(
                      //     barrierDismissible: false,
                      //     context: context,
                      //     builder: (context) => AlertDialog(
                      //       title: Text("Error"),
                      //       content: Text(message),
                      //       actions: [
                      //         ElevatedButton(onPressed: () {
                      //           Navigator.pop(context);
                      //         }, child: Text("Okay"))
                      //       ],
                      //     ),
                      //   );
                      // });
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  goToHome() {
Navigator.pushNamedAndRemoveUntil(context, HomeLayout.routeName, (route) => false);
  }

  @override
  hideLoading() {
Navigator.pop(context);
  }

  @override
  showLoading() {
showDialog(
  context: context,
  barrierDismissible: false,
  builder: (context) => AlertDialog(
    backgroundColor: Colors.transparent,
  title: Center(child: CircularProgressIndicator()),
),);
  }

  @override
  showMessage(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        title: Text("Error"),
        content: Text(message),
        actions: [
          ElevatedButton(onPressed: () {
            Navigator.pop(context);
          }, child: Text("Thanks")),
        ],
      ),);
  }

  @override
  LoginViewModel inintMyViewModel() {
  return LoginViewModel();
  }

  @override
  showmessage(String message) {
    // TODO: implement showmessage
    throw UnimplementedError();
  }
}
