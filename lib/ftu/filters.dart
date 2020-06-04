import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'dart:convert';
import 'package:mentorApp/ftu/parsing.dart';

class FiltersPage extends StatefulWidget {
  FiltersPage({Key key}) : super(key: key);

  @override
  FiltersState createState() => FiltersState();
}

class FiltersState extends State<FiltersPage> {
  //Item selectedItem;
  //List<Item> users = <Item>[const Item('Tech', 'hi'), const Item('Arts','Bar')];
  List industryList = List();
  List specialtyList = List();
  List tempList = List();
  String _state;
  String _province;

  Future<String> loadStatesProvincesFromFile() async {
    return await rootBundle.loadString('json/filter.json');
  }

  Future<String> _populateDropdown() async {
    String getPlaces = await loadStatesProvincesFromFile();
    final jsonResponse = json.decode(getPlaces);

    Localization places = new Localization.fromJson(jsonResponse);

    setState(() {
      industryList = places.states;
      specialtyList = places.provinces;
    });
  }

  @override
  void initState() {
    super.initState();
    this._populateDropdown();
  }

  Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          child: new Form(
            child: Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 28.0),
              child: new Container(
                width: 350,
                decoration: new BoxDecoration(
                image: new DecorationImage(image: new AssetImage("images/DefaultBg.png"), fit: BoxFit.cover,),
                ),
                child: Column(
                  children: <Widget>[
                    new DropdownButton(
                      isExpanded: true,
                      items: industryList.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item.name),
                          value: item.id.toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _province = null;
                          _state = newVal;
                          tempList = specialtyList
                              .where((x) =>
                                  x.stateId.toString() == (_state.toString()))
                              .toList();
                        });
                        // print(testingList.toString());
                      },
                      value: _state,
                      hint: Text('Select an industry'),
                    ),
                    new DropdownButton(
                      isExpanded: true,
                      items: tempList.map((item) {
                        return new DropdownMenuItem(
                          child: new Text(item.name),
                          value: item.id.toString(),
                        );
                      }).toList(),
                      onChanged: (newVal) {
                        setState(() {
                          _province = newVal;
                        });
                      },
                      
                      value: _province,
                      hint: Text('Select a field'),
                    ),
                    Align(
                      child: FloatingActionButton(
                        child: Text("Next"),
                        onPressed: () {
                        Navigator.pushNamed(context, '/second');
                      },),
                      alignment: Alignment.bottomRight,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
  }
}

// buildButton(){
//   return DropdownButtonHideUnderline(
//     child: new DropdownButton<Item>(
//                 isExpanded: true,
//                 hint: Text("Select an industry"),
//                 value: selectedItem,
//                 onChanged: (Item newValue) {
//                     selectedItem = newValue;
//                 },
//                 items: users.map((Item user) {
//                   return new DropdownMenuItem<Item>(
//                     value: user,
//                     child: new Text(
//                       user.industry,
//                       style: new TextStyle(color: Colors.black),
//                     ),
//                   );
//                 }).toList(),
//               ),
//   );
// }