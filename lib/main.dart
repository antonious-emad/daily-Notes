import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/layout/home_layout.dart';
import 'package:untitled/providers/my_provider.dart';
import 'package:untitled/screens/register/register.dart';
import 'package:untitled/screens/settings/settings_tab.dart';
import 'package:untitled/shared/styles/my_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.disableNetwork();
  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(),
  child:  MyApp()));
}


class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<MyProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        HomeLayout.routeName:(context)=>HomeLayout(),
        SettingsTab.routeName:(context)=>SettingsTab(),
        LoginScreen.routeName:(context)=>LoginScreen(),
      },
      initialRoute:provider.firebaseUser!=null? HomeLayout.routeName:LoginScreen.routeName,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}


