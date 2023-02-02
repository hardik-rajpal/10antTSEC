import 'package:flutter/material.dart';
import 'package:ten_ant/cubits/user_auth.dart';

class RoomieFeedPage extends StatefulWidget {
  final UserAuthCubit userCubit;
  const RoomieFeedPage({super.key, required this.userCubit});

  @override
  State<RoomieFeedPage> createState() => _RoomieFeedPageState();
}

class _RoomieFeedPageState extends State<RoomieFeedPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Swipe component goes here'),
    );
  }
}
