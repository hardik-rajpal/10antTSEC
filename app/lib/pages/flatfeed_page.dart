import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ten_ant/api/forum_msg.dart';
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
  String userIDToken = '';
  bool flatsLoaded = false;

  final TextEditingController _mainTextController = TextEditingController();
  @override
  void initState() {
    super.initState();
    LocalDataService().getUserIDToken().then((useridToken) {
      if (useridToken == null) {
        Navigator.of(context).popAndPushNamed(MainDrawer.auth);
      } else {
        userIDToken = useridToken;
        if (userIDToken.isEmpty) {
          userIDToken = widget.userCubit.state.user!.uuid;
          useridToken = userIDToken;
        }
        RemoteDataService().getUserGroups(useridToken).then((ingroups) {
          log('ingroups len: ${ingroups.length}for: $useridToken');
          RemoteDataService()
              .getFlatFeed(ingroups[0].id, useridToken!)
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
                          enableInfiniteScroll: false,
                        ),
                        items: flats[groupID]
                            .map((flat) => Builder(
                                  builder: (context) {
                                    return SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: [
                                          FlatViewCard(data: flat),
                                          _buildForum(
                                              flat.id,
                                              groups[groupID].id,
                                              userIDToken,
                                              flat.forum),
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
      RemoteDataService().registerFeedback(widget.userCubit.state.user!.uuid,
          flat.id, _feedbackTextController.text, 1);
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

  _buildForum(
      String flatid, String groupid, String userIDToken, List<ForumMsg> forum) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const Text(
        'Discussion Forum',
        style: Styles.textStyle1,
      ),
      ...forum
          .map((e) => Card(
                child: Text('${e.sender}: ${e.message}'),
              ))
          .toList(),
      Container(
        color: Colors.blue,
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // color: Colors.white,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50)),
                  child: TextField(
                    controller: _mainTextController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(5),
                      border: InputBorder.none,
                      hintText: 'Enter new words here',
                    ),
                  ),
                ),
              ),
            ),
            IconButton(
                onPressed: () async {
                  RemoteDataService().postMessage(
                      flatid, groupid, _mainTextController.text, userIDToken);
                  _mainTextController.clear();
                },
                icon: const FaIcon(
                  FontAwesomeIcons.paperPlane,
                ))
          ],
        ),
      )
    ]);
  }
}
