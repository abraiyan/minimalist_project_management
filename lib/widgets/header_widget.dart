import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sideappbarui/services/database.dart';

class HeaderWidget extends StatelessWidget {

  final int index;
  final String titles;

  const HeaderWidget({
    Key key,
    @required this.titles, this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(titles, style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w500),),
            const Spacer(),
            // ignore: sized_box_for_whitespace
            Container(
              height: 35,
              width: 40,
              child: PopupMenuButton(
                icon: const Icon(Icons.more_vert, color: Colors.black87,),
                onSelected: (value) {
                  if(value == 'delete') {
                    Provider.of<ItemsDao>(context, listen: false).deleteByParentID(index);
                  }
                },
                itemBuilder: (context) => <PopupMenuItem<String>>[
                  PopupMenuItem<String>(
                    value: 'delete',
                    child: Text('Delete All Task', style: GoogleFonts.montserrat(color: Colors.black87),),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.black87,
          thickness: 0.7,
        ),
      ],
    );
  }
}