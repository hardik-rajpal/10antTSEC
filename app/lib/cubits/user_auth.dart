import 'package:bloc/bloc.dart';
import 'package:ten_ant/models/common.dart';
import 'package:ten_ant/services/local_data_service.dart';
import 'package:ten_ant/services/remote_data_service.dart';

class UserAuthState {
  bool localChecked = false;
  User? user;
  bool isTenantMode = true;
  UserAuthState(this.localChecked, this.user, this.isTenantMode);
}

class UserAuthCubit extends Cubit<UserAuthState> {
  LocalDataService localDB = LocalDataService();
  RemoteDataService remoteDB = RemoteDataService();
  String userid = '';
  UserAuthCubit() : super(UserAuthState(false, null, true)) {
    getUserFromLocalDB();
  }
  getUserFromLocalDB() async {
    User? user = await localDB.getAuthenticatedUser();
    if (user != null) {
      RemoteDataService.headers["usertoken"] = user.token;
    }
    emit(UserAuthState(true, user, true));
  }

  setActiveUser(User user) async {
    // await localDB.saveAuthenticatedUser(user);
    RemoteDataService.headers["usertoken"] = user.token;
    emit(UserAuthState(state.localChecked, user, state.isTenantMode));
  }

  removeUser() async {
    await localDB.unauthenticateUser();
    emit(UserAuthState(state.localChecked, null, state.isTenantMode));
  }

  invertTenantMode() async {
    emit(UserAuthState(state.localChecked, state.user, !state.isTenantMode));
  }
  // Future<UserDetails> getUserDetails() async {
  //implement local save and restore.
  // return await remoteDB.getUserDetails();
  // }
}
