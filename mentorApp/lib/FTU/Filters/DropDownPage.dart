import 'package:flutter/material.dart';
import 'package:mentorApp/FTU/Filters/DropDownButton.dart';

class DropDownPage extends StatelessWidget {
  //static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,),
        body: Center(
          child: MyStatefulWidget(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text("Next"),
          onPressed: (){
            Navigator.pushNamed(context, '/completion');
          },
        ),
      );
  }
}