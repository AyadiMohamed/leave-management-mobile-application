
import 'package:json_annotation/json_annotation.dart';

import '../entity/user_entity.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {

  @JsonKey(name : 'collaborator')
   UserEntity? userEntity; 

  @JsonKey(name : 'access_token')
   String? accessToken;

  LoginResponse({this.userEntity, this.accessToken});


  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);

}