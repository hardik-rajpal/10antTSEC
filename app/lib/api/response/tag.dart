import 'package:json_annotation/json_annotation.dart';

part 'tag.g.dart';

@JsonSerializable()
class Tag {
  String name = '';
  String id = '';
  Tag();
  factory Tag.fromJson(Map<String, dynamic> json) {
    if (!json.keys.contains('name')) {
      json['name'] = 'undef';
    }
    return _$TagFromJson(json);
  }
  Map<String, dynamic> toJson() {
    Map<String, dynamic> ans = _$TagToJson(this);
    ans.remove('name');
    return ans;
  }
}
