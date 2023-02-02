import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ten_ant/cubits/user_auth.dart';
import 'package:ten_ant/models/common.dart';
import 'package:ten_ant/utils/helpers.dart';

class FlatFeedPage extends StatefulWidget {
  final UserAuthCubit userCubit;
  const FlatFeedPage({super.key, required this.userCubit});

  @override
  State<FlatFeedPage> createState() => _FlatFeedPageState();
}

class _FlatFeedPageState extends State<FlatFeedPage> {
  int groupID = 0;
  List<Group> groups = [
    Group(UtilFuncs.getUUID(), 'Me', ['...']),
    Group(UtilFuncs.getUUID(), 'Warriors', ['...', '...']),
    Group(UtilFuncs.getUUID(), 'SoBo boys', ['...', '...']),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flat Feed'),
      ),
      body: Column(children: [
        Row(
          children: [
            const Text('Mode: '),
            DropdownButton<String>(
                value: groups[0].name,
                icon: const FaIcon(FontAwesomeIcons.arrowDown),
                items: groups
                    .map((e) => DropdownMenuItem<String>(child: Text(e.name)))
                    .toList(),
                onChanged: (choice) {})
          ],
        )
      ]),
    );
  }
}
