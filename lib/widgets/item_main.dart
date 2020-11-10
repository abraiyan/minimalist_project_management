import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sideappbarui/constants/constant_color.dart';
import 'package:sideappbarui/services/database.dart';

class ItemMain extends StatelessWidget {

  final Item item;

  const ItemMain({
    Key key, this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double headerFontSize = 16;
    const double descriptionFontSize = 14;
    int indexSelected = item.priority;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0.0, 2.0),
            ),
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(item.title, style: GoogleFonts.montserrat(color: Colors.black87, fontSize: headerFontSize, decoration: (item.isDone) ? TextDecoration.lineThrough : TextDecoration.none),),
              const Spacer(),
              // ignore: sized_box_for_whitespace
              Container(
                width: 26,
                height: 26,
                child: PopupMenuButton(
                  padding: const EdgeInsets.only(left: 6),
                  onSelected: (value) {
                    if(value == 'Delete') {
                      Provider.of<ItemsDao>(context, listen: false).deleteItem(item);
                    }
                    if(value == 'Edit') {
                      showDialog(context: context, builder: (context) {
                        final TextEditingController titleController = TextEditingController()..text = item.title;
                        final TextEditingController descriptionController = TextEditingController()..text = item.description;

                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Text('Edit Task', style: GoogleFonts.montserrat(fontSize: 16),),
                              actions: [
                                FlatButton(
                                  onPressed: () {
                                    Provider.of<ItemsDao>(context, listen: false).updateItem(item.copyWith(title: titleController.text.toString(), description: descriptionController.text.toString(), priority: indexSelected));
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
                                              indexSelected = value ? 0 : -1;
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
                                              indexSelected = value ? 1 : -1;
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
                                              indexSelected = value ? 2 : -1;
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
                      });
                    }
                    if(value == 'Done') {
                      Provider.of<ItemsDao>(context, listen: false).updateItem(item.copyWith(parentID: 2));
                    }
                    if(value == 'Doing') {
                      Provider.of<ItemsDao>(context, listen: false).updateItem(item.copyWith(parentID: 1));
                    }
                  },
                  itemBuilder: (context) => <PopupMenuItem<String>>[
                     PopupMenuItem<String>(
                      value: 'Edit',
                      child: Text('Edit', style: GoogleFonts.montserrat(color: Colors.black87),),
                    ),
                     PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text('Delete', style: GoogleFonts.montserrat(color: Colors.black87),),
                    ),
                    PopupMenuItem<String>(
                      value: 'Doing',
                      child: Text('Now Doing', style: GoogleFonts.montserrat(color: Colors.black87),),
                    ),
                    PopupMenuItem<String>(
                      value: 'Done',
                      child: Text('Move To Done', style: GoogleFonts.montserrat(color: Colors.black87),),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Text(item.description, style: GoogleFonts.montserrat(color: (item.isDone) ? Colors.black38 : Colors.black87, fontSize: descriptionFontSize, fontWeight: FontWeight.w300),),
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityColor(item.priority),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Text(priorityText(item.priority), style: GoogleFonts.montserrat(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Provider.of<ItemsDao>(context, listen: false).updateItem(item.copyWith(isDone: !item.isDone));
                  if(!item.isDone && item.parentID != 2) {
                    showDialog(context: context, builder: (_) {
                      return AlertDialog(
                        title: Text('Move task to Done?', style: GoogleFonts.montserrat(fontSize: 16),),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text('No', style: GoogleFonts.montserrat(color: Colors.blueAccent),),
                          ),
                          FlatButton(
                            onPressed: () {
                              Provider.of<ItemsDao>(context, listen: false).updateItem(item.copyWith(parentID: 2, isDone: !item.isDone));
                              Navigator.pop(context);
                            },
                            child: Text('Yes', style: GoogleFonts.montserrat(color: Colors.redAccent),),
                          ),
                        ],
                      );
                    });
                  }
                },
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: (item.isDone) ? Colors.blueAccent : Colors.white,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: (item.isDone) ? Colors.blueAccent : Colors.black26,
                    ),
                  ),
                  child: Icon(Icons.done, color: (item.isDone) ? Colors.white : Colors.black26, size: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String priorityText(int id) {
    if(id == 0) {
      return 'HIGH';
    } else if(id == 1){
      return 'MEDIUM';
    } else if(id == 2) {
      return 'LOW';
    }
    return '';
  }
  Color priorityColor(int id) {
    if(id == 0) {
      return const Color(0xffFF005E);
    } else if(id == 1){
      return const Color(0xffA900FF);
    } else if(id == 2) {
      return const Color(0xff00B2FF);
    }
  }


}
