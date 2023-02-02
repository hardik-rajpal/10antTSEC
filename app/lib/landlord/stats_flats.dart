import 'package:flutter/material.dart';
import 'package:ten_ant/components/buttons.dart';
import 'package:ten_ant/models/common.dart';
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

  final TextEditingController _queryController = TextEditingController();

  String queryStr = '';
  @override
  void initState() {
    _queryController.addListener(() {
      setState(() {
        queryStr = _queryController.text;
      });
    });
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
      body: (statnums.isEmpty)
          ? (const CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('User Response:', style: Styles.textStyleHeading),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      StatCountButton(
                          icon: Styles.likeIcon, userCount: statnums[0]),
                      StatCountButton(
                          icon: Styles.dislikeIcon, userCount: statnums[1]),
                      StatCountButton(
                          icon: Styles.questionMark, userCount: statnums[2])
                    ],
                  ),
                  const Text(
                    'Feedback: ',
                    style: Styles.textStyleHeading,
                  ),
                  TextField(
                    controller: _queryController,
                    decoration: const InputDecoration(
                        hintText: 'Search for keywords...'),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: reviews
                          .where((element) =>
                              element.toLowerCase().contains(queryStr))
                          .map((review) => Card(
                                  child: Text(
                                review,
                                style: Styles.textStyle1,
                              )))
                          .toList(),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
