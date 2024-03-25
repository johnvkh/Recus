class DistrictBO {
  String? districtId;
  String? districtName;
  String? provinceId;
  String? provinceName;

  DistrictBO(
      {this.districtId, this.districtName, this.provinceId, this.provinceName});

  DistrictBO.fromJson(Map<String, dynamic> json) {
    districtId = json['district_id'];
    districtName = json['district_name'];
    provinceId = json['province_id'];
    provinceName = json['province_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['province_id'] = this.provinceId;
    data['province_name'] = this.provinceName;
    return data;
  }
}