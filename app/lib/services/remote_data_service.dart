import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:ten_ant/api/apiclient.dart';
import 'package:ten_ant/api/request/add_flat_request.dart';
import 'package:ten_ant/api/request/flat_landlord.dart';
import 'package:ten_ant/api/response/add_user_response.dart';
import 'package:ten_ant/api/response/get_group_response.dart';
import 'package:ten_ant/api/response/tag.dart';
import 'package:ten_ant/models/common.dart';
import 'package:ten_ant/utils/helpers.dart';
import 'package:dio/dio.dart';

class RemoteDataService {
  static Map<String, dynamic> headers = {};
  final dio = Dio();
  late TenantApi client;
  RemoteDataService() {
    client = TenantApi(dio);
  }
  loginUser(GoogleSignInAccount userDetes, String idToken) {
    Map<String, dynamic> userobj = <String, dynamic>{};
    userobj["uuid"] = UtilFuncs.getUUID();
    userobj["name"] = userDetes.displayName;
    userobj["username"] = userDetes.email.split('@')[0];
    userobj["email"] = userDetes.email;
    userobj["identifier"] = userDetes.email;
    userobj["accountType"] = "google";
    userobj["profilePicLink"] = userDetes.photoUrl;
    return User.fromJson(userobj);
  }

  Future<UserDetails> getUserDetails(String uuid) async {
    log('uuid sent for details$uuid');
    final UserDetails resp = await client.getUserDetails(uuid);
    return resp;
  }

  Future<UserDetails> getUserFromUI(String uuid) async {
    final UserDetails resp = await client.getUserDetails(uuid);
    return resp;
  }

  Future<List<Flat>> getFlatFeed(String gid, String uuid) async {
    log('$gid, and $uuid');
    final List<Flat> resp = await client.getFlatFeed(gid, uuid);
    return resp;
  }

  Future<List<Group>> getUserGroups(String userid) async {
    final List<Group> resp = await client.getUserGroups(userid);
    return resp;
  }

  Future<void> submitUserFlatInteraction(String uuid, String uuid2) async {}

  Future<List<UserDetails>> getRoomieFeed(String uuid) async {
    final List<UserDetails> resp = await client.getRoomieFeed(uuid);
    return resp;
  }

  Future<List<FlatLandlord>> getMyFlats(String id) async {
    final List<FlatLandlord> resp = await client.getMyFlats(id);
    return resp;
  }

  Future<FlatStat> getFlatStats(String uuid) {
    return Future.delayed(
        const Duration(milliseconds: 500),
        () => FlatStat([10, 20, 5],
            ['Bad neighbourhood', 'High crime rates', 'Low price']));
  }

  Future<bool> addFlat(Flat currReq) async {
    final resp = await client.postForm(currReq);
    return resp;
  }

  registerUser(UserDetails details) async {
    return client.addUserToDB(details);
  }

  Future getLocationTags() async {
    try {
      return client.getLocationTags();
    } catch (e) {
      Tag t = Tag();
      t.id = "asdf";
      t.name = "asdf";
      return Future.delayed(const Duration(milliseconds: 500), () => [t, t, t]);
    }
  }

  getRoommateTags() {
    return client.getRoomieTags();
  }
}
