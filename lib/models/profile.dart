class Profile {
  String email;
  String password;
  String fname;
  String lname;
  bool isNewUser;

  Profile(
      {this.email = '',
      this.password = '',
      this.fname = '',
      this.lname = '',
      this.isNewUser = true});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      email: json['email'],
      password: json['password'],
      fname: json['fname'],
      lname: json['lname'],
    );
  }
}
