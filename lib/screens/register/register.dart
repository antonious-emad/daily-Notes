import 'package:flutter/material.dart';
import 'package:untitled/screens/login_tab/login.dart';
import 'package:untitled/screens/register/signup.dart';


class LoginScreen extends StatelessWidget {
 static const String routeName="Login";
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("login"),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.login),child: Text("Login")),
              Tab(child: Text("Sign Up")),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LoginTab(),
            SignUpTab()
          ],
        ),
      ),
    );
  }
}
