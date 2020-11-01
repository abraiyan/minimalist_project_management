import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int bottomNavBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        padding: EdgeInsets.only(left: 11, top: 10, bottom: 10, right: 14),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.add, color: Colors.white, size: 20,),
            SizedBox(width: 4),
            Text('Add Task', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16),)
          ],
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(1.0, 2.0),
            ),
          ],
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomNavigationBar(),
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 20,
      currentIndex: bottomNavBarIndex,
      onTap: (index) {
        setState(() {
          bottomNavBarIndex = index;
        });
      },
      selectedFontSize: 18.0,
      unselectedFontSize: 14.0,
      selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      unselectedLabelStyle: GoogleFonts.poppins(),
      backgroundColor: Colors.white,
      items: [
        BottomNavigationBarItem(
          icon: SizedBox(),
          label: "Todo",
        ),
        BottomNavigationBarItem(
          icon: SizedBox(),
          label: "Doing",
        ),
        BottomNavigationBarItem(
          icon: SizedBox(),
          label: "Done",
        ),
      ],
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 60,
      elevation: 2,
      backgroundColor: Colors.white,
      title: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/03w.jpg'),
          ),
          SizedBox(width: 12,),
          Text('Hello Kitty', style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 16),),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.more_vert, color: Colors.black87,),
        ),
      ],
    );
  }
}

