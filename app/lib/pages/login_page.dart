import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ten_ant/cubits/user_auth.dart';
import 'package:ten_ant/models/common.dart';
import 'package:ten_ant/services/remote_data_service.dart';
import 'package:ten_ant/utils/constants.dart';
import 'package:ten_ant/utils/helpers.dart';

class LoginPage extends StatefulWidget {
  final UserAuthCubit userCubit;
  const LoginPage({Key? key, required this.userCubit}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late UserAuthState authState = widget.userCubit.state;
  @override
  void initState() {
    widget.userCubit.stream.listen((event) {
      setState(() {
        authState = event;
        if (event.user != null) {
          // String? userid = event.user?.uuid;
          Navigator.of(context).pushReplacementNamed(MainDrawer.roomiefeed);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            signInWithGoogle(widget.userCubit);
          },
          child: const Text('Sign in with Google'),
        ),
      ),
    );
  }

  Future signInWithGoogle(UserAuthCubit userCubit) async {
    final GoogleSignInAccount? user = await GoogleSignInApi.login();
    if (user != null) {
      GoogleSignInAuthentication auth = await (user.authentication);
      User userObj =
          await RemoteDataService().loginUser(user, auth.idToken.toString());
      userCubit.setActiveUser(userObj);
    }
    return 0;
  }
}
