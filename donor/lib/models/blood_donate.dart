class BloodDonation {
  String username;
  String name;
  String gender;
  String email;
  String phone;
  String weight;
  String bloodGroup;

  BloodDonation(
      {this.username,
      this.name,
      this.gender,
      this.email,
      this.phone,
      this.weight,
      this.bloodGroup});

  BloodDonation.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    name = json['name'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    weight = json['weight'];
    bloodGroup = json['blood_group'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['weight'] = this.weight;
    data['blood_group'] = this.bloodGroup;
    return data;
  }
}
