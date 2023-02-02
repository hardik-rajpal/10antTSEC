import 'package:json_annotation/json_annotation.dart';

part 'get_group_response.g.dart';

@JsonSerializable()
class Group {
  @JsonKey(name: "id")
  String id = '';
  @JsonKey(name: "name")
  String name = '';
  @JsonKey(name: "city")
  String city = '';
  @JsonKey(name: "users")
  List<String> users = [];
  Group();

  factory Group.fromJson(Map<String, dynamic> json) =>
      _$GroupFromJson(json);
  Map<String, dynamic> toJson() => _$GroupToJson(this);
}