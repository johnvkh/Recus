class ProvinceBO {
  String? provinceId;
  String? provinceName;

  ProvinceBO({this.provinceId, this.provinceName});

  ProvinceBO.fromJson(Map<String, dynamic> json) {
    provinceId = json['province_id'];
    provinceName = json['province_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['province_id'] = this.provinceId;
    data['province_name'] = this.provinceName;
    return data;
  }
}