import 'package:json_annotation/json_annotation.dart';
import 'package:ten_ant/api/response/roomietag_response.dart';
import 'package:ten_ant/api/response/tag.dart';

part 'add_user_response.g.dart';

@JsonSerializable()
class UserDetails {
  @JsonKey(name: "username")
  String username = '';

  @JsonKey(name: "name")
  String name = '';

  String accountType = 'google';

  @JsonKey(name: "picture")
  String profilePicLink = '';

  @JsonKey(name: "email")
  String email = '';

  @JsonKey(name: "age")
  int age = 0;

  @JsonKey(name: "gender")
  String gender = '';

  @JsonKey(name: "languages")
  List<String> languages = [];

  @JsonKey(name: "budget")
  int budget = 1000;

  @JsonKey(name: "location_priorities")
  List<Tag> locationPriorities = [];

  @JsonKey(name: "roommate_priorities")
  List<RoomieTagResponse> roommatePriorities = [];

  @JsonKey(name: "rejected_users")
  List<String> rejectedUsers = [];

  @JsonKey(name: "listed_flats")
  List<String> listedFlats = [];

  String token = '';

  UserDetails();
  factory UserDetails.fromJson(Map<String, dynamic> json) =>
      _$UserDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}
