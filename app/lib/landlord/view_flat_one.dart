import 'package:flutter/material.dart';
import 'package:ten_ant/components/drawer.dart';
import 'package:ten_ant/components/flat_view_card.dart';
import 'package:ten_ant/cubits/user_auth.dart';
import 'package:ten_ant/landlord/stats_flats.dart';
import 'package:ten_ant/models/common.dart';

class ViewSingleFlatPage extends StatefulWidget {
  final Flat flat;
  final UserAuthCubit userCubit;
  const ViewSingleFlatPage(
      {super.key, required this.flat, required this.userCubit});

  @override
  State<ViewSingleFlatPage> createState() => _ViewSingleFlatPageState();
}

class _ViewSingleFlatPageState extends State<ViewSingleFlatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flat 1')),
      drawer: MainDrawerWidget(userCubit: widget.userCubit),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FlatViewCard(data: widget.flat),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return StatsFlats(flat: widget.flat);
                  }));
                },
                child: const Text('View Activity'))
          ],
        ),
      ),
    );
  }
}
