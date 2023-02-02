import 'dart:async';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' as rt;
import 'package:ten_ant/api/request/add_flat_request.dart';
import 'package:ten_ant/api/response/add_user_response.dart';
import 'package:ten_ant/api/response/get_group_response.dart';

part 'apiclient.g.dart';

@rt.RestApi(baseUrl: "https://kl.com")
abstract class TenantApi {
  factory TenantApi(Dio dio, {String baseUrl}) = _TenantApi;

  @rt.POST("/addflat")
  Future<bool> postForm(@rt.Body() Flat req);

  @rt.GET("/getUser")
  Future<UserDetails> getUserDetails(@rt.Body() String userid);

  @rt.GET("/getusergroups")
  Future<List<Group>> getUserGroups(@rt.Body() String userid);

  @rt.GET("/getflatfeed")
  Future<List<Flat>> getFlatFeed(@rt.Body() String? uuid);

  @rt.POST('/saveUser')
  Future<UserDetails> addUserToDB(@rt.Body() UserDetails details);
  // @rt.GET("/getflatfeed")
  // Future<void> submitUserFlatInteraction(@rt.Body() String uuid, @rt.Body() String uuid2) {}
}
