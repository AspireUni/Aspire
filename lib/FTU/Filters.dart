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

// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   Item selectedItem;
//   List<Item> users = <Item>[const Item('Tech', 'hi'), const Item('Arts','Bar')];

//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       home: new Scaffold(
//         body: new Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             new Center(
//               child: buildButton(),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  Item selectedItem;
  List<Item> users = <Item>[const Item('Tech', 'hi'), const Item('Arts','Bar')];

 @override
   Widget build(BuildContext context) {
     return Stack(
         children: <Widget>[
           Image.asset(
             "images/DashboardBg.png",
             height: MediaQuery.of(context).size.height,
             width: MediaQuery.of(context).size.width,
             fit: BoxFit.fill,
           ),
           Scaffold(
               backgroundColor: Colors.transparent,
               appBar: AppBar(
                 backgroundColor: Colors.transparent,
                 elevation: 0.0,
               ),
               body: Center(
               child: buildButton(),
               ),
               floatingActionButton: FloatingActionButton(
               child: Text("Next"),
               onPressed: (){
               Navigator.pushNamed(context, '/second');
               },
           )
           )
         ]
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

// import 'package:flutter/material.dart';
// import 'package:mentorApp/FTU/Filters/DropDownButton.dart';

// class DropDownPage extends StatelessWidget {

// @override
//   Widget build(BuildContext context) {
//     return Stack(
//         children: <Widget>[
//           Image.asset(
//             "images/DashboardBg.png",
//             height: MediaQuery.of(context).size.height,
//             width: MediaQuery.of(context).size.width,
//             fit: BoxFit.fill,
//           ),
//           Scaffold(
//               backgroundColor: Colors.transparent,
//               appBar: AppBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0.0,
//               ),
//               body: Center(
//               child: buildButton(),
//               ),
//               floatingActionButton: FloatingActionButton(
//               child: Text("Next"),
//               onPressed: (){
//               Navigator.pushNamed(context, '/completion');
//               },
//           )
//           )
//         ]
//       );
//   }
// }