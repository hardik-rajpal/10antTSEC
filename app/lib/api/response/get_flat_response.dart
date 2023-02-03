import 'package:json_annotation/json_annotation.dart';

part 'get_flat_response.g.dart';

@JsonSerializable()
class FlatResponse {
  @JsonKey(name: "id")
  String id = '';

  @JsonKey(name: "location")
  String location = '';

  @JsonKey(name: "pictures")
  List<String> pictures = [];

  @JsonKey(name: "district")
  String district = '';

  @JsonKey(name: "contact")
  String contact = '';

  @JsonKey(name: "description")
  String description = '';

  @JsonKey(name: "street_address")
  String street = '';

  @JsonKey(name: "bhk")
  int bhk = 0;

  @JsonKey(name: "rent")
  int rent = 0;

  @JsonKey(name: "area")
  int area = 0;

  @JsonKey(name: "toilets")
  int toilets = 0;

  @JsonKey(name: "amenities_5km")
  List<String> amenities = [];

  @JsonKey(name: "tags")
  List<String> features = [];

  List<String> likeArray = [];
  List<String> dislikeArray = [];

  FlatResponse();
  factory FlatResponse.fromJson(Map<String, dynamic> json) =>
      _$FlatResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FlatResponseToJson(this);
}
