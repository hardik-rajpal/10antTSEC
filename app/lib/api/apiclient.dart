import 'dart:async';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' as rt;
import 'package:ten_ant/api/request/add_flat_request.dart';
import 'package:ten_ant/api/response/add_user_response.dart';
import 'package:ten_ant/api/response/get_group_response.dart';
import 'package:ten_ant/api/response/roomietag.dart';
import 'package:ten_ant/api/response/tag.dart';

part 'apiclient.g.dart';

@rt.RestApi(baseUrl: "http://2e70-103-246-224-250.ngrok.io")
abstract class TenantApi {
  factory TenantApi(Dio dio, {String baseUrl}) = _TenantApi;

  @rt.POST("/addFlat")
  Future<bool> postForm(@rt.Body() Flat req);

  @rt.GET("/getUser")
  Future<UserDetails> getUserDetails(@rt.Query("id") String userid);

  @rt.GET("/getGroupsForUsers")
  Future<List<Group>> getUserGroups(@rt.Query("id") String userid);

  @rt.GET("/getFlats")
  Future<List<Flat>> getFlatFeed(
      @rt.Query("gid") String gid, @rt.Query("id") String id);

  @rt.GET("/getflatslisted")
  Future<List<Flat>> getMyFlats(@rt.Query("id") String id);

  @rt.POST('/saveUser')
  Future<UserDetails> addUserToDB(@rt.Body() UserDetails details);

  @rt.GET('/locationPriorities')
  Future<List<Tag>> getLocationTags();
  @rt.GET('/roommatePriorities')
  Future<List<RoomieTag>> getRoomieTags();

  // @rt.GET("/getflatfeed")
  // Future<void> submitUserFlatInteraction(@rt.Body() String uuid, @rt.Body() String uuid2) {}
}
