import 'package:ten_ant/utils/helpers.dart';

class User {
  String uuid;
  String name;
  String identifier;
  String accountType = 'google';
  String profilePicLink;
  String email = '';
  String token = '';
  bool authenticated = false;
  User(this.uuid, this.name, this.identifier, this.accountType,
      this.profilePicLink);
  Map<String, dynamic> toJson() {
    return {
      "uuid": uuid,
      "name": name,
      "identifier": identifier,
      "accountType": accountType,
      "profilePicLink": profilePicLink,
    };
  }

  static User fromJson(Map<String, dynamic> obj) {
    User user = User(obj["uuid"], obj["name"], obj["identifier"],
        obj["accountType"], obj["profilePicLink"]);
    // user.email = obj["email"] ? obj["email"] : "None";
    return user;
  }
}

class UserDetails {}

class Group {
  String uuid = '';
  String name = '';
  List<String> members = [];
  Group(this.uuid, this.name, this.members);
}

class Flat {
  String uuid = '';
  String name = 'Vahra Residency';
  List<String> photos = [
    'https://i.imgur.com/vxP6SFl.png',
    'https://i.imgur.com/vxP6SFl.png',
    'https://i.imgur.com/vxP6SFl.png',
    'https://i.imgur.com/vxP6SFl.png',
    'https://i.imgur.com/vxP6SFl.png',
    'https://i.imgur.com/vxP6SFl.png',
    'https://i.imgur.com/vxP6SFl.png'
  ];
  String address =
      '304, Vahra Residency, Road No. 31, Sri Balaji Nagar Colony, Manikonda, Puppalguda, Hyderabad - 500089';
  String district = 'Panjagutta';
  List<List<String>> likeDislikeQuestionArray = [
    [UtilFuncs.getUUID(), UtilFuncs.getUUID(), UtilFuncs.getUUID()],
    [UtilFuncs.getUUID(), UtilFuncs.getUUID()],
    [UtilFuncs.getUUID()]
  ];
  Flat();
}
