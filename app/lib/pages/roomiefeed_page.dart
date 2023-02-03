import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'package:ten_ant/api/response/add_user_response.dart';
import 'package:ten_ant/components/buttons.dart';
import 'package:ten_ant/components/drawer.dart';
import 'package:ten_ant/components/user_view_card.dart';
import 'package:ten_ant/cubits/user_auth.dart';
import 'package:ten_ant/services/remote_data_service.dart';

class RoomieFeedPage extends StatefulWidget {
  final UserAuthCubit userCubit;
  const RoomieFeedPage({super.key, required this.userCubit});

  @override
  State<RoomieFeedPage> createState() => _RoomieFeedPageState();
}

class _RoomieFeedPageState extends State<RoomieFeedPage> {
  List<SwipeItem> swipeCards = [];
  late MatchEngine _matchEngine;
  bool cardsLoaded = false;
  // ignore: non_constant_identifier_names
  int curr_index = 0;
  @override
  void initState() {
    RemoteDataService()
        .getRoomieFeed(widget.userCubit.state.user!.token)
        .then((value) {
      setState(() {
        swipeCards = value
            .map((userDetail) => SwipeItem(
                content: userDetail,
                likeAction: () async {
                  // UserDetails us = (swipeCards[curr_index].content as UserDetails);
                  // String s = us.id!;
                  // await RemoteDataService().roomieFeedback(
                  //     widget.userCubit.state.user!.token,
                  //     s,
                  //     1);
                  // setState(() {
                  //   curr_index++;
                  // });
                },
                nopeAction: () async {
                  // await RemoteDataService().roomieFeedback(
                  //     widget.userCubit.state.user!.token,
                  //     swipeCards[curr_index].content.id,
                  //     -1);
                  // setState(() {
                  //   curr_index++;
                  // });
                }))
            .toList();
        _matchEngine = MatchEngine(swipeItems: swipeCards);
        cardsLoaded = true;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawerWidget(userCubit: widget.userCubit),
      appBar: AppBar(title: const Text('Roomie Feed')),
      body: Column(
        children: [
          (cardsLoaded)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                      SizedBox(
                        height: 550,
                        child: Center(
                          child: SwipeCards(
                            matchEngine: _matchEngine,
                            itemBuilder: (BuildContext context, int index) {
                              UserDetails details =
                                  (swipeCards[index].content as UserDetails);
                              return UserViewCard(details: details);
                            },
                            onStackFinished: () {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text("Stack Finished"),
                                duration: Duration(milliseconds: 500),
                              ));
                            },
                            itemChanged: (SwipeItem item, int index) {},
                            upSwipeAllowed: true,
                            fillSpace: true,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GreenCheckButton(
                              onPress: () async {
                                _matchEngine.currentItem!.like();
                                await RemoteDataService().roomieFeedback(
                                    widget.userCubit.state.user!.token,
                                    swipeCards[curr_index].content.id,
                                    1);
                                  curr_index++;
                                  log('curr_index:' + curr_index.toString());
                              },
                              label: 'Like'),
                          RedCrossedButton(
                              onPress: () async {
                                _matchEngine.currentItem!.nope();
                                // await RemoteDataService().postMessage("63db9abcec70a672e3e00b9d", "63dc94794fe61ffc17305111","Thats a really good house bro!", widget.userCubit.state.user!.token);
                                await RemoteDataService().roomieFeedback(
                                    widget.userCubit.state.user!.token,
                                    swipeCards[curr_index].content.id,
                                    -1);
                                  curr_index++;
                                  log('curr_index:' + curr_index.toString());
                              },
                              label: 'Dislike')
                        ],
                      )
                    ])
              : const Center(child: CircularProgressIndicator()),
        ],
      ),
    );
  }
  // List<SwipeItem> _swipeItems = [];
  // late MatchEngine _matchEngine;
  // GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  // List<String> _names = [];
  // List<Color> _colors = [];

  // bool cardsLoaded = false;

  // @override
  // void initState() {
  //   Future.delayed(Duration(milliseconds: 500), () {
  //     setState(() {
  //       _names = ["Red", "Blue", "Green", "Yellow", "Orange"];
  //       _colors = [
  //         Colors.red,
  //         Colors.blue,
  //         Colors.green,
  //         Colors.yellow,
  //         Colors.orange
  //       ];
  //     });
  //     for (int i = 0; i < _names.length; i++) {
  //       _swipeItems.add(SwipeItem(
  //           content: Content(text: _names[i], color: _colors[i]),
  //           likeAction: () {
  //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //               content: Text("Liked ${_names[i]}"),
  //               duration: Duration(milliseconds: 500),
  //             ));
  //           },
  //           nopeAction: () {
  //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //               content: Text("Nope ${_names[i]}"),
  //               duration: Duration(milliseconds: 500),
  //             ));
  //           },
  //           superlikeAction: () {
  //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //               content: Text("Superliked ${_names[i]}"),
  //               duration: Duration(milliseconds: 500),
  //             ));
  //           },
  //           onSlideUpdate: (SlideRegion? region) async {
  //             print("Region $region");
  //           }));
  //     }

  //     _matchEngine = MatchEngine(swipeItems: _swipeItems);
  //     cardsLoaded = true;
  //   });
  //   super.initState();
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       key: _scaffoldKey,
  //       appBar: AppBar(
  //         title: Text('widget.title'),
  //       ),
  //       body: (cardsLoaded)
  //           ? Container(
  //               child: Column(children: [
  //               Container(
  //                 height: 550,
  //                 child: SwipeCards(
  //                   matchEngine: _matchEngine,
  //                   itemBuilder: (BuildContext context, int index) {
  //                     return Container(
  //                       alignment: Alignment.center,
  //                       color: _swipeItems[index].content.color,
  //                       child: Text(
  //                         _swipeItems[index].content.text,
  //                         style: TextStyle(fontSize: 100),
  //                       ),
  //                     );
  //                   },
  //                   onStackFinished: () {
  //                     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //                       content: Text("Stack Finished"),
  //                       duration: Duration(milliseconds: 500),
  //                     ));
  //                   },
  //                   itemChanged: (SwipeItem item, int index) {
  //                     print("item: ${item.content.text}, index: $index");
  //                   },
  //                   upSwipeAllowed: true,
  //                   fillSpace: true,
  //                 ),
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: [
  //                   ElevatedButton(
  //                       onPressed: () {
  //                         _matchEngine.currentItem!.nope();
  //                       },
  //                       child: Text("Nope")),
  //                   ElevatedButton(
  //                       onPressed: () {
  //                         _matchEngine.currentItem!.superLike();
  //                       },
  //                       child: Text("Superlike")),
  //                   ElevatedButton(
  //                       onPressed: () {
  //                         _matchEngine.currentItem!.like();
  //                       },
  //                       child: Text("Like"))
  //                 ],
  //               )
  //             ]))
  //           : CircularProgressIndicator());
  // }
}

class Content {
  String text = '';
  Color color = Colors.lightBlue;
  Content({required this.text, required this.color});
}
