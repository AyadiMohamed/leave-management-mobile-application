

import 'package:json_annotation/json_annotation.dart';


part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  @JsonKey(name : 'id')
  String? id;
  @JsonKey(name : 'firstName')
  String? firstName;
  @JsonKey(name : 'lastName')
  String? lastName;
  @JsonKey(name : 'email')
  String? email;
  @JsonKey(name : 'roles')
  List<String>? roles;
  @JsonKey(name : 'birthday')
  String? birthday;
  @JsonKey(name : 'phoneNumber')
  String? phoneNumber;
  @JsonKey(name : 'earnedBalance')
  double? earnedBalance;
  //  @JsonKey(name : 'sickBalance')
  // int? sickBalance;



  UserEntity(
      {this.id,
      this.firstName,
      this.lastName,
      this.email,
      this.roles,
      this.birthday,
      this.phoneNumber,
      this.earnedBalance,
      });

      factory UserEntity.fromJson(Map<String, dynamic> json) =>
      _$UserEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserEntityToJson(this);
}

