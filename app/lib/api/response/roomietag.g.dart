// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'roomietag.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomieTag _$RoomieTagFromJson(Map<String, dynamic> json) => RoomieTag()
  ..name = json['name'] as String
  ..id = json['id'] as String
  ..options =
      (json['options'] as List<dynamic>).map((e) => e as String).toList();

Map<String, dynamic> _$RoomieTagToJson(RoomieTag instance) => <String, dynamic>{
      'name': instance.name,
      'id': instance.id,
      'options': instance.options,
    };
