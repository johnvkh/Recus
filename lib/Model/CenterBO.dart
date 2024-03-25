class CenterBO {
  String? centerId;
  String? centerName;
  String? tel;
  String? centerStatus;
  String? village;
  String? districtId;
  String? districtName;
  String? provinceId;
  String? provinceName;
  String? longitude;
  String? latitude;

  CenterBO(
      {
        this.centerId,
        this.centerName,
        this.tel,
        this.centerStatus,
        this.village,
        this.districtId,
        this.districtName,
        this.provinceId,
        this.provinceName,
        this.longitude,
        this.latitude}
      );

  CenterBO.fromJson(Map<String, dynamic> json) {
    centerId = json['center_id'];
    centerName = json['center_name'];
    tel = json['tel'];
    centerStatus = json['center_status'];
    village = json['village'];
    districtId = json['district_id'];
    districtName = json['district_name'];
    provinceId = json['province_id'];
    provinceName = json['province_name'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['center_id'] = this.centerId;
    data['center_name'] = this.centerName;
    data['tel'] = this.tel;
    data['center_status'] = this.centerStatus;
    data['village'] = this.village;
    data['district_id'] = this.districtId;
    data['district_name'] = this.districtName;
    data['province_id'] = this.provinceId;
    data['province_name'] = this.provinceName;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    return data;
  }
}