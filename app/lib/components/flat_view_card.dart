import 'package:flutter/material.dart';
import 'package:ten_ant/api/request/add_flat_request.dart';
import 'package:ten_ant/utils/constants.dart';

class FlatViewCard extends StatefulWidget {
  final Flat data;
  const FlatViewCard({super.key, required this.data});

  @override
  State<FlatViewCard> createState() => _FlatViewCardState();
}

class _FlatViewCardState extends State<FlatViewCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.street,
            style: Styles.textStyleHeading,
          ),
          ...widget.data.pictures
              .map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.network(e),
                  ))
              .toList(),
          Text(
            'Address: ${widget.data.location}',
            style: Styles.textStyle1,
          ),
        ],
      ),
    );
  }
}
