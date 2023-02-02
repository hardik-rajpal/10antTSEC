import 'dart:async';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' as rt;
import 'package:ten_ant/api/request/add_flat_request.dart';

part 'apiclient.g.dart';

@rt.RestApi(baseUrl: "https://kl.com")
abstract class TenantApi {
  factory TenantApi(Dio dio, {String baseUrl}) = _TenantApi;

  @rt.POST("/addflat")
  Future<bool> postForm(
      @rt.Body() AddFlatRequest achievementCreateRequest);
}
