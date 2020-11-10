import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {

  const HeaderWidget({
    Key key,
    @required this.titles,
  }) : super(key: key);

  final String titles;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(titles, style: GoogleFonts.montserrat(color: Colors.black87, fontSize: 20, fontWeight: FontWeight.w500),),
            const Spacer(),
            const Icon(Icons.more_vert, color: Colors.black87,),
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