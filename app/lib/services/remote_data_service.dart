import 'package:google_sign_in/google_sign_in.dart';
import 'package:ten_ant/models/common.dart';
import 'package:ten_ant/utils/helpers.dart';

class RemoteDataService {
  static Map<String, dynamic> headers = {};
  loginUser(GoogleSignInAccount userDetes, String idToken) {
    Map<String, dynamic> userobj = <String, dynamic>{};
    userobj["uuid"] = UtilFuncs.getUUID();
    userobj["name"] = userDetes.displayName;
    userobj["identifier"] = userDetes.email;
    userobj["accountType"] = "google";
    userobj["profilePicLink"] = userDetes.photoUrl;
    return User.fromJson(userobj);
  }

  Future<UserDetails> getUserDetails(String userid, User user) async {
    return UserDetails(user);
  }

  Future<List<Flat>> getFlatFeed(String? uuid) async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return [Flat(), Flat(), Flat()];
    });
  }

  Future<List<Group>> getUserGroups(String userid) {
    return Future.delayed(
        const Duration(milliseconds: 500),
        () => [
              Group(UtilFuncs.getUUID(), 'Me', ['...']),
              Group(UtilFuncs.getUUID(), 'Warriors', ['...', '...']),
              Group(UtilFuncs.getUUID(), 'SoBo boys', ['...', '...'])
            ]);
  }

  Future<void> submitUserFlatInteraction(String uuid, String uuid2) async {}

  Future<List<UserDetails>> getRoomieFeed(String uuid, User usertemp) async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return [
        UserDetails(usertemp),
        UserDetails(usertemp),
        UserDetails(usertemp),
      ];
    });
  }

  Future<List<Flat>> getMyFlats(String uuid) async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return [Flat(), Flat(), Flat()];
    });
  }
}
