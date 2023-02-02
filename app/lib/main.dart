import 'package:flutter/material.dart';
import 'package:ten_ant/cubits/user_auth.dart';
import 'package:ten_ant/pages/flatfeed_page.dart';
import 'package:ten_ant/pages/login_page.dart';
import 'package:ten_ant/utils/constants.dart';

void main() {
  final UserAuthCubit userCubit = UserAuthCubit();
  runApp(MaterialApp(initialRoute: MainDrawer.auth, routes: {
    MainDrawer.auth: (context) => LoginPage(userCubit: userCubit),
    MainDrawer.flatfeed: (context) => FlatFeedPage(userCubit: userCubit),
  }));
}
