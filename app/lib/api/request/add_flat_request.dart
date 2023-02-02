import 'package:json_annotation/json_annotation.dart';

part 'add_flat_request.g.dart';

@JsonSerializable()
class AddFlatRequest {
  @JsonKey(name: "location")
  String? location;

  @JsonKey(name: "district")
  String? district;

  @JsonKey(name: "contact")
  String? contact;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "street_address")
  String? street;

  @JsonKey(name: "bhk")
  int? bhk;

  @JsonKey(name: "rent")
  int? rent;

  @JsonKey(name: "area")
  int? area;

  @JsonKey(name: "toilets")
  int? toilets;

  @JsonKey(name: "amenities")
  List<String>? amenities;

  @JsonKey(name: "tags")
  List<String>? features;


  AddFlatRequest();
  factory AddFlatRequest.fromJson(Map<String, dynamic> json) =>
      _$AddFlatRequestFromJson(json);
  Map<String, dynamic> toJson() => _$AddFlatRequestToJson(this);
}
