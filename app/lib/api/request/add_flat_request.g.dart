// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_flat_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddFlatRequest _$AddFlatRequestFromJson(Map<String, dynamic> json) =>
    AddFlatRequest()
      ..location = json['location'] as String?
      ..district = json['district'] as String?
      ..contact = json['contact'] as String?
      ..description = json['description'] as String?
      ..street = json['street_address'] as String?
      ..bhk = json['bhk'] as int?
      ..rent = json['rent'] as int?
      ..area = json['area'] as int?
      ..toilets = json['toilets'] as int?
      ..amenities = (json['amenities'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList()
      ..features =
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList();

Map<String, dynamic> _$AddFlatRequestToJson(AddFlatRequest instance) =>
    <String, dynamic>{
      'location': instance.location,
      'district': instance.district,
      'contact': instance.contact,
      'description': instance.description,
      'street_address': instance.street,
      'bhk': instance.bhk,
      'rent': instance.rent,
      'area': instance.area,
      'toilets': instance.toilets,
      'amenities': instance.amenities,
      'tags': instance.features,
    };
