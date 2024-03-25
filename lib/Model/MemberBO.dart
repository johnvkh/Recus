class MemberBO {
  String? memberId;
  String? fullname;
  String? msisdn;
  String? password;
  String? address;
  String? memberStatus;

  MemberBO(
      {this.memberId,
        this.fullname,
        this.msisdn,
        this.password,
        this.address,
        this.memberStatus});

  MemberBO.fromJson(Map<String, dynamic> json) {
    memberId = json['member_id'];
    fullname = json['fullname'];
    msisdn = json['msisdn'];
    password = json['password'];
    address = json['address'];
    memberStatus = json['member_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['member_id'] = this.memberId;
    data['fullname'] = this.fullname;
    data['msisdn'] = this.msisdn;
    data['password'] = this.password;
    data['address'] = this.address;
    data['member_status'] = this.memberStatus;
    return data;
  }
}