// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_msg.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForumMsg _$ForumMsgFromJson(Map<String, dynamic> json) => ForumMsg()
  ..sender = json['sender'] as String
  ..message = json['message'] as String
  ..timestamp = json['timestamp'] as int;

Map<String, dynamic> _$ForumMsgToJson(ForumMsg instance) => <String, dynamic>{
      'sender': instance.sender,
      'message': instance.message,
      'timestamp': instance.timestamp,
    };
