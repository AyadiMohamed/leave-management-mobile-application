// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      id: json['id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      birthday: json['birthday'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      earnedBalance: (json['earnedBalance'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'roles': instance.roles,
      'birthday': instance.birthday,
      'phoneNumber': instance.phoneNumber,
      'earnedBalance': instance.earnedBalance,
    };
