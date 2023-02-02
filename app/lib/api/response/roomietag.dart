import 'package:json_annotation/json_annotation.dart';

part 'roomietag.g.dart';

@JsonSerializable()
class RoomieTag {
  String name = '';
  String id = '';
  List<String> options = [];
  RoomieTag();
  factory RoomieTag.fromJson(Map<String, dynamic> json) =>
      _$RoomieTagFromJson(json);
  Map<String, dynamic> toJson() => _$RoomieTagToJson(this);
}
