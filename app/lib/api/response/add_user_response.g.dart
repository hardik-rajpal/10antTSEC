// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) => UserDetails()
  ..id = json['id'] as String?
  ..username = json['username'] as String
  ..name = json['name'] as String
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
      .toList();

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'name': instance.name,
      'picture': instance.profilePicLink,
      'email': instance.email,
      'age': instance.age,
      'gender': instance.gender,
      'languages': instance.languages,
      'budget': instance.budget,
      'location_priorities': instance.locationPriorities,
      'roommate_priorities': instance.roommatePriorities,
    };
