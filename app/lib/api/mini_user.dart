import 'package:json_annotation/json_annotation.dart';
import 'package:ten_ant/utils/constants.dart';

part 'mini_user.g.dart';

@JsonSerializable()
class MiniUser {
  String username = '';
  String id = '';
  String picture = Values.imagePlaceholder;
  MiniUser();
  factory MiniUser.fromJson(Map<String, dynamic> json) =>
      _$MiniUserFromJson(json);
  Map<String, dynamic> toJson() => _$MiniUserToJson(this);
}
