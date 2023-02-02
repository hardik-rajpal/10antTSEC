import 'package:flutter/material.dart';
import 'package:ten_ant/api/response/add_user_response.dart';
import 'package:ten_ant/components/images.dart';
import 'package:ten_ant/utils/constants.dart';

class UserViewCard extends StatefulWidget {
  final UserDetails details;
  const UserViewCard({super.key, required this.details});

  @override
  State<UserViewCard> createState() => _UserViewCardState();
}

class _UserViewCardState extends State<UserViewCard> {
  late UserDetails details;
  @override
  void initState() {
    details = widget.details;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              details.name,
              style: Styles.textStyle1,
            ),
            Image(
              width: 200,
              height: 200,
              image: getCachedNetworkImage(details.profilePicLink),
            ),
          ],
        ),
      ),
    );
  }
}
