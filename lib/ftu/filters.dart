import 'package:flutter/material.dart';

class Item {
  const Item(this.industry,this.selection);
  final String industry;
  final String selection;
}

class FiltersPage extends StatefulWidget {
  FiltersPage({Key key}) : super(key: key);

  @override
  FiltersState createState() => FiltersState();
}

class FiltersState extends State<FiltersPage> {
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
                value: FiltersState().selectedItem,
                onChanged: (Item newValue) {
                    FiltersState().selectedItem = newValue;
                },
                items: FiltersState().users.map((Item user) {
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