import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sideappbarui/widgets/item_main.dart';

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
        physics: const ClampingScrollPhysics(),
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
                value = (1 - (value.abs() * 0.15)).clamp(0.0, 1.0).toDouble();
              }
              return Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: Curves.easeInOut.transform(value) * (MediaQuery.of(context).size.height * 0.8),
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
                      const Spacer(),
                      const Icon(Icons.add, color: Colors.black87,),
                      const SizedBox(width: 6,),
                      const Icon(Icons.more_vert, color: Colors.black87,),
                    ],
                  ),
                  const Divider(
                    color: Colors.black87,
                    thickness: 0.7,
                  ),
                  const SizedBox(height: 12,),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const ItemMain(),
                            // ignore: prefer_const_literals_to_create_immutables
                            const SizedBox(height: 14,),
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

  Widget buildFAB() {
    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                title: Text('Add Task', style: GoogleFonts.montserrat(fontSize: 16),),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Done', style: GoogleFonts.montserrat(),),
                  ),
                ],
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Task Name',
                        hintText: 'Enter the name of the task',
                        labelStyle: GoogleFonts.montserrat(fontSize: 14),
                        hintStyle: GoogleFonts.montserrat(fontSize: 14),
                        border:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Description',
                        hintText: 'Enter the details of your task',
                        labelStyle: GoogleFonts.montserrat(fontSize: 14),
                        hintStyle: GoogleFonts.montserrat(fontSize: 14),
                        border:  OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
      },
      child: Container(
        padding: const EdgeInsets.only(left: 11, top: 10, bottom: 10, right: 14),
        decoration: BoxDecoration(
          // ignore: prefer_const_literals_to_create_immutables
          boxShadow: [
            const BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(1.0, 2.0),
            ),
          ],
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(40.0),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.add, color: Colors.white, size: 20,),
            const SizedBox(width: 4),
            Text('Add Task', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 16),)
          ],
        ),
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
          pageController.animateToPage(index, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut).then((value) {
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
      items: const [
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
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/03w.jpg'),
          ),
          const SizedBox(width: 12,),
          Text('Helena Jobs', style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 16),),
        ],
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.more_vert, color: Colors.black87,),
        ),
      ],
    );
  }
}

