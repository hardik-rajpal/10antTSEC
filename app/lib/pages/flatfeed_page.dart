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
  List<Group> groups = [
    // Group(UtilFuncs.getUUID(), 'Me', ['...']),
  ];
  List<Flat> flats = [];
  bool feadLoaded = false;
  @override
  void initState() {
    super.initState();
    RemoteDataService()
        .getUserGroups(widget.userCubit.state.user!.uuid)
        .then((ingroups) {
      RemoteDataService().getFlatFeed(ingroups[0].id).then((value) {
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
      drawer: MainDrawerWidget(userCubit: widget.userCubit),
      appBar: AppBar(
        title: const Text('Flat Feed'),
      ),
      body: Column(children: [
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
        Expanded(
          child: CarouselSlider(
            options: CarouselOptions(height: double.infinity),
            items: flats
                .map((flat) => Builder(
                      builder: (context) {
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: FlatViewCard(
                                  data: flat,
                                ),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ReactionCountButton(
                                      icon: Styles.likeIcon,
                                      userList:
                                          flat.likeDislikeQuestionArray[0],
                                    ),
                                    ReactionCountButton(
                                        icon: Styles.dislikeIcon,
                                        userList:
                                            flat.likeDislikeQuestionArray[1]),
                                    ReactionCountButton(
                                      icon: Styles.questionMark,
                                      userList:
                                          flat.likeDislikeQuestionArray[2],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  RedCrossedButton(
                                      onPress: () {
                                        showReviewDialog(context, flat);
                                      },
                                      label: 'Dislike'),
                                  GreenCheckButton(
                                      onPress: () {
                                        showReviewDialog(context, flat);
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
      ]),
    );
  }

  void showReviewDialog(BuildContext context, Flat flat) {
    singleTextFieldDialog('Feedback', context, _feedbackTextController, () {
      RemoteDataService().submitUserFlatInteraction(
          widget.userCubit.state.user!.uuid, flat.id);
      UIFuncs.toast(context: context, text: 'Review submitted');
    }, goLabel: 'Submit');
  }
}
