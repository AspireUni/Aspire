class Localization {
  final List <Specialty> specialty;
  final List <Industry > industry;

  Localization({this.specialty, this.industry});

  factory Localization.fromJson(Map<String, dynamic> json) {
    return Localization(
 
       
      industry: parseIndustry(json),
      specialty: parseSpecialty(json),
      
    );
  }

  
  static List<Industry > parseIndustry(industryJson) {
    var industryList = industryJson['industry'] as List;
    List<Industry > statesList =
       industryList.map((data) => Industry .fromJson(data)).toList();
    return statesList;
  }

  static List<Specialty> parseSpecialty(specialtyJson) {
    var specialtyList = specialtyJson['specialty'] as List;
    List<Specialty> provincesList =
        specialtyList.map((data) => Specialty.fromJson(data)).toList();
    return provincesList;
  }



}

class Industry  {
  final int id;
  final String name;

  Industry ({this.id, this.name});

  factory Industry .fromJson(Map<String, dynamic> parsedJson){
    return Industry (id: parsedJson['id'], name: parsedJson['name']);
  }

}

class Specialty {
  final int id;
  final String name;
  final int industryId;

  Specialty({this.id, this.name, this.industryId});

  factory Specialty.fromJson(Map<String, dynamic> parsedJson) {
    return Specialty(id: parsedJson['id'], name: parsedJson['name'],  industryId: parsedJson['industry_id']);
  }

}