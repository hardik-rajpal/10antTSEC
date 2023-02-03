import 'dart:async';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' as rt;
import 'package:ten_ant/api/request/add_flat_request.dart';
import 'package:ten_ant/api/request/flat_landlord.dart';
import 'package:ten_ant/api/response/add_user_response.dart';
import 'package:ten_ant/api/response/get_group_response.dart';
import 'package:ten_ant/api/response/roomietag.dart';
import 'package:ten_ant/api/response/tag.dart';

part 'apiclient.g.dart';

@rt.RestApi(baseUrl: "http://bd29-103-246-224-250.ngrok.io")
abstract class TenantApi {
  factory TenantApi(Dio dio, {String baseUrl}) = _TenantApi;

  @rt.POST("/addFlat")
  Future<bool> postForm(@rt.Body() Flat req);
  //TODO: backend
  @rt.GET("/getUser")
  Future<UserDetails> getUserDetails(@rt.Query("id") String userid);

  @rt.GET("/getGroupsForUsers")
  Future<List<Group>> getUserGroups(@rt.Query("id") String userid);

  @rt.GET("/getFlats")
  Future<List<Flat>> getFlatFeed(
      @rt.Query("gid") String gid, @rt.Query("id") String id);

  @rt.GET("/getflatslisted")
  Future<List<FlatLandlord>> getMyFlats(@rt.Query("id") String id);

  @rt.POST('/saveUser')
  Future<UserDetails> addUserToDB(@rt.Body() UserDetails details);

  @rt.GET('/locationPriorities')
  Future<List<Tag>> getLocationTags();
  @rt.GET('/roommatePriorities')
  Future<List<RoomieTag>> getRoomieTags();

  @rt.GET('/getRoommateSuggestions')
  Future<List<UserDetails>> getRoomieFeed(@rt.Query("id") String uuid);

  @rt.POST('/registerFeedback')
  Future<void> registerFeedback(
      @rt.Query("user_id") String user_id,
      @rt.Query("flat_id") String flat_id,
      @rt.Query("feedback") String feedback,
      @rt.Query("score") int score);

  @rt.POST('/roomieFeedback')
  Future<void> roomieFeedback(@rt.Query("id") String id,
      @rt.Query("tid") String tid, @rt.Query("score") int score);

  @rt.POST('/postMessage')
  Future<void> postMessage(
      @rt.Query("flat") String flat,
      @rt.Query("group") String group,
      @rt.Query("message") String message,
      @rt.Query("sender") String sender);

  // @rt.GET("/getflatfeed")
  // Future<void> submitUserFlatInteraction(@rt.Body() String uuid, @rt.Body() String uuid2) {}
}
