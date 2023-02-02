// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_group_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group()
  ..id = json['id'] as String
  ..name = json['name'] as String
  ..city = json['city'] as String
  ..users = (json['users'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'city': instance.city,
      'users': instance.users,
    };
