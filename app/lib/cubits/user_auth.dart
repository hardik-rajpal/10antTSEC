import 'package:bloc/bloc.dart';
import 'package:ten_ant/models/common.dart';
import 'package:ten_ant/services/local_data_service.dart';
import 'package:ten_ant/services/remote_data_service.dart';

class UserAuthState {
  bool localChecked = false;
  User? user;
  UserAuthState(this.localChecked, this.user);
}

class UserAuthCubit extends Cubit<UserAuthState> {
  LocalDataService localDB = LocalDataService();
  RemoteDataService remoteDB = RemoteDataService();
  UserAuthCubit() : super(UserAuthState(false, null)) {
    getUserFromLocalDB();
  }
  getUserFromLocalDB() async {
    User? user = await localDB.getAuthenticatedUser();
    if (user != null) {
      RemoteDataService.headers["usertoken"] = user.token;
    }
    emit(UserAuthState(true, user));
  }

  setActiveUser(User user) async {
    await localDB.saveAuthenticatedUser(user);
    RemoteDataService.headers["usertoken"] = user.token;
    emit(UserAuthState(state.localChecked, user));
  }

  removeUser() async {
    await localDB.unauthenticateUser();
    emit(UserAuthState(state.localChecked, null));
  }

  // Future<UserDetails> getUserDetails() async {
  //implement local save and restore.
  // return await remoteDB.getUserDetails();
  // }
}
