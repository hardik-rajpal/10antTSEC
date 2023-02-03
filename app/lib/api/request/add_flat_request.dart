import 'package:json_annotation/json_annotation.dart';
import 'package:ten_ant/api/forum_msg.dart';
import 'package:ten_ant/api/mini_user.dart';

part 'add_flat_request.g.dart';

@JsonSerializable()
class Flat {
  @JsonKey(name: "id")
  String id = 'a';

  @JsonKey(name: "location")
  String location = 'a';

  @JsonKey(name: "pictures")
  List<String> pictures = [
    'https://www.google.com/imgres?imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fe%2Fee%2FChain_link_icon.png&imgrefurl=https%3A%2F%2Fsimple.wikipedia.org%2Fwiki%2FLink&tbnid=mj2OmSHS0LnkzM&vet=12ahUKEwi979PW6vf8AhXz5nMBHd0mC5AQMygAegUIARDhAQ..i&docid=Zr3_2orswxTRnM&w=950&h=400&q=image%20link&ved=2ahUKEwi979PW6vf8AhXz5nMBHd0mC5AQMygAegUIARDhAQ'
  ];

  @JsonKey(name: "district")
  String district = 'a';

  @JsonKey(name: "contact")
  String contact = 'a';

  @JsonKey(name: "description")
  String description = 'a';

  @JsonKey(name: "street_address")
  String street = 'a';

  @JsonKey(name: "bhk")
  int bhk = 0;

  @JsonKey(name: "rent")
  int rent = 0;

  @JsonKey(name: "area")
  int area = 0;

  @JsonKey(name: "toilets")
  int toilets = 0;

  @JsonKey(name: "amenities_5km")
  List<String> amenities = ['a'];

  @JsonKey(name: "tags")
  List<String> features = [];
  @JsonKey(name: 'accepts')
  List<MiniUser> likeArray = [];
  @JsonKey(name: 'rejects')
  List<MiniUser> dislikeArray = [];

  int my_review = 0;
  String feedback = '';
  List<MiniUser> no_opinion = [];
  List<ForumMsg> forum = [];
  Flat();
  factory Flat.fromJson(Map<String, dynamic> json) => _$FlatFromJson(json);
  Map<String, dynamic> toJson() => _$FlatToJson(this);
}

//forum:
//list of {message: '', sender: 'UserNAme', timestamp:0}