import 'package:flutter/material.dart';
import 'package:ten_ant/components/drawer.dart';
import 'package:ten_ant/components/user_view_card.dart';
import 'package:ten_ant/cubits/user_auth.dart';
import 'package:ten_ant/models/common.dart';
import 'package:ten_ant/services/remote_data_service.dart';

class ProfilePage extends StatefulWidget {
  final UserAuthCubit userCubit;
  const ProfilePage({super.key, required this.userCubit});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool detailsLoaded = false;
  late UserDetails details;
  @override
  void initState() {
    RemoteDataService()
        .getUserDetails(
            widget.userCubit.state.user!.uuid, widget.userCubit.state.user!)
        .then((value) {
      setState(() {
        details = value;
        detailsLoaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      drawer: MainDrawerWidget(userCubit: widget.userCubit),
      body: (detailsLoaded)
          ? UserViewCard(details: details)
          : const CircularProgressIndicator(),
    );
  }
}
