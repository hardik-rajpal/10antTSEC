import 'package:flutter/material.dart';
import 'package:ten_ant/api/request/add_flat_request.dart';
import 'package:ten_ant/services/remote_data_service.dart';

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
    RemoteDataService().getFlatStats(widget.flat.id).then((value) {
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
            children: const [
              // ReactionCountButton(icon: Styles.likeIcon, userList: )
            ],
          )
        ],
      ),
    );
  }
}
