import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemMain extends StatelessWidget {

  const ItemMain({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const double headerFontSize = 16;
    const double descriptionFontSize = 14;
    const double dateFontSize = 12;

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
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text('Finish The UI', style: GoogleFonts.montserrat(color: Colors.black87, fontSize: headerFontSize),),
              const Spacer(),
              // ignore: sized_box_for_whitespace
              Container(
                width: 26,
                height: 26,
                child: PopupMenuButton(
                  padding: const EdgeInsets.only(left: 6),
                  itemBuilder: (context) => <PopupMenuItem<String>>[
                     PopupMenuItem<String>(
                      value: 'Edit',
                      child: Text('Edit', style: GoogleFonts.montserrat(color: Colors.black87),),
                    ),
                     PopupMenuItem<String>(
                      value: 'Delete',
                      child: Text('Delete', style: GoogleFonts.montserrat(color: Colors.black87),),
                    ),
                  ],

                ),
              ),
            ],
          ),

          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Text('Gather Jane and Joan and finish the header design according to the decisions made by the board. ', style: GoogleFonts.montserrat(color: Colors.black87, fontSize: descriptionFontSize, fontWeight: FontWeight.w300),),
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFF005E),
                  borderRadius: BorderRadius.circular(40.0),
                ),
                child: Text('HIGH', style: GoogleFonts.montserrat(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w500),),
              ),
              const Spacer(),
              const Icon(Icons.calendar_today, color: Colors.blueAccent, size: 18,),
              const SizedBox(width: 4),
              Text('12/12/20', style: GoogleFonts.montserrat(color: Colors.black87, fontSize: dateFontSize, letterSpacing: 1.1),)
            ],
          ),
        ],
      ),
    );
  }
}
