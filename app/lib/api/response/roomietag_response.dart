import 'package:json_annotation/json_annotation.dart';

part 'roomietag_response.g.dart';

@JsonSerializable()
class RoomieTagResponse {
  String option = '';
  int category = 0;
  RoomieTagResponse();
  factory RoomieTagResponse.fromJson(Map<String, dynamic> json) =>
      _$RoomieTagResponseFromJson(json);
  Map<String, dynamic> toJson() => _$RoomieTagResponseToJson(this);
}
