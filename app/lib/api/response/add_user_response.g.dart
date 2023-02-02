// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails()
  ..username = json['username'] as String
  ..name = json['name'] as String
  ..accountType = json['accountType'] as String
  ..profilePicLink = json['picture'] as String
  ..email = json['email'] as String
  ..age = json['age'] as int
  ..gender = json['gender'] as String
  ..languages =
      (json['languages'] as List<dynamic>).map((e) => e as String).toList()
  ..budget = json['budget'] as int
  ..locationPriorities = (json['location_priorities'] as List<dynamic>)
      .map((e) => Tag.fromJson(e as Map<String, dynamic>))
      .toList()
  ..roommatePriorities = (json['roommate_priorities'] as List<dynamic>)
      .map((e) => RoomieTagResponse.fromJson(e as Map<String, dynamic>))
      .toList()
  ..rejectedUsers =
      (json['rejected_users'] as List<dynamic>).map((e) => e as String).toList()
  ..listedFlats =
      (json['listed_flats'] as List<dynamic>).map((e) => e as String).toList()
  ..token = json['token'] as String;

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'username': instance.username,
      'name': instance.name,
      'accountType': instance.accountType,
      'picture': instance.profilePicLink,
      'email': instance.email,
      'age': instance.age,
      'gender': instance.gender,
      'languages': instance.languages,
      'budget': instance.budget,
      'location_priorities': instance.locationPriorities,
      'roommate_priorities': instance.roommatePriorities,
      'rejected_users': instance.rejectedUsers,
      'listed_flats': instance.listedFlats,
      'token': instance.token,
    };
