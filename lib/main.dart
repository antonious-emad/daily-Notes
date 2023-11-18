import 'package:flutter/material.dart';
import 'package:untitled/layout/home_layout.dart';
import 'package:untitled/screens/settings_tab.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeLayout.routeName:(context)=>HomeLayout(),
        SettingsTab.routeName:(context)=>SettingsTab(),
      },
      initialRoute: HomeLayout.routeName,
    );
  }
}


