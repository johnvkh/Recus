class AccidentTypeBO {
  String? accidentTypeId;
  String? accidentTypeName;
  String? description;

  AccidentTypeBO({this.accidentTypeId, this.accidentTypeName, this.description});

  AccidentTypeBO.fromJson(Map<String, dynamic> json) {
    accidentTypeId = json['accident_type_id'];
    accidentTypeName = json['accident_type_name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accident_type_id'] = this.accidentTypeId;
    data['accident_type_name'] = this.accidentTypeName;
    data['description'] = this.description;
    return data;
  }
}