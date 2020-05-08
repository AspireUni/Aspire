import 'package:flutter/material.dart';
import 'package:mentorApp/FTU/Filters/DropDownButton.dart';

class DropDownPage extends StatelessWidget {
  //static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: _title,
      home: Scaffold(
        //appBar: AppBar(title: const Text(_title)),
        body: Center(
          child: MyStatefulWidget(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text("Next"),
          onPressed: (){
            Navigator.pushNamed(context, '/Completion');
          },
        ),
      ),
    );
  }
}