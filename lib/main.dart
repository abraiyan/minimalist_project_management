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
  int currentIndexPageController = 0;
  PageController pageController;
  bool isJumping = false;

  @override
  void initState() {
    pageController = PageController(initialPage: currentIndexPageController, keepPage: false, viewportFraction: 0.88,);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFAB(),
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: PageView.builder(
        physics: BouncingScrollPhysics(),
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            if(isJumping) return;
            bottomNavBarIndex = value;
          });
        },
        itemCount: 3,
        itemBuilder: (context, index) {
          return AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              double value = 1;
              if(pageController.position.haveDimensions) {
                value = pageController.page - index;
                value = (1 - (value.abs() * 0.15)).clamp(0.0, 1.0);
              }
              return Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: Curves.easeInOut.transform(value) * (MediaQuery.of(context).size.height * 0.73),
                  child: Opacity(
                    opacity: value,
                    child: child,
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text('To Do', style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w500),),
                      Spacer(),
                      Icon(Icons.add, color: Colors.black87,),
                      SizedBox(width: 6,),
                      Icon(Icons.more_vert, color: Colors.black87,),
                    ],
                  ),
                  Divider(
                    color: Colors.black87,
                    thickness: 1,
                  ),
                  SizedBox(height: 12,),
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            NewWidget(),
                            SizedBox(height: 14,),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Container buildFAB() {
    return Container(
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
    );
  }

  BottomNavigationBar buildBottomNavigationBar() {
    return BottomNavigationBar(
      elevation: 20,
      currentIndex: bottomNavBarIndex,
      onTap: (index) {
        setState(() {
          isJumping = true;
          bottomNavBarIndex = index;
          pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.easeInOut).then((value) {
            setState(() {
              isJumping = false;
            });
          });
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

class NewWidget extends StatelessWidget {
  const NewWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black26.withOpacity(0.15),
            blurRadius: 8,
            offset: Offset(0.0, 2.0),
          ),
        ]
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('Finish The UI', style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 20),),
              Spacer(),
              Icon(Icons.more_horiz, color: Colors.black87,),
            ],
          ),
          SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text('Gather Jane and Joan and finish the header design according to the decisions made by the board.', style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 18, fontWeight: FontWeight.w300),),
          ),
          SizedBox(height: 16,),
          Row(
            children: [
              Chip(
                label: Text('HIGH', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),),
                backgroundColor: Color(0xFFFF005E),
                labelPadding: EdgeInsets.symmetric(horizontal: 8),
              ),
              Spacer(),
              Icon(Icons.calendar_today, color: Colors.blueAccent,),
              SizedBox(width: 6,),
              Text('12/12/20', style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 16),)
            ],
          ),
        ],
      ),
    );
  }
}

