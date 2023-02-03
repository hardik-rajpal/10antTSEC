// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mini_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MiniUser _$MiniUserFromJson(Map<String, dynamic> json) => MiniUser()
  ..username = json['username'] as String
  ..id = json['id'] as String
  ..picture = json['picture'] as String;

Map<String, dynamic> _$MiniUserToJson(MiniUser instance) => <String, dynamic>{
      'username': instance.username,
      'id': instance.id,
      'picture': instance.picture,
    };
