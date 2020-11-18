class User {
  String firstname;
  String lastname;
  String username;
  String password;
  String emailHeader;

  User(
      {this.firstname,
      this.lastname,
      this.username,
      this.password,
      this.emailHeader});

  User.fromJson(Map<String, dynamic> json) {
    firstname = json['firstname'];
    lastname = json['lastname'];
    username = json['username'];
    password = json['password'];
    emailHeader = json['email_header'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['username'] = this.username;
    data['password'] = this.password;
    data['email_header'] = this.emailHeader;
    return data;
  }
}
