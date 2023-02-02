import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ten_ant/components/flat_view_card.dart';
import 'package:ten_ant/cubits/user_auth.dart';
import 'package:ten_ant/models/common.dart';
import 'package:ten_ant/services/remote_data_service.dart';
import 'package:ten_ant/utils/constants.dart';
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
  ];
  List<Flat> flats = [];
  bool feadLoaded = false;
  @override
  void initState() {
    super.initState();
    RemoteDataService()
        .getUserGroups(widget.userCubit.state.user!.uuid)
        .then((ingroups) {
      RemoteDataService().getFlatFeed(ingroups[0].uuid).then((value) {
        setState(() {
          flats = value;
          groups = ingroups;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flat Feed'),
      ),
      body: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text('Mode: ', style: Styles.textStyle1),
            DropdownButton<String>(
                value: groups[groupID].uuid,
                icon: const FaIcon(FontAwesomeIcons.arrowDown),
                items: groups
                    .map((e) => DropdownMenuItem<String>(
                        value: e.uuid,
                        child: Text(e.name, style: Styles.textStyle1)))
                    .toList(),
                onChanged: (choice) {
                  setState(() {
                    if (choice != null) {
                      groupID = groups
                          .indexWhere((element) => element.uuid == choice);
                    }
                    return;
                  });
                })
          ],
        ),
        Expanded(
          child: CarouselSlider(
            options: CarouselOptions(height: double.infinity),
            items: flats
                .map((flat) => Builder(
                      builder: (context) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: FlatViewCard(
                              data: flat,
                            ),
                          ),
                        );
                      },
                    ))
                .toList(),
          ),
        )
      ]),
    );
  }
}
