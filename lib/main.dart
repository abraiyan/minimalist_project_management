import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sideappbarui/screens/home_page.dart';
import 'package:sideappbarui/screens/onboarding_screen.dart';
import 'package:sideappbarui/services/database.dart';

int intiScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  intiScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) =>  AppDatabase().itemsDao,
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //To hide the DEBUG red bar from the app
        home: OnBoardingScreen(),
      ),
    );
  }
}

