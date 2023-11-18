import 'package:flutter/material.dart';
import 'package:untitled/screens/settings_tab.dart';
import 'package:untitled/screens/tasks_tab.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: Tabs[index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value){
          index=value;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(icon:Icon(Icons.list),label: " "),
          BottomNavigationBarItem(icon:Icon(Icons.settings),label: " "),
        ],
      ),
    );
  }
}
