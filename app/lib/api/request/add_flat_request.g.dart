// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_flat_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Flat _$FlatFromJson(Map<String, dynamic> json) => Flat()
  ..id = json['id'] as String
  ..location = json['location'] as String
  ..pictures =
      (json['pictures'] as List<dynamic>).map((e) => e as String).toList()
  ..district = json['district'] as String
  ..contact = json['contact'] as String
  ..description = json['description'] as String
  ..street = json['street_address'] as String
  ..bhk = json['bhk'] as int
  ..rent = json['rent'] as int
  ..area = json['area'] as int
  ..toilets = json['toilets'] as int
  ..amenities =
      (json['amenities_5km'] as List<dynamic>).map((e) => e as String).toList()
  ..features = (json['tags'] as List<dynamic>).map((e) => e as String).toList()
  ..likeArray = (json['accepts'] as List<dynamic>)
      .map((e) => MiniUser.fromJson(e as Map<String, dynamic>))
      .toList()
  ..dislikeArray = (json['rejects'] as List<dynamic>)
      .map((e) => MiniUser.fromJson(e as Map<String, dynamic>))
      .toList()
  ..my_review = json['my_review'] as int
  ..feedback = json['feedback'] as String
  ..no_opinion = (json['no_opinion'] as List<dynamic>)
      .map((e) => MiniUser.fromJson(e as Map<String, dynamic>))
      .toList()
  ..forum = (json['forum'] as List<dynamic>)
      .map((e) => ForumMsg.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$FlatToJson(Flat instance) => <String, dynamic>{
      'id': instance.id,
      'location': instance.location,
      'pictures': instance.pictures,
      'district': instance.district,
      'contact': instance.contact,
      'description': instance.description,
      'street_address': instance.street,
      'bhk': instance.bhk,
      'rent': instance.rent,
      'area': instance.area,
      'toilets': instance.toilets,
      'amenities_5km': instance.amenities,
      'tags': instance.features,
      'accepts': instance.likeArray,
      'rejects': instance.dislikeArray,
      'my_review': instance.my_review,
      'feedback': instance.feedback,
      'no_opinion': instance.no_opinion,
      'forum': instance.forum,
    };
