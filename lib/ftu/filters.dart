
import'../ftu/parsing.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class FiltersPage extends StatefulWidget {
  FiltersPage({Key key}) : super(key: key);

  @override
  FiltersState createState() => FiltersState();
}

class FiltersState extends State<FiltersPage> {
  List industryList = List();
  List specialtyList = List();
  List tempList = List();
  String _industry;
  String _specialty;

  void setIndustry(newVal) {
    setState(() {
      _specialty = null;
      _industry = newVal;
      tempList = specialtyList
          .where((x) => x.industryId.toString() == (_industry.toString()))
          .toList();
    });
  }

  Future<String> loadStatesProvincesFromFile() async {
    return await rootBundle.loadString('json/filter.json');
  }

  Future<String> _populateDropdown() async {
    String getPlaces = await loadStatesProvincesFromFile();
    final jsonResponse = json.decode(getPlaces);

    Localization places = new Localization.fromJson(jsonResponse);

    setState(() {
      industryList = places.industry;
      specialtyList = places.specialty;
    });
  }

  @override
  void initState() {
    super.initState();
    this._populateDropdown();
  }

  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "images/DefaultBg.png",
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
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              buildTitle(),
              buildIndustry(),
              buildSpecialty()
            ],
          )),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal,
            child: Text("Next"),
            onPressed: () {
              Navigator.pushNamed(context, '/second');
            },
          ))
    ]);
  }

  buildIndustry() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 0),
      child: new DropdownButton(
        isExpanded: true,
        items: industryList.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.name),
            value: item.id.toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setIndustry(newVal);
        },
        value: _industry,
        hint: Text('Select an industry',
          style: GoogleFonts.muli()),
      ),
    );
  }

  buildSpecialty() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
      child: new DropdownButton(
        isExpanded: true,
        items: tempList.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.name),
            value: item.id.toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            _specialty = newVal;
          });
        },
        value: _specialty,
        hint: Text('Select a field', 
          style: GoogleFonts.muli()),
      ),
    );
  }

  buildTitle() {
    return Container(
      padding: const EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 20.0),
      child: new Text("Intialize Your Profile",
          style: GoogleFonts.muli(
              textStyle: TextStyle(
                  color: Colors.black,
                  letterSpacing: .5,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold))),
    );
  }

} // End of class
