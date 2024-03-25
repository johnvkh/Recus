class AccidentComplaintBO {
  String? accidentComplainId;
  String? accidentComplainTitle;
  String? complainDate;
  String? memberId;
  String? fullname;
  String? description;
  String? centerId;
  String? firstImgPath;
  String? secondImgPath;
  String? complainStatus;
  String? longitude;
  String? latitude;
  String? accidentTypeId;
  String? modifiedCode;
  String? modifiedName;
  String? modifiedDate;
  String? thirdPhone;
  String? centerName;
  String? accidentTypeName;

  AccidentComplaintBO(
      {this.accidentComplainId,
        this.accidentComplainTitle,
        this.complainDate,
        this.memberId,
        this.fullname,
        this.description,
        this.centerId,
        this.firstImgPath,
        this.secondImgPath,
        this.complainStatus,
        this.longitude,
        this.latitude,
        this.accidentTypeId,
        this.modifiedCode,
        this.modifiedName,
        this.modifiedDate,
        this.thirdPhone,
        this.centerName,
        this.accidentTypeName});

  AccidentComplaintBO.fromJson(Map<String, dynamic> json) {
    accidentComplainId = json['accident_complain_id'];
    accidentComplainTitle = json['accident_complain_title'];
    complainDate = json['complain_date'];
    memberId = json['member_id'];
    fullname = json['fullname'];
    description = json['description'];
    centerId = json['center_id'];
    firstImgPath = json['first_img_path'];
    secondImgPath = json['second_img_path'];
    complainStatus = json['complain_status'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    accidentTypeId = json['accident_type_id'];
    modifiedCode = json['modified_code'];
    modifiedName = json['modified_name'];
    modifiedDate = json['modified_date'];
    thirdPhone = json['third_phone'];
    centerName = json['center_name'];
    accidentTypeName = json['accident_type_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accident_complain_id'] = this.accidentComplainId;
    data['accident_complain_title'] = this.accidentComplainTitle;
    data['complain_date'] = this.complainDate;
    data['member_id'] = this.memberId;
    data['fullname'] = this.fullname;
    data['description'] = this.description;
    data['center_id'] = this.centerId;
    data['first_img_path'] = this.firstImgPath;
    data['second_img_path'] = this.secondImgPath;
    data['complain_status'] = this.complainStatus;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['accident_type_id'] = this.accidentTypeId;
    data['modified_code'] = this.modifiedCode;
    data['modified_name'] = this.modifiedName;
    data['modified_date'] = this.modifiedDate;
    data['third_phone'] = this.thirdPhone;
    data['center_name'] = this.centerName;
    data['accident_type_name'] = this.accidentTypeName;
    return data;
  }
}