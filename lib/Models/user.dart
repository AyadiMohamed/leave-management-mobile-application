class User {
  String? id;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  List<String>? roles;
  String? birthday;
  String? phoneNumber;
  String? image;
  int? yearsOfExperience;
  String? notes;
  int? earnedBalance;
  int? sickBalance;
  Null? deletedAt;

  User(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.password,
      this.roles,
      this.birthday,
      this.phoneNumber,
      this.image,
      this.yearsOfExperience,
      this.notes,
      this.earnedBalance,
      this.sickBalance,
      this.deletedAt});
}
