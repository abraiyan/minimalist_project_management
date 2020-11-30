import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moor_flutter/moor_flutter.dart' as moor;
import 'package:provider/provider.dart';
import 'package:sideappbarui/constants/constant_color.dart';
import 'package:sideappbarui/services/database.dart';
import 'package:sideappbarui/widgets/header_widget.dart';
import 'package:sideappbarui/widgets/item_main.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  PageController pageController;
  int bottomNavBarIndex = 0; //To control the selection fo the bottom nav bar index
  int currentIndexPageController = 0;
  bool isJumping = false; //for the bottomNavigationBar
  int indexID = 0; //to determine which page are we in right now
  int indexSelected = 3; //for choosing the priority
  bool isSorted = false; //to switch between sort option

  @override
  void initState() {
    pageController = PageController(initialPage: currentIndexPageController, keepPage: false, viewportFraction: 0.88);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFAB(),
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      bottomNavigationBar: buildBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: PageView.builder(
          physics: const ClampingScrollPhysics(),
          controller: pageController,
          onPageChanged: (value) {
            setState(() {
              indexID = value;
              if(isJumping) return;
              bottomNavBarIndex = value;
            });
          },
          itemCount: Constants.kTitles.length,
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
                      HeaderWidget(titles: Constants.kTitles[index], index: index),
                      const SizedBox(height: 12,),
                      Expanded(
                        child: (indexID == index || indexID == index + 1 || indexID == index - 1) ? StreamBuilder(
                          stream: Provider.of<ItemsDao>(context).watchAllItemsById(index, isSorted),
                          builder: (context, AsyncSnapshot<List<Item>> snapshot) {
                            if(snapshot.hasData) {
                              return ListView.builder(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                itemCount: snapshot.data.length,
                                itemBuilder: (context, index) {
                                  final Item currentItem = snapshot.data[index];
                                  return Column(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      ItemMain(item: currentItem),
                                      // ignore: prefer_const_literals_to_create_immutables
                                      const SizedBox(height: 14,),
                                    ],
                                  );
                                },
                              );
                            }
                            return const Center(child: Text('No Data'),);
                          },
                        ) : const Center(child: Text('GG'),),
                      ),
                    ],
                  ),
                ),
              );
          },
        ),
      ),
    );
  }

  Widget buildFAB() {

    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return GestureDetector(
      onTap: () {
        showDialog(context: context, builder: (context) {
          return buildAddTaskDialog(titleController, descriptionController);
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

  StatefulBuilder buildAddTaskDialog(TextEditingController titleController, TextEditingController descriptionController) {
    return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Add Task', style: GoogleFonts.montserrat(fontSize: 16),),
              actions: [
                FlatButton(
                  onPressed: () {
                    final item = ItemTableCompanion(title: moor.Value(titleController.text.toString()), description: moor.Value(descriptionController.text.toString()), priority: moor.Value(indexSelected), parentID: moor.Value(indexID));
                    Provider.of<ItemsDao>(context, listen: false).insertItem(item);
                    titleController.clear();
                    descriptionController.clear();
                    indexSelected = -1;
                    Navigator.pop(context);
                  },
                  child: Text('Done', style: GoogleFonts.montserrat(),),
                ),
              ],
              // ignore: sized_box_for_whitespace
              content: Container(
                width: MediaQuery.of(context).size.width,
                height: 220,
                child: ListView(
                  children: [
                    TextField(
                      controller: titleController,
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
                      controller: descriptionController,
                      maxLines: 2,
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
                    const SizedBox(height: 8),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        ChoiceChip(
                          label: const Text('HIGH'),
                          labelStyle: GoogleFonts.montserrat(fontSize: 12),
                          selectedColor: Constants.kColorChipHigh,
                          selected: indexSelected == 0,
                          onSelected: (value) {
                            setState(() {
                              indexSelected = value ? 0 : 3;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('MEDIUM'),
                          labelStyle: GoogleFonts.montserrat(fontSize: 12),
                          selectedColor: Constants.kColorChipMedium,
                          selected: indexSelected == 1,
                          onSelected: (value) {
                            setState(() {
                              indexSelected = value ? 1 : 3;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        ChoiceChip(
                          label: const Text('LOW'),
                          labelStyle: GoogleFonts.poppins(fontSize: 12),
                          selectedColor: Constants.kColorChipLow,
                          selected: indexSelected == 2,
                          onSelected: (value) {
                            setState(() {
                              indexSelected = value ? 2 : 3;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
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
          const SizedBox(width: 12,),
          Text('To Do', style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 16),),
        ],
      ),
      actions: [
        PopupMenuButton(
          icon: const Icon(Icons.more_vert, color: Colors.black87,),
          onSelected: (value) {
            if(value == 'delete') {
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Text('Delete All Task?', style: GoogleFonts.montserrat(fontSize: 16),),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No', style: GoogleFonts.montserrat(color: Colors.blueAccent),),
                    ),
                    FlatButton(
                      onPressed: () {
                        Provider.of<ItemsDao>(context, listen: false).deleteAllItem();
                        Navigator.pop(context);
                      },
                      child: Text('Yes', style: GoogleFonts.montserrat(color: Colors.redAccent),),
                    ),
                  ],
                );
              });
            }
            if(value == 'sort') {
              setState(() {
                isSorted = !isSorted;
              });
            }
          },
          itemBuilder: (context) => <PopupMenuItem<String>>[
            PopupMenuItem<String>(
              value: 'sort',
              child: Text(isSorted ? 'Sort by ID' : 'Sort High to Low', style: GoogleFonts.montserrat(color: Colors.black87),),
            ),
            PopupMenuItem<String>(
              value: 'delete',
              child: Text('Delete All Task', style: GoogleFonts.montserrat(color: Colors.black87),),
            ),
          ],
        ),
      ],
    );
  }
}



