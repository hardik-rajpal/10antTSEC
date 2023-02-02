import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:ten_ant/components/buttons.dart';
import 'package:ten_ant/components/drawer.dart';
import 'package:ten_ant/models/common.dart';
import 'package:ten_ant/pages/flatfeed_page.dart';
import 'package:ten_ant/services/remote_data_service.dart';
import 'package:ten_ant/utils/constants.dart';

class StatsFlats extends StatefulWidget {
  final Flat flat;
  const StatsFlats({super.key, required this.flat});

  @override
  State<StatsFlats> createState() => _StatsFlatsState();
}

class _StatsFlatsState extends State<StatsFlats> {
  List<String> reviews = [];
  List<int> statnums = [];
  @override
  void initState() {
    RemoteDataService().getFlatStats(widget.flat.uuid).then((value) {
      setState(() {
        reviews = value.reviews;
        statnums = value.statnums;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flat Stats'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              // ReactionCountButton(icon: Styles.likeIcon, userList: )
            ],
          )
        ],
      ),
    );
  }
}
