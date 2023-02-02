import 'package:json_annotation/json_annotation.dart';
import 'package:ten_ant/utils/constants.dart';
import 'package:ten_ant/utils/helpers.dart';

@JsonSerializable()
class User {
  String uuid;

  @JsonKey(name: "username")
  String username;

  @JsonKey(name: "name")
  String name;

  String identifier = 'w';

  String accountType = 'google';

  @JsonKey(name: "picture")
  String profilePicLink;

  @JsonKey(name: "email")
  String email = '';

  String token = '';

  bool authenticated = false;

  User(this.uuid, this.username, this.name, this.accountType,
      this.profilePicLink, this.email);
  Map<String, dynamic> toJson2() {
    return {
      "uuid": uuid,
      "name": name,
      "username": username,
      "email": email,
      "identifier": identifier,
      "accountType": accountType,
      "profilePicLink": profilePicLink,
    };
  }

  static User fromJson(Map<String, dynamic> obj) {
    String uuid = UtilFuncs.getUUID();

    User user = User(uuid, obj["username"], obj["name"], obj["accountType"],
        (obj["profilePicLink"] ?? Values.imagePlaceholder), obj["email"]);
    // user.email = obj["email"] ? obj["email"] : "None";
    return user;
  }
}

// @JsonSerializable()
// class UserDetails {

//   @JsonKey(name:"username")
//   String username = '';

//   @JsonKey(name:"name")
//   String name = '';

//   String identifier = 'w';

//   String accountType = 'google';

//   @JsonKey(name:"picture")
//   String profilePicLink = '';

//   @JsonKey(name:"email")
//   String email = '';

//   @JsonKey(name:"age")
//   String age = '';

//   @JsonKey(name:"gender")
//   String gender = '';

//   @JsonKey(name:"languages")
//   String languages = '';

//   @JsonKey(name:"budget")
//   String budget = '';

//   @JsonKey(name:"location_priorities")
//   List<String> locationPriorities = [];

//   @JsonKey(name:"roommate_priorities")
//   List<String> roommatePriorities = [];

//   @JsonKey(name:"rejected_users")
//   List<String> rejectedUsers = [];

//   @JsonKey(name:"listed_flats")
//   List<String> listedFlats = [];

//   String token = '';
// }

// class Group {
//   String uuid = '';
//   String name = '';
//   List<String> members = [];
//   Group(this.uuid, this.name, this.members);
// }

// class Flat {
//   String uuid = '';
//   String name = 'Vahra Residency';
//   List<String> photos = [
//     'https://i.imgur.com/vxP6SFl.png',
//     'https://i.imgur.com/vxP6SFl.png',
//     'https://i.imgur.com/vxP6SFl.png',
//     'https://i.imgur.com/vxP6SFl.png',
//     'https://i.imgur.com/vxP6SFl.png',
//     'https://i.imgur.com/vxP6SFl.png',
//     'https://i.imgur.com/vxP6SFl.png'
//   ];
//   String address =
//       '304, Vahra Residency, Road No. 31, Sri Balaji Nagar Colony, Manikonda, Puppalguda, Hyderabad - 500089';
//   String district = 'Panjagutta';
//   String description= 'good one';
//   String contact = 'No contact';

//   List<List<String>> likeDislikeQuestionArray = [
//     [UtilFuncs.getUUID(), UtilFuncs.getUUID(), UtilFuncs.getUUID()],
//     [UtilFuncs.getUUID(), UtilFuncs.getUUID()],
//     [UtilFuncs.getUUID()]
//   ];
//   Flat();

//   static User fromJson(Map<String, dynamic> obj) {
//     String uuid = UtilFuncs.getUUID();

//     User user = User(uuid, obj["username"], obj["name"],
//         obj["accountType"], (obj["profilePicLink"]!=null?obj["profilePicLink"]:Values.imagePlaceholder), obj["email"]);
//     // user.email = obj["email"] ? obj["email"] : "None";
//     return user;
//   }
// }

class FlatStat {
  List<int> statnums = [];
  List<String> reviews = [];
  FlatStat(this.statnums, this.reviews);
}
