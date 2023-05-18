// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponse _$LoginResponseFromJson(Map<String, dynamic> json) =>
    LoginResponse(
      userEntity: json['collaborator'] == null
          ? null
          : UserEntity.fromJson(json['collaborator'] as Map<String, dynamic>),
      accessToken: json['access_token'] as String?,
    );

Map<String, dynamic> _$LoginResponseToJson(LoginResponse instance) =>
    <String, dynamic>{
      'collaborator': instance.userEntity,
      'access_token': instance.accessToken,
    };
