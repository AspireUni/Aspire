import 'package:flutter/material.dart';

class Item {
  const Item(this.industry,this.selection);
  final String industry;
  final String selection;
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Item selectedItem;
  List<Item> users = <Item>[const Item('Tech', 'hi'), const Item('Arts','Bar')];

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        body: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(
              child: buildButton(),
            ),
          ],
        ),
      ),
    );
  }
}

buildButton(){
  return DropdownButtonHideUnderline(
    child: new DropdownButton<Item>(
                hint: new Text("Select an industry"),
                value: _MyStatefulWidgetState().selectedItem,
                onChanged: (Item newValue) {
                    _MyStatefulWidgetState().selectedItem = newValue;
                },
                items: _MyStatefulWidgetState().users.map((Item user) {
                  return new DropdownMenuItem<Item>(
                    value: user,
                    child: new Text(
                      user.industry,
                      style: new TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
  );
}



// buildNameTextBox() {
//   return Container(
//     width: 295.0, 
//     height: 90.0, 
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget> [
//         Container(
//           width: 50.0, 
//           height: 50.00, 
//           decoration: BoxDecoration(
//             color: Color(0xFF45cab9), 
//             shape: BoxShape.circle
//           )
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center ,
//           children: <Widget> [
//             buildButton(), 
//             buildButton()
//           ]
//         )
//       ]
//     ),
//       decoration: BoxDecoration(
//         color: Colors.black, 
//       border: Border.all(
//         width: 3.0
//       ),
//       borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(20.0),
//           topRight: Radius.circular(20.0),
//           bottomLeft: Radius.elliptical(40.0, 40.0)
//       ),
//     )
//   );
// }
