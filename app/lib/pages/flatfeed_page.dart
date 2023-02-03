import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ten_ant/api/request/add_flat_request.dart';
import 'package:ten_ant/api/response/get_group_response.dart';
import 'package:ten_ant/components/buttons.dart';
import 'package:ten_ant/components/dialog.dart';
import 'package:ten_ant/components/drawer.dart';
import 'package:ten_ant/components/flat_view_card.dart';
import 'package:ten_ant/cubits/user_auth.dart';
import 'package:ten_ant/services/local_data_service.dart';
import 'package:ten_ant/services/remote_data_service.dart';
import 'package:ten_ant/utils/constants.dart';
import 'package:ten_ant/utils/uifuncs.dart';

class FlatFeedPage extends StatefulWidget {
  final UserAuthCubit userCubit;
  const FlatFeedPage({super.key, required this.userCubit});

  @override
  State<FlatFeedPage> createState() => _FlatFeedPageState();
}

class _FlatFeedPageState extends State<FlatFeedPage> {
  int groupID = 0;
  final TextEditingController _feedbackTextController = TextEditingController();
  List<Group> groups = [];
  List<List<Flat>> flats = [];
  bool groupsLoaded = false;

  bool flatsLoaded = false;
  @override
  void initState() {
    super.initState();
    LocalDataService().getUserIDToken().then((useridToken) {
      if (useridToken == null) {
        Navigator.of(context).popAndPushNamed(MainDrawer.auth);
      } else {
        RemoteDataService().getUserGroups(useridToken).then((ingroups) {
          log('ingroups len: ${ingroups.length}for: $useridToken');
          RemoteDataService()
              .getFlatFeed(ingroups[0].id, useridToken)
              .then((value) {
            setState(() {
              groups = ingroups;
              groupsLoaded = true;
              _loadflats();
              log('flats length${flats.length}');
            });
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawerWidget(userCubit: widget.userCubit),
      appBar: AppBar(
        title: const Text('Flat Feed'),
      ),
      body: (groupsLoaded)
          ? Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('Mode: ', style: Styles.textStyle1),
                  DropdownButton<String>(
                      value: groups[groupID].id,
                      icon: const FaIcon(FontAwesomeIcons.arrowDown),
                      items: groups
                          .map((e) => DropdownMenuItem<String>(
                              value: e.id,
                              child: Text(e.name, style: Styles.textStyle1)))
                          .toList(),
                      onChanged: (choice) {
                        setState(() {
                          if (choice != null) {
                            groupID = groups
                                .indexWhere((element) => element.id == choice);
                          }
                          return;
                        });
                      })
                ],
              ),
              (flatsLoaded)
                  ? Expanded(
                      child: CarouselSlider(
                        options: CarouselOptions(
                            height: double.infinity,
                            enableInfiniteScroll: false),
                        items: flats[groupID]
                            .map((flat) => Builder(
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: [
                                          FlatViewCard(data: flat),
                                          ReactionCountButton(
                                            icon: Styles.likeIcon,
                                            userList: flat.likeArray,
                                          ),
                                          ReactionCountButton(
                                              icon: Styles.dislikeIcon,
                                              userList: flat.dislikeArray),
                                          Row(
                                            children: [
                                              Styles.likeIcon,
                                              // Text()
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              RedCrossedButton(
                                                  onPress: () {
                                                    showReviewDialog(
                                                        context, flat);
                                                  },
                                                  label: 'Dislike'),
                                              GreenCheckButton(
                                                  onPress: () {
                                                    showReviewDialog(
                                                        context, flat);
                                                  },
                                                  label: 'Like')
                                            ],
                                          )
                                        ],
                                      ),
                                    );
                                  },
                                ))
                            .toList(),
                      ),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    )
            ])
          : const Center(child: CircularProgressIndicator()),
    );
  }

  void showReviewDialog(BuildContext context, Flat flat) {
    singleTextFieldDialog('Feedback', context, _feedbackTextController, () {
      RemoteDataService().registerFeedback(
          widget.userCubit.state.user!.uuid, flat.id, _feedbackTextController.text, 1);
      UIFuncs.toast(context: context, text: 'Review submitted');
    }, goLabel: 'Submit');
  }

  void _loadflats() async {
    for (int i = 0; i < groups.length; i++) {
      flats.add(await RemoteDataService()
          .getFlatFeed(groups[i].id, widget.userCubit.state.user!.token));
    }
    Flat f = Flat();
    f.pictures = [
      Values.imagePlaceholder,
      Values.imagePlaceholder,
      Values.imagePlaceholder
    ];
    f.bhk = 3;
    f.amenities = ['Sports Club', 'Hospital'];
    f.area = 3400;
    f.contact = 'Contact Details';
    f.description = 'Nice lampin spot.';
    f.dislikeArray = [];
    // f.likeArray = []
    // flats = [f];
    setState(() {
      flatsLoaded = true;
    });
  }
}
