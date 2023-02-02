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

  getUserDetails() {}
}
