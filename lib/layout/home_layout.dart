import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/providers/my_provider.dart';
import 'package:untitled/screens/register/register.dart';
import 'package:untitled/screens/settings/settings_tab.dart';
import 'package:untitled/screens/tasks/add_task_bottom_sheet.dart';
import 'package:untitled/screens/tasks/tasks_tab.dart';

import '../models/user_model.dart';

class HomeLayout extends StatefulWidget {
static const String routeName="Layout";
  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  int index=0;
  List<Widget>Tabs=[TasksTab(),SettingsTab()];
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    // var useremail=ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
            FirebaseAuth.instance.sendPasswordResetEmail(email: provider.userModel!.email);
            // Navigator.pushNamedAndRemoveUntil(context,LoginScreen.routeName,(route) =>false,);
          }, icon: Icon(Icons.send)),

          IconButton(onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushNamedAndRemoveUntil(context,LoginScreen.routeName,(route) =>false,);
          }, icon: Icon(Icons.logout_outlined)),
        ],
        title: Text("ToDo List ${provider.userModel?.name}"),
        toolbarHeight: 80,
        elevation: 0,
      ),
      body: Tabs[index],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(onPressed: (){
        showSheet();
      },child: Icon(Icons.add),shape: CircleBorder(side: BorderSide(color: Colors.white,width: 3)),),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        notchMargin: 8,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          currentIndex: index,
          onTap: (value){
            index=value;
            setState(() {});
          },
          items: [
            BottomNavigationBarItem(icon:Icon(Icons.list,size: 30,),label: " "),
            BottomNavigationBarItem(icon:Icon(Icons.settings,size: 30,),label: " "),
          ],
        ),
      ),
    );
  }
showSheet(){
    showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        builder: (context){
      return Padding(
        padding:  EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: AddTaskBottomSheet(),
      );
    });
}
}
