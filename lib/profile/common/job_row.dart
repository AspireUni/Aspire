import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/models.dart';

class JobRow extends StatelessWidget {
  final  Job job;
 
  JobRow({Key key, @required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var dateRange = "${job.startDate} - ${job.endDate}";

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          buildJobText(
            job.title,
            isJobTitle: true,
            isDateRange: false
          ),
          buildJobText(
            job.company,
            isJobTitle: false,
            isDateRange: false
          ),
          buildJobText(
            dateRange,
            isJobTitle: false,
            isDateRange: true
          )
        ]
      )
    );
  }

  Widget buildJobText(String text, {bool isJobTitle, bool isDateRange}) {
    return Text(
      text,
      textAlign: TextAlign.left,
      softWrap: true,
      style: GoogleFonts.muli(
        textStyle: TextStyle(
          color: isDateRange ? Colors.black54 : Colors.black,
          letterSpacing: .5,
          height: 1.2,
          fontSize: 13.0,
          fontWeight: isJobTitle ? FontWeight.w700 : FontWeight.w500
        ),
      )
    );
  }
}
