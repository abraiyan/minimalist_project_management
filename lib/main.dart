import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sideappbarui/screens/home_page.dart';
import 'package:sideappbarui/services/database.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) =>  AppDatabase().itemsDao,
      child: MaterialApp(
        debugShowCheckedModeBanner: false, //To hide the DEBUG red bar from the app
        home: HomePage(),
      ),
    );
  }
}

