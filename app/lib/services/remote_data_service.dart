import 'package:google_sign_in/google_sign_in.dart';
import 'package:ten_ant/api/apiclient.dart';
import 'package:ten_ant/api/request/add_flat_request.dart';
import 'package:ten_ant/api/response/add_user_response.dart';
import 'package:ten_ant/api/response/get_group_response.dart';
import 'package:ten_ant/models/common.dart';
import 'package:ten_ant/utils/helpers.dart';
import 'package:dio/dio.dart';
class RemoteDataService {
  static Map<String, dynamic> headers = {};
  final dio = Dio();
  late TenantApi client;
  RemoteDataService(){
    client = TenantApi(dio);
  }
  loginUser(GoogleSignInAccount userDetes, String idToken) {
    Map<String, dynamic> userobj = <String, dynamic>{};
    userobj["uuid"] = UtilFuncs.getUUID();
    userobj["name"] = userDetes.displayName;
    userobj["identifier"] = userDetes.email;
    userobj["accountType"] = "google";
    userobj["profilePicLink"] = userDetes.photoUrl;
    return User.fromJson(userobj);
  }

  Future<UserDetails> getUserDetails(String uuid) async {
    final UserDetails resp = await client.getUserDetails(uuid);
    return resp;
  }

  Future<UserDetails> getUserFromUI(String uuid) async {
    final UserDetails resp = await client.getUserDetails(uuid);
    return resp;
  }

  Future<List<Flat>> getFlatFeed(String? uuid) async {
    final List<Flat> resp = await client.getFlatFeed(uuid);
    return resp;
  }

  Future<List<Group>> getUserGroups(String userid) async {
    final List<Group> resp = await client.getUserGroups(userid);
    return resp;
  }

  Future<void> submitUserFlatInteraction(String uuid, String uuid2) async {}

  Future<List<UserDetails>> getRoomieFeed(String uuid, User usertemp) async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return [
        UserDetails(),
        UserDetails(),
        UserDetails(),
      ];
    });
  }

  Future<List<Flat>> getMyFlats(String uuid) async {
    return Future.delayed(const Duration(milliseconds: 500), () {
      return [Flat(), Flat(), Flat()];
    });
  }

  Future<FlatStat> getFlatStats(String uuid) {
    return Future.delayed(
        const Duration(milliseconds: 500),
        () => FlatStat([10, 20, 5],
            ['Bad neighbourhood', 'High crime rates', 'Low price']));
  }

  addFlat(Flat currReq) {
    return client.postForm(currReq);
  }
}
