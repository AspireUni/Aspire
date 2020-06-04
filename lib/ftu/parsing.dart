class Localization {
  final List <Provinces> provinces;
  final List <States> states;

  Localization({this.provinces, this.states});

  factory Localization.fromJson(Map<String, dynamic> json) {
    return Localization(
 
       
      states: parseStates(json),
      provinces: parseProvinces(json),
      
    );
  }

  
  static List<States> parseStates(statesJson) {
    var slist = statesJson['states'] as List;
    List<States> statesList =
       slist.map((data) => States.fromJson(data)).toList();
    return statesList;
  }

  static List<Provinces> parseProvinces(provincesJson) {
    var plist = provincesJson['provinces'] as List;
    List<Provinces> provincesList =
        plist.map((data) => Provinces.fromJson(data)).toList();
    return provincesList;
  }



}

class States {
  final int id;
  final String name;

  States({this.id, this.name});

  factory States.fromJson(Map<String, dynamic> parsedJson){
    return States(id: parsedJson['id'], name: parsedJson['name']);
  }

}

class Provinces {
  final int id;
  final String name;
  final int stateId;

  Provinces({this.id, this.name, this.stateId});

  factory Provinces.fromJson(Map<String, dynamic> parsedJson) {
    return Provinces(id: parsedJson['id'], name: parsedJson['name'],  stateId: parsedJson['state_id']);
  }

}