import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ten_ant/cubits/user_auth.dart';

class ProfilePage extends StatefulWidget {
  final UserAuthCubit userCubit;
  const ProfilePage({super.key, required this.userCubit});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
