import 'dart:developer';

import 'package:localstorage/localstorage.dart';
import 'package:ten_ant/models/common.dart';
import 'package:ten_ant/services/remote_data_service.dart';

import '../api/request/add_flat_request.dart';

class LocalDataService {
  LocalStorage userdb = LocalStorage('coreader_users');
  LocalStorage activeBookDB = LocalStorage('coreader_activebook');
  LocalStorage booksDB = LocalStorage('coreader_books');
  LocalStorage glossaryDB = LocalStorage('coreader_glossary');
  LocalStorage noteDB = LocalStorage('coreader_note');
  LocalStorage deleteDB = LocalStorage('coreader_deletes');
  Future<User?> getAuthenticatedUser() async {
    await userdb.ready;
    String? useridtoken = userdb.getItem('useridtoken');

    log('useridtoken123:$useridtoken');
    if (useridtoken == null) {
      return null;
    }

    String uuid = (useridtoken.split('_')[0]);
    List<dynamic>? cachedUsers = userdb.getItem('users');
    if (cachedUsers == null) {
      await userdb.setItem('users', []);
      return null;
    }
    log('here1');
    List<dynamic> matches =
        cachedUsers.where((element) => element["uuid"] == uuid).toList();
    if (matches.isNotEmpty) {
      User user = User.fromJson(matches[0]);
      user.token = useridtoken;
      return user;
    } else {
      // log(matches.toString());
      // await userdb.deleteItem('useridtoken');
      // await userdb.deleteItem('users');
    }
    return null;
  }

  saveAuthenticatedUser(User user) async {
    await userdb.ready;
    await userdb.setItem('useridtoken', user.uuid);
    log('set useridtoken as: ${user.token}');
    List<dynamic>? cachedUsers = userdb.getItem('users');
    cachedUsers ??= [];
    user.token = '';
    if (!cachedUsers.contains(user.toJson2())) {
      cachedUsers.add(user.toJson2());
    }
    await userdb.setItem('users', cachedUsers);
    return null;
  }

  unauthenticateUser() async {
    await userdb.ready;
    await userdb.deleteItem('useridtoken');
  }

  Future<String?> getUserIDToken() async {
    await userdb.ready;
    return userdb.getItem('useridtoken');
  }
}
