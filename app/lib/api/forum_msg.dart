import 'package:json_annotation/json_annotation.dart';

part 'forum_msg.g.dart';

@JsonSerializable()
class ForumMsg {
  String sender = '';
  String message = '';
  int timestamp = 0;
  ForumMsg();
  factory ForumMsg.fromJson(Map<String, dynamic> json) =>
      _$ForumMsgFromJson(json);
  Map<String, dynamic> toJson() => _$ForumMsgToJson(this);
}
